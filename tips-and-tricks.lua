-- Tips and tricks with Lua scripts - bfxdev 2020

-- Lists global variables
for key, value in pairs(_G) do
  print("Global " .. type(value) .. ": " .. key .. " = " .. tostring(value))
end


--- Returns a data URI representing a BMP RGBA picture of dimension `width` and `height`, and with bitmap `data` provided
--- as a one-dimensional array of 32-bits numbers (in order MSB to LSB Alpha-Red-Green-Blue) row-by-row starting on
--- the top-left corner.
--- @param width number
--- @param height number
--- @param data table
--- @return string
-- See https://docs.microsoft.com/en-us/windows/win32/gdi/bitmap-storage
-- See https://en.wikipedia.org/wiki/BMP_file_format#Example_2
function encode_bitmap_as_URI(width, height, data)
  
  -- Converts binary string to base64 from http://lua-users.org/wiki/BaseSixtyFour
  function encode_base64(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
      local r,b='',x:byte()
      for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
      return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
      if (#x < 6) then return '' end
      local c=0
      for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
      return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
  end
  
  -- Packs 32-bits unsigned int into a string with little-endian encoding
  function pu32(v)
    return string.char(v%256, math.floor(v/256)%256, math.floor(v/65536)%256, math.floor(v/0x1000000)%256)
  end
  
  -- Prepared as table and then concatenated for performance
  local bmp = {}
  
  -- BITMAPFILEHEADER see https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapfileheader
  table.insert(bmp, "BM" .. pu32(width*height*4 + 122) .. pu32(0) .. pu32(122))
  
  -- BITMAPV4HEADER see https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapv4header
  table.insert(bmp, pu32(108) .. pu32(width) .. pu32(height) .. pu32(0x200001) .. pu32(3))
  table.insert(bmp, pu32(width*height*4) .. pu32(2835) .. pu32(2835) .. pu32(0) .. pu32(0))
  table.insert(bmp, pu32(0xFF0000) .. pu32(0xFF00) .. pu32(0xFF) .. pu32(0xFF000000) .. "Win ")
  for i = 1,12 do table.insert(bmp, pu32(0)) end
  
  -- Bitmap data (it starts with the lower left hand corner of the image)
  local offset
  for y = (height-1),0,-1 do
    offset = 1 + y*width
    for x = 0,(width-1) do
      table.insert(bmp, pu32(data[offset + x]))
    end
  end
  
  -- Finishes string
  bmp = table.concat(bmp, "")
  
  return "data:image/bmp;base64," .. encode_base64(bmp)
end


local alien="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAVCAYAAACkCdXRAAAAAXNSR0IArs4c6QAAAARnQU1BAACxj"..
"wv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAADwSURBVDhPtZQxDsIwDEUDYoSBHWhHbsPC2tOxsnAbxhbYGWBEAn0rBid20lDBk1BS17z+hBT3"..
"S0Z+TFItq6efuu7cZfuTN1ky26/d9XCh2mR3pzElNYsQQSJhIYDUEqqCJWL6hGM/EjlRzKOZBvsJ3uZSkUwHZMIgWQnzzcLPNGTkVLftkYqMlTT"..
"uwXI5nUrWnlr6gPiLfC17JOYy61XtZx+BFMv7EiXjRuvJsmYJSYb14slyj6zmuCb3C9cq2TfnLCY4wSVnLfcWmD/AUIJkIJeu791UMmAJB/1rMB"..
"BihJRFkABLBJIyhqUgJfkDzr0Amw2KoGT2/LMAAAAASUVORK5CYII="

local description = [[
<center><h2>Tips and tricks for Lua scripts</h2></center>
<center><img width=38 height=42 src=']] .. alien .. [['/></center>
<center><a href="https://github.com/bfxdev/OBS">bfxdev</a> - 2020</center>
<p>Example code attached to the <a href=
"https://obsproject.com/forum/threads/tips-and-tricks-for-lua-scripts.132256/">
OBS Forum Thread "Tips and tricks for Lua scripts"</a>. You can format the description
with <strong>strong</strong>, <code>code</code>, <kbd>kbd</kbd> or 
<a href="https://doc.qt.io/qt-5/richtext-html-subset.html">whatever is supported by QT</a>.<hr/></p>]]

-- Description displayed on the Tools->Scripts window
function script_description()
    return description
end


-- Called upon settings initialization and modification
my_settings = nil
function script_update(settings)
  -- Keep track of current settings
  my_settings = settings  
end

-- Displays a list of properties
function script_properties()

  local properties = obslua.obs_properties_create()

  -- Combo list filled with the options from MY_OPTIONS
  local p = obslua.obs_properties_add_list(properties, "mode", "My list",
              obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
  MY_OPTIONS = {"Mode 1", "Mode 2"}
  for i,v in ipairs(MY_OPTIONS) do
    obslua.obs_property_list_add_int(p, v, i)
  end

  -- Sets callback upon modification of the list
  obslua.obs_property_set_modified_callback(p, set_visibility)

  -- Integer option to be displayed in Mode 1
  obslua.obs_properties_add_int(properties, "mynumber", "My number in Mode 1", 1, 10, 1)

  -- Color option to be displayed in Mode 2
  obslua.obs_properties_add_color(properties, "mycolor", "My color in Mode 2")

  -- Picture file option
  p = obslua.obs_properties_add_path(properties, "mypicture", "My picture", obslua.OBS_PATH_FILE,
    "Picture (*.png *.bmp)", nil)
  obslua.obs_property_set_modified_callback(p, set_picture_description)

  -- Calls the callback once to set-up current visibility
  obslua.obs_properties_apply_settings(properties, my_settings)
  
  return properties
end

-- Callback on list modification
function set_visibility(props, property, settings)

  -- Retrieves value selected in list
  local mode = obslua.obs_data_get_int(settings, "mode")
  
  -- Preset parameters
  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "mynumber"), mode==1)
  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "mycolor"), mode==2)

  -- IMPORTANT: returns true to trigger refresh of the properties
  return true
