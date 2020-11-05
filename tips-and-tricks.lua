-- Tips and tricks with Lua scripts - bfxdev 2020

-- Lists global variables
for key, value in pairs(_G) do
  print("Global " .. type(value) .. ": " .. key .. " = " .. tostring(value))
end


--- Returns a data URL representing a BMP RGBA picture of dimension `width` and `height`, and with bitmap `data` provided
--- as a one-dimensional array of 32-bits numbers (in order MSB to LSB Alpha-Red-Green-Blue) row-by-row starting on
--- the top-left corner.
--- @param width number
--- @param height number
--- @param data table
--- @return string
-- See https://docs.microsoft.com/en-us/windows/win32/gdi/bitmap-storage
-- See https://en.wikipedia.org/wiki/BMP_file_format#Example_2
function encode_bitmap_as_URL(width, height, data)
  
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
  function pu32(v) return string.char(v%256, (v/256)%256, (v/65536)%256, (v/0x1000000)%256) end
  
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

-- Proof-of-concept bitmap encoding as URL
local url = encode_bitmap_as_URL(3, 2, {0xFF0000FF, 0xFFFFFFFF, 0xFFFF0000, 0x7F0000FF, 0x7FFFFFFF, 0x7FFF0000})
obslua.obs_enter_graphics()
local image = obslua.gs_image_file()
obslua.gs_image_file_init(image, url)
print("Data URL image: cx=" .. tostring(image.cx) .. "  cy=" .. tostring(image.cy))
obslua.gs_image_file_free(image)
obslua.obs_leave_graphics()

-- Use os_get_config_path by providing a long string as pre-allocated buffer
local dst = "                                                                                                "
print("Before call to os_get_config_path: dst=" .. dst)
obslua.os_get_config_path(dst, #dst, "OBS\\sceneCollection\\")
print("After call to os_get_config_path: dst=" .. dst)

ffi = require("ffi")

-- Setting arbitrary texture_data in gs_image_file
obslua.obs_enter_graphics()
local image = obslua.gs_image_file()
image.cx = 1
image.cy = 1
local buffer = ffi.new("uint8_t[?]", 4)
-- image.texture_data = buffer
print("swig_type(image) " .. swig_type(image))
print("size " .. tostring(image.cx) .. "," .. tostring(image.cy))

--local str = ffi.string(image.texture_data, image.cx*image.cy*4)
--if str then print("Image data as string: " .. hex_dump(str)) end

obslua.obs_leave_graphics()


-- Retrieving texture_data from gs_image_file
obslua.obs_enter_graphics()
local image = obslua.gs_image_file()
print("swig_type(image) " .. swig_type(image))
obslua.gs_image_file_init(image, url)
print("swig_type(image) " .. swig_type(image))
-- print("size " .. tostring(image.cx) .. "," .. tostring(image.cy))
-- print("texture_data " .. tostring(image.texture_data) .. " - swig_type " .. swig_type(image.texture_data))
local str = ffi.string(image.texture_data, image.cx*image.cy*4)
if str then print("Image data as string: " .. hex_dump(str)) end
obslua.obs_leave_graphics()