end

-- Callback on picture selection
function set_picture_description(props, property, settings)
  local path = obslua.obs_data_get_string(settings, "mypicture")
  local desc = "<span valign=middle>My picture <img height=18 src='file:" .. path .. "'/></span>"
  obslua.obs_property_set_description(property, desc)
  return true
end


-- Simple transformation of string into hexadecimal
function hex_dump(buf)
  local res = ""
  for i = 1,string.len(buf) do
    res = res .. string.format( "%02x ", string.byte(buf, i))
  end
  return res
end

-- Proof-of-concept bitmap encoding as URI
print("--------------------------- BMP encoding into Data URI from data table")
local uri = encode_bitmap_as_URI(3, 2, {0xFF0000FF, 0xFFFFFFFF, 0xFFFF0000, 0x7F0000FF, 0x7FFFFFFF, 0x7FFF0000})
obslua.obs_enter_graphics()
local image = obslua.gs_image_file()
obslua.gs_image_file_init(image, uri)
print("Data URI image: cx=" .. tostring(image.cx) .. "  cy=" .. tostring(image.cy))
obslua.gs_image_file_free(image)
obslua.obs_leave_graphics()

-- Use os_get_config_path by providing a long string as pre-allocated buffer
print("--------------------------- Use of os_get_config_path")
local dst = "                                                                                                "
print("Before call to os_get_config_path: dst=" .. dst)
obslua.os_get_config_path(dst, #dst, "OBS\\sceneCollection\\")
print("After call to os_get_config_path: dst=" .. dst)

-- Uses FFI
local ffi = require("ffi")

-- Retrieving texture_data from gs_image_file
print("--------------------------- obslua image from Data URI and retrieval of data with FFI (not working for now)")
obslua.obs_enter_graphics()
local image = obslua.gs_image_file()
obslua.gs_image_file_init(image, uri) -- "https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png") -- "D:\\bfxdev\\OBS\\pics\\apple.jpg")
print("obslua image size " .. tostring(image.cx) .. " x " .. tostring(image.cy))
print("image " .. tostring(image) .. " - swig_type " .. swig_type(image))
print("texture_data " .. tostring(image.texture_data) .. " - swig_type " .. swig_type(image.texture_data))
-- print("texture_data:__deref__() " .. tostring(image.texture_data:__deref__()) .. " - swig_type " .. swig_type(image.texture_data:__deref__()))
print("tonumber(image.texture_data) " .. tostring(tonumber(image.texture_data)))
local address = ffi.cast("uint8_t*", image.texture_data)[0]
print("address=" .. string.format("%x", address))
-- The address is an int pointing to the buffer, but I fund no way o get its data directly
-- local ptr = ffi.new("uint8_t[1]", address)
-- print(string.format("First 2 bytes of the buffer: %02x %02x", ptr[0], ptr[1]))
-- local str = ffi.string(ptr, image.cx*image.cy*4)
-- if str then print("Image data as string: " .. hex_dump(str)) end
obslua.obs_leave_graphics()


--print("--------------------------- obsffi global variables")
local obsffi = ffi.load(ffi.os == "OSX" and "obs.0.dylib" or "obs")
--for key, value in pairs(obsffi) do
--  print("Global " .. type(value) .. ": " .. key .. " = " .. tostring(value))
--end

-- Retrieving texture_data from gs_image_file with FFI
ffi.cdef([[
  enum gs_color_format {GS_UNKNOWN};
  typedef enum {GIF_OK = 0} gif_result;

  typedef void* (*gif_bitmap_cb_create)(int width, int height);
  typedef void (*gif_bitmap_cb_destroy)(void *bitmap);
  typedef unsigned char* (*gif_bitmap_cb_get_buffer)(void *bitmap);
  typedef void (*gif_bitmap_cb_set_opaque)(void *bitmap, bool opaque);
  typedef bool (*gif_bitmap_cb_test_opaque)(void *bitmap);
  typedef void (*gif_bitmap_cb_modified)(void *bitmap);
  typedef struct gif_bitmap_callback_vt
  {
    gif_bitmap_cb_create bitmap_create; 
    gif_bitmap_cb_destroy bitmap_destroy;
    gif_bitmap_cb_get_buffer bitmap_get_buffer;
    gif_bitmap_cb_set_opaque bitmap_set_opaque;
    gif_bitmap_cb_test_opaque bitmap_test_opaque;
    gif_bitmap_cb_modified bitmap_modified;
  } gif_bitmap_callback_vt;
  
  typedef struct gif_frame gif_frame;

  typedef struct gif_animation
  {
    gif_bitmap_callback_vt bitmap_callbacks;
    unsigned char *gif_data;
    unsigned int width;
    unsigned int height;
    unsigned int frame_count;
    unsigned int frame_count_partial;
    gif_frame *frames;
    int decoded_frame;
    void *frame_image;
    int loop_count;
    gif_result current_error;

    unsigned int buffer_position;
    unsigned int buffer_size;
    unsigned int frame_holders;
    unsigned int background_index;
    unsigned int aspect_ratio;
    unsigned int colour_table_size;
    bool global_colours;
    unsigned int *global_colour_table;
    unsigned int *local_colour_table;
  
    unsigned char buf[4];
    unsigned char *direct;

    int table[2][(1 << 12)];
    unsigned char stack[(1 << 12) * 2];
    unsigned char *stack_pointer;
    int code_size, set_code_size;
    int max_code, max_code_size;
    int clear_code, end_code;
    int curbit, lastbit, last_byte;
    int firstcode, oldcode;
    bool zero_data_block;
    bool get_done;
    bool clear_image;

  } gif_animation;

typedef struct gs_texture gs_texture_t;

typedef struct gs_image_file
{
  gs_texture_t *texture;
  enum gs_color_format format;
  uint32_t cx;
  uint32_t cy;
  bool is_animated_gif;
  bool frame_updated;
  bool loaded;

  gif_animation gif;
  uint8_t *gif_data;
  uint8_t **animation_frame_cache;
  uint8_t *animation_frame_data;
  uint64_t cur_time;
  int cur_frame;
  int cur_loop;
  int last_decoded_frame;

  uint8_t *texture_data;
  gif_bitmap_callback_vt bitmap_callbacks;
} gs_image_file_t;

void gs_image_file_init(gs_image_file_t *image, const char *file);
void gs_image_file_free(gs_image_file_t *image);

]])

print("--------------------------- FFI image from Data URI")
obslua.obs_enter_graphics()
local image = ffi.new("gs_image_file_t[1]")
obsffi.gs_image_file_init(image, uri)
print("FFI image size " .. tostring(image[0].cx) .. " x " .. tostring(image[0].cy))
print(string.format("First 2 bytes of the buffer: %02x %02x", image[0].texture_data[0], image[0].texture_data[1]))
local str = ffi.string(image[0].texture_data, image[0].cx*image[0].cy*4)
print("Image data as string: " .. hex_dump(str))
obsffi.gs_image_file_free(image)
obslua.obs_leave_graphics()


EFFECT_LUMINANCE = [[
uniform float4x4 ViewProj; // View-projection matrix set by OBS (required)
uniform texture2d image; // Texture containing source picture set by OBS (required)
sampler_state linear_clamp { Filter=Linear; AddressU=Clamp; AddressV=Clamp;};
struct shader_data {float4 pos : POSITION; float2 uv : TEXCOORD0;};

shader_data vertex_shader_default(shader_data cur)
{
  shader_data res;
  res.pos = mul(float4(cur.pos.xyz, 1.0), ViewProj);
  res.uv  = cur.uv;
  return res;
}

float4 pixel_shader_luminance(shader_data cur) : TARGET
{
  bla();
  float4 smp = image.Sample(linear_clamp, cur.uv);
  float luminance = 0.299*smp.r + 0.587*smp.g + 0.114*smp.b;
  return float4(luminance, luminance, luminance, smp.a);
}

technique Draw
{
  pass
  {
    vertex_shader = vertex_shader_default(cur);
    pixel_shader  = pixel_shader_luminance(cur);
  }
}
]]

--[[ Classical effect compilation 
obslua.obs_enter_graphics()
local effect = obslua.gs_effect_create(EFFECT_LUMINANCE, "luminance", nil)
if effect then
  print("Effect created with obslua binding!")
  obslua.gs_effect_destroy(effect)
 end
obslua.obs_leave_graphics()]]


-- Effect compilation with FFI
print("--------------------------- Effect creation with FFI")
ffi.cdef([[
  struct gs_effect;
  typedef struct gs_effect gs_effect_t;
  gs_effect_t *gs_effect_create(const char *effect_string, const char *filename, char **error_string);
  void gs_effect_destroy(gs_effect_t *effect);
]])

local my_error_string = ffi.new("char*[1]")
print("my_error_string type=" .. type(my_error_string[0]) .. " swig_type=" .. swig_type(my_error_string[0]))
print("my_error_string tostring(my_error_string)=" .. tostring(my_error_string[0]))
print("my_error_string tostring(my_error_string[1])=" .. tostring(my_error_string[0]))
obslua.obs_enter_graphics()

local effect = obsffi.gs_effect_create(EFFECT_LUMINANCE, "luminance", my_error_string)
if effect then
  print("Effect created with FFI!")
  obsffi.gs_effect_destroy(effect)
end

print("my_error_string type=" .. type(my_error_string[0]) .. " swig_type=" .. swig_type(my_error_string[0]))
print("my_error_string tostring(my_error_string)=" .. tostring(my_error_string[0]))
print("my_error_string tostring(my_error_string[1])=" .. tostring(my_error_string[0]))

obslua.obs_leave_graphics()

-- https://obsproject.com/forum/threads/how-to-enumerate-script-properties-in-lua.83406/#post-397381
-- create source with name tmp , then add Color Correction filter named color
local obs = obslua
ffi.cdef([[
//struct obs_source;
//struct obs_properties;
//struct obs_property;
// Structures
typedef struct obs_source obs_source_t;
typedef struct obs_properties obs_properties_t;
typedef struct obs_property obs_property_t;

// Functions
obs_source_t *obs_get_source_by_name(const char *name);
obs_source_t *obs_source_get_filter_by_name(obs_source_t *source, const char *name);
obs_properties_t *obs_source_properties(const obs_source_t *source);
obs_property_t *obs_properties_first(obs_properties_t *props);
bool obs_property_next(obs_property_t **p);
const char *obs_property_name(obs_property_t *p);
void obs_properties_destroy(obs_properties_t *props);
void obs_source_release(obs_source_t *source);
]])


local function filterTest()
  print("--------------------------- Enumeration of filter properties with FFI")
  local source = obsffi.obs_get_source_by_name("tmp")
  if source then
    local fSource = obsffi.obs_source_get_filter_by_name(source, "color")
    if fSource then
      local props = obsffi.obs_source_properties(fSource)
      if props then
        local prop = obsffi.obs_properties_first(props)
        local name = obsffi.obs_property_name(prop)
        if name then
          local propCount = 1

          obs.script_log(obs.LOG_INFO, string.format("Property 1 = %s", ffi.string(name)))

          local _p = ffi.new("obs_property_t *[1]", prop)
          local foundProp = obsffi.obs_property_next(_p)
          prop = ffi.new("obs_property_t *", _p[0])
          while foundProp do
            propCount = propCount + 1
            name = obsffi.obs_property_name(prop)

            obs.script_log(obs.LOG_INFO, string.format("Property %d = %s", propCount, ffi.string(name)))

            _p = ffi.new("obs_property_t *[1]", prop)
            foundProp = obsffi.obs_property_next(_p)
            prop = ffi.new("obs_property_t *", _p[0])
          end
        end
        obsffi.obs_properties_destroy(props)
      end
      obsffi.obs_source_release(fSource)
    end
    obsffi.obs_source_release(source)
  end
end

function on_event(event)
  if event == obs.OBS_FRONTEND_EVENT_FINISHED_LOADING  then
    filterTest()
  end
end

function script_load(settings)
  obs.obs_frontend_add_event_callback(on_event)
end
