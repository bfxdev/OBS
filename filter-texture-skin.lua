------------------------------------------------------------------------------------------------------------------------
--                                                                                                                    --
--                              Skin Texture filter for OBS the Open Broadcaster Software                             --
--                                                                                                                    --
--                                    By bfxdev - https://github.com/bfxdev - 2020                                    --
--                                                                                                                    --
------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------- GLOBAL LOG FUNCTIONS ------------------------------------------------

--- List of log levels used for display and property selection
LOG_LEVEL_NAMES = {"Debug", "Info", "Warning", "Error", "Nothing"}

--- Global log level
log_level = 3

--- Maximum recursion level for `as_string` function
MAX_PARSE_DEPTH = 10
--- Recursive transformation of any object to string (with max depth)
function as_string(content, depth)
  -- Result of the function
  local res
  
  -- Lists all elements of a table
  if type(content) == "table" then
    res = "{"
    for k,v in pairs(content) do
      if string.len(res) > 1 then res = res .. "," end
      res = res .. k .. "="
      if depth < MAX_PARSE_DEPTH then
        res = res  .. as_string(v, depth+1)
      else
        res = res  .. tostring(v)
      end
    end
    res = res .. "}"
    
    -- Type string
  elseif type(content) == "string" then
    res =  tostring(content)
    if depth > 0 then
      res = "\"" .. res .. "\""
    end
    
  else
    res =  tostring(content)
  end
  
  return res
end

--- Main log function (do not use directly) with parameter `level` to track if we are at level 0 (not quotes on string)
--- and avoid infinite recursions, multiple arguments `...` displayed with spaces between them (python-like)
function log(level, ...)
  if log_level<= level then
    local str = string.upper(LOG_LEVEL_NAMES[level]) .. ":"
    for k,v in pairs({...}) do
      str = str .. " " .. as_string(v, 0)
    end
    print(str)
  end
end

--- Logs at debug level
function log_debug(...)   log(1, ...) end
--- Logs at info level
function log_info(...)    log(2, ...) end
--- Logs at warning level
function log_warning(...) log(3, ...) end
--- Logs at error level
function log_error(...)   log(4, ...) end

------------------------------------------------- GLOBAL SCRIPT FUNCTIONS ----------------------------------------------

-- Initial call sequence: script_defaults, script_description, script_load, script_update, script_properties
-- See https://obsproject.com/docs/scripting.html#script-function-exports

-- Called to retrieve the description string and display it in the script management dialog
-- NOTE: not documented
function script_description()
  log_debug("Entering script_description")
  
  local alien="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAVCAYAAACkCdXRAAAAAXNSR0IArs4c6QAAAARnQU1BAACxj"..
  "wv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAADwSURBVDhPtZQxDsIwDEUDYoSBHWhHbsPC2tOxsnAbxhbYGWBEAn0rBid20lDBk1BS17z+hBT3"..
  "S0Z+TFItq6efuu7cZfuTN1ky26/d9XCh2mR3pzElNYsQQSJhIYDUEqqCJWL6hGM/EjlRzKOZBvsJ3uZSkUwHZMIgWQnzzcLPNGTkVLftkYqMlTT"..
  "uwXI5nUrWnlr6gPiLfC17JOYy61XtZx+BFMv7EiXjRuvJsmYJSYb14slyj6zmuCb3C9cq2TfnLCY4wSVnLfcWmD/AUIJkIJeu791UMmAJB/1rMB"..
  "BihJRFkABLBJIyhqUgJfkDzr0Amw2KoGT2/LMAAAAASUVORK5CYII="
  
  local description = [[<center><h2>Texture Skin Filter</h2></center>
  <center><img width=38 height=42 src=']] .. alien .. [['/><br/>
  <a href="https://github.com/bfxdev/OBS">bfxdev</a> - 2020</center>
  <p>This Lua script adds a new filter named "Texture Skin". It can be applied to any video source to replace the
  human skin, based on its HSV value, by a static texture.</p>]]
  
  log_debug("Leaving script_description\n")
  return description
  
end

--- Called to set default settings (if any) associated with the script.
--- You would typically call Default Value Functions on the settings in order to set its default values.
--- A default value will create the related setting if not already existing, then passed to the first `script_load`
--- The parameter `settings` is of type `obs_data_t`, see https://obsproject.com/docs/reference-settings.html
--- @param settings obs_data
function script_defaults(settings)
  log_debug("Entering script_defaults")
  
  -- Reads default or stored values as soon as possible
  log_level = obslua.obs_data_get_int(settings, "log_level")
  
  log_debug("Leaving script_defaults\n")
end

-- Called on script startup with specific settings associated with the script.
function script_load(settings)
  log_debug("Entering script_load")
  
  -- Registers the template object source_info, used when adding the filter to a video source
  log_info("Call to obslua.obs_register_source(source_info)")
  obslua.obs_register_source(source_info)
  
  log_debug("Leaving script_load\n")
end

-- Called when the script’s settings (if any) have been changed by the user.
function script_update(settings)
  log_debug("Entering script_update")
  
  -- Stores potentially new log level as global variable
  log_level = obslua.obs_data_get_int(settings, "log_level")
  log_info("Current log_level: " .. tostring(obslua.obs_data_get_int(settings, "log_level")))
  
  log_debug("Leaving script_update\n")
end

-- Called to define user properties associated with the script.
-- These properties are used to define how to show settings properties to a user.
-- Returns: obs_properties_t object created via obs_properties_create().
function script_properties()
  
  log_debug("Entering script_properties")
  
  -- Creates preset properties object to be displayed on dialog window
  local properties = obslua.obs_properties_create()
  
  -- List of log levels
  list = obslua.obs_properties_add_list(properties, "log_level", "Log Level",
  obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
  for k,v in ipairs(LOG_LEVEL_NAMES) do obslua.obs_property_list_add_int(list, v, k) end
  
  log_debug("Leaving script_properties\n")
  return properties
end

-- Called when the script is being saved. This is not necessary for settings that are set by the user,
-- instead this is used for any extra internal settings data that may be used in the script.
function script_save(settings)
  log_debug("Entering script_save")
  log_debug("Leaving script_save\n")
end

-- Called when the script is being unloaded.
function script_unload()
  log_debug("Entering script_unload")
  log_debug("Leaving script_unload\n")
end

------------------------------------------------------ EFFECT FILES ----------------------------------------------------

-- The code of the effects files is copied here to avoid distributing several files
EFFECT_DEFAULT = [[
  // View-projection matrix, set by OBS
  uniform float4x4 ViewProj;
  
  // Texture containing the source picture, set by OBS
  uniform texture2d image;
  uniform float width = 320.0;
  uniform float height = 200.0;
  
  // Constants
  #define PI 3.14159265
  #define MAX_ITERRATIONS 50
  
  // Time
  uniform float time = 0.0;
  
  // Opacity (alpha) of original picture (non-detected parts)
  uniform float unprocessed_alpha = 0.5;
  
  // HSV thresholds
  uniform float hue_min = 0.0;
  uniform float hue_max = 1.0;
  uniform float saturation_min = 0.0;
  uniform float saturation_max = 1.0;
  uniform float value_min = 0.0;
  uniform float value_max = 1.0;
  
  // Outline mode 0:nothing, 1: Solid color, 2: Smooth
  uniform int outline_mode = 2;
  uniform float4 outline_color = {1.0, 0.1, 0.1, 1.0};
  uniform float outline_size = 2.0;
  uniform float outline_color_mix_ratio = 1.0;
  
  // Effect mode 0:nothing, 1: Jiggle, 2: Texture flat static, 3: Texture rounded static, 4: Texture rounded moving
  uniform int effect_mode = 2;
  
  // Deformation
  uniform float jiggle_radius = 20.0;
  uniform float jiggle_speed = 3.0;
  
  // Texture for skin replacement
  uniform texture2d texture_data;
  uniform int texture_width = 1;
  uniform int texture_height = 1;
  uniform float texture_scale = 1.0;
  uniform int texture_scan_size = 1.0;
  
   // Helper structure used as input/output of the vertex shader and as input of the pixel shader
  struct shader_data
  {
    float4 pos : POSITION;
    float2 uv  : TEXCOORD0;
  };
  
  // Definition of the processing of the input texture
  // See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc
  sampler_state linear_wrap
  {
    AddressU  = Wrap;
    AddressV  = Wrap;
    Filter    = Linear;
    //BorderColor = 00000000;
  };
  
  sampler_state linear_clamp
  {
    AddressU  = Clamp;
    AddressV  = Clamp;
    Filter    = Linear;
    //BorderColor = 00000000;
  };
  
  // RGB to HSV, ranges [0, 1]
  float3 rgb2hsv(float3 c)
  {
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
    float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));
  
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
  }
  
  // Default vertex shader used to adapt virtual triangle coordinates to location
  // of output picture as set by OBS, and to pass the UV coordinates unchanged
  shader_data vertex_shader_default(shader_data cur)
  {
    shader_data res;
    res.pos = mul(float4(cur.pos.xyz, 1.0), ViewProj);
    res.uv  = cur.uv;
    return res;
  }
  
  // Returns true if the given RGBA is in HSV ranges
  bool detected(float4 rgba)
  {
    float3 hsv = rgb2hsv(rgba.rgb);
    return ((hue_min        <= hsv.x && hsv.x <= hue_max && hue_min<hue_max) || 
            (hue_max        <= hsv.x && hsv.x <= hue_min && hue_max<hue_min)) &&
             saturation_min <= hsv.y && hsv.y <= saturation_max &&
             value_min      <= hsv.z && hsv.z <= value_max;
  }
  
  // Pixel shader to map texture on pixels with particular HSV levels
  float4 pixel_shader_texture_skin(shader_data cur) : TARGET
  {
    // Gets current pixel color and transforms it to HSV
    float4 smp = image.Sample(linear_wrap, cur.uv);
  
    // Detects if color is in detection range
    if (detected(smp))
    {
      // Searches closest edge
      bool edge_found = false;
      float edge_radius = 0;
      float edge_angle = 0;
      int i;
      if (outline_mode>0)
        for(i=0; i<MAX_ITERRATIONS && edge_radius<outline_size && !edge_found; i++)
        {
          // Scans in a spiral around detected point for edges of detected zone
          edge_angle = i*2.0*PI/9.6;
          edge_radius = edge_angle/(2.0*PI);
          float2 posuv = cur.uv + float2(edge_radius*cos(edge_angle)/width, edge_radius*sin(edge_angle)/height);
          edge_found = !detected(image.Sample(linear_clamp, posuv));
        }
  
      // Searches closest edges in X and Y for shape-shifting
      float2 edge_distance = {0.0, 0.0};
      bool edge_x_found = false, edge_y_found = false;
      if (effect_mode>=3)
        for(i=1; i<MAX_ITERRATIONS && i<texture_scan_size && !edge_x_found && !edge_y_found; i++)
        {
          // Scans in a line for edge of detected zone in X direction
          if (!edge_x_found)
            if (!detected(image.Sample(linear_clamp, cur.uv + float2(i/width, 0.0))))
              {edge_distance.x = texture_scan_size-i; edge_x_found=true;}
            else if (!detected(image.Sample(linear_clamp, cur.uv + float2(-i/width, 0.0))))
              {edge_distance.x = i-texture_scan_size; edge_x_found=true;}
  
          // Scans in a line for edge of detected zone in Y direction
          if (!edge_y_found)
            if (!detected(image.Sample(linear_clamp, cur.uv + float2(0.0, i/height))))
              {edge_distance.y = texture_scan_size-i; edge_y_found=true;}
            else if (!detected(image.Sample(linear_clamp, cur.uv + float2(0.0, -i/height))))
              {edge_distance.y = i-texture_scan_size; edge_y_found=true;}
        }
      
  
      // Returns outline color if boundary found
      float4 original_smp = smp;
      if (outline_mode==1 && edge_found)
      {
        smp = lerp(smp, outline_color, outline_color_mix_ratio);
      }
      // Jiggle
      else if(effect_mode==1)
      {
        float angle = time*jiggle_speed;
        float radius = jiggle_radius*cos(angle*4.32123);
        float2 posuv = cur.uv + float2(radius*cos(angle)/width, radius*sin(angle)/height);
        smp = image.Sample(linear_clamp, posuv);
      }
      // Texture
      else if (effect_mode>=2)
      {
        // Pixel position in texture relative to current position with wrap (in sampler settings)
        float2 pos = cur.uv*float2(width, height);
  
        // Texture rounded
        if (effect_mode>=3)
        {
          float2 ratio = edge_distance/texture_scan_size;
          float2 offset = sign(edge_distance)*(exp(4.0*abs(ratio))-1.0);
  
          if (effect_mode==4)
          {
            // If edge was detected, starts texture from edge (moving with edge)
            if (edge_x_found) pos.x = offset.x;
            if (edge_y_found) pos.y = offset.y;
          }
          else
            // Rounds texture when edge is near
            pos += offset;
        }
  
        smp = texture_data.Sample(linear_wrap, pos / float2(texture_width, texture_height) / texture_scale);
      }
  
  
      // Smooth
      if (outline_mode==2 && edge_found)
        smp = lerp(lerp(original_smp, smp, edge_radius/outline_size), outline_color,
                        outline_color_mix_ratio*(1.0-abs(2.0*edge_radius/outline_size-1.0)));
    }
    else
      smp.a *= unprocessed_alpha;
  
    return smp;
  }
  
  technique Draw
  {
    pass
    {
      vertex_shader = vertex_shader_default(cur);
      pixel_shader  = pixel_shader_texture_skin(cur);
    }
  }
]]

------------------------------------------------------ SOURCE INFO -----------------------------------------------------

-- Starts the definition of the global variable of type obs_source_info_t, used to create source object instances
-- when the filter is added on a video source or re-created in a scene at OBS start.
-- See https://obsproject.com/docs/reference-sources.html
source_info = {}

-- Unique string identifier for the source (required)
source_info.id = 'filter-texture-skin'

-- Type of source (one of INPUT/FILTER/TRANSITION)
source_info.type = obslua.OBS_SOURCE_TYPE_FILTER

-- Source output capability flags (required)
-- A bitwise OR combination of VIDEO/AUDIO/ASYNC/etc
source_info.output_flags = obslua.OBS_SOURCE_VIDEO

-- Get the translated name of the source type
-- NOTE: normally there is an argument "type_data", unclear what it means
source_info.get_name = function()
  return "Texture Skin"
end

-- Sets the default settings for this source
-- Defaults are set to simple settings for custom palettes in case the user selects the palette manually
-- and the default preset is set to a non-customized one
source_info.get_defaults = function(settings)
  log_debug("Entering source_info.get_defaults")

  -- Sets default values for parameters
  --obslua.obs_data_set_default_int(settings, "detection_color", 0xfff1baa7)
  obslua.obs_data_set_default_double(settings, "hue_min", 0.0)
  obslua.obs_data_set_default_double(settings, "hue_max", 0.1)
  obslua.obs_data_set_default_double(settings, "saturation_min", 0.1)
  obslua.obs_data_set_default_double(settings, "saturation_max", 0.5)
  obslua.obs_data_set_default_double(settings, "value_min", 0.5)
  obslua.obs_data_set_default_double(settings, "value_max", 1.0)

  obslua.obs_data_set_default_double(settings, "unprocessed_alpha", 1.0)

  obslua.obs_data_set_default_int(settings, "outline_mode", 1)
  obslua.obs_data_set_default_double(settings, "outline_size", 4.0)
  obslua.obs_data_set_default_int(settings, "outline_color", 0xff000000)
  obslua.obs_data_set_default_double(settings, "outline_color_mix_ratio", 0.5)

  obslua.obs_data_set_default_int(settings, "effect_mode", 1)
  obslua.obs_data_set_default_double(settings, "jiggle_radius", 20.0)
  obslua.obs_data_set_default_double(settings, "jiggle_speed", 3.0)
  obslua.obs_data_set_default_string(settings, "texture_path", "")
  obslua.obs_data_set_default_double(settings, "texture_scale", 1.0)
  obslua.obs_data_set_default_int(settings, "texture_scan_size", 20)

  log_debug("Leaving source_info.get_defaults\n")
end

function set_properties_visibility(props, property, settings)

  local effect_mode = obslua.obs_data_get_int(settings, "effect_mode")
  local outline_mode = obslua.obs_data_get_int(settings, "outline_mode")
  log_debug("in set_properties_visibility with effect_mode=" .. effect_mode)

  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "outline_size"), outline_mode>0)
  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "outline_color"), outline_mode>=1)
  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "outline_color_mix_ratio"), outline_mode>=1)

  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "jiggle_speed"), effect_mode==1)
  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "jiggle_radius"), effect_mode==1)

  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "texture_path"), effect_mode>=2)
  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "texture_scale"), effect_mode>=2)
  obslua.obs_property_set_visible(obslua.obs_properties_get(props, "texture_scan_size"), effect_mode>=3)

  return true
end

-- Gets the property information of this source (Optional)
source_info.get_properties = function(data)
  log_debug("Entering source_info.get_properties")
  
  -- Always re-create properties object and keeps a reference for use in callbacks
  local props = obslua.obs_properties_create()
  data.props = props

  -- Color detection
  obslua.obs_properties_add_float_slider(props, "hue_min", "Hue min", 0.0, 1.0, 0.001)
  obslua.obs_properties_add_float_slider(props, "hue_max", "Hue max", 0.0, 1.0, 0.001)
  obslua.obs_properties_add_float_slider(props, "saturation_min", "Saturation min", 0.0, 1.0, 0.01)
  obslua.obs_properties_add_float_slider(props, "saturation_max", "Saturation max", 0.0, 1.0, 0.01)
  obslua.obs_properties_add_float_slider(props, "value_min", "Value min", 0.0, 1.0, 0.01)
  obslua.obs_properties_add_float_slider(props, "value_max", "Value max", 0.0, 1.0, 0.01)

  -- Original blending
  obslua.obs_properties_add_float_slider(props, "unprocessed_alpha", "Alpha of unprocessed part", 0.0, 1.0, 0.1)

  -- Outline mode
  local p = obslua.obs_properties_add_list(props, "outline_mode", "Outline mode",
        obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
  obslua.obs_property_list_add_int(p, "No outline", 0)
  obslua.obs_property_list_add_int(p, "Solid color", 1)
  obslua.obs_property_list_add_int(p, "Smooth", 2)
  obslua.obs_property_set_modified_callback(p, set_properties_visibility)

  -- Outline parameters
  obslua.obs_properties_add_float_slider(props, "outline_size", "Outline size", 1.0, 5.0, 0.5)
  obslua.obs_properties_add_color(props, "outline_color", "Outline color")
  obslua.obs_properties_add_float_slider(props, "outline_color_mix_ratio", "Outline color mix", 0.0, 1.0, 0.1)

  -- Effect mode
  p = obslua.obs_properties_add_list(props, "effect_mode", "Effect mode",
        obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
  obslua.obs_property_list_add_int(p, "No effect", 0)
  obslua.obs_property_list_add_int(p, "Jiggle", 1)
  obslua.obs_property_list_add_int(p, "Texture flat static", 2)
  obslua.obs_property_list_add_int(p, "Texture rounded static", 3)
  obslua.obs_property_list_add_int(p, "Texture rounded moving", 4)
  obslua.obs_property_set_modified_callback(p, set_properties_visibility)

  -- Jiggle parameters
  obslua.obs_properties_add_float_slider(props, "jiggle_radius", "Jiggle radius", 0.0, 30.0, 0.1)
  obslua.obs_properties_add_float_slider(props, "jiggle_speed", "Jiggle speed", 0.0, 10.0, 0.1)

  -- Texture parameters
  obslua.obs_properties_add_path(props, "texture_path", "Texture path", obslua.OBS_PATH_FILE,
    "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obslua.obs_properties_add_float_slider(props, "texture_scale", "Texture scale", 0.01, 10.0, 0.01)
  obslua.obs_properties_add_int_slider(props, "texture_scan_size", "Texture scan size", 1, 50, 1)
  
  log_debug("Leaving source_info.get_properties\n")
  return props
end

-- Creates the implementation data for the source
-- Parameters:	settings – Settings to initialize the source with
--              source – Source that this data is associated with
-- Returns:	The implementation data associated with this source
source_info.create = function(settings, source)
  log_debug("Entering source_info.create")
  
  -- Inits filter data object (arbitrary data structure used to keep own data between calls)
  local data = {}
  
  -- Default resolution values (potentially used before rendering, just in case)
  data.width = 320
  data.height = 200
  
  -- The source object instance of the filter itself
  data.source = source
  
  -- Saves the settings for later use
  data.settings = settings

  -- Texture variables to force creation at first call to source_info.update
  data.texture_image = nil
  data.loaded_texture_path = "Dummy"
  
  -- Compiles shader
  obslua.obs_enter_graphics()
  local effect_file_path = script_path() .. 'filter-texture-skin.effect.hlsl'
  log_debug("effect_file_path:", effect_file_path)
  data.effect = obslua.gs_effect_create_from_file(effect_file_path, nil)
  if data.effect == nil then
    log_error("No compilation of development effect file, reverting to internal effect")
    data.effect = obslua.gs_effect_create(EFFECT_DEFAULT, "default", nil)
  end
  obslua.obs_leave_graphics()

  -- Destroys everything if shader was not compiled properly
  if data.effect == nil then
    log_error("Effect could not be compiled")
    source_info.destroy(data)
    return nil
  end

  -- Retrieves the shader uniform variables
  data.params = {}
  data.params.width = obslua.gs_effect_get_param_by_name(data.effect, "width")
  data.params.height = obslua.gs_effect_get_param_by_name(data.effect, "height")
  data.params.time = obslua.gs_effect_get_param_by_name(data.effect, "time")

  data.params.hue_min = obslua.gs_effect_get_param_by_name(data.effect, "hue_min")
  data.params.hue_max = obslua.gs_effect_get_param_by_name(data.effect, "hue_max")
  data.params.saturation_min = obslua.gs_effect_get_param_by_name(data.effect, "saturation_min")
  data.params.saturation_max = obslua.gs_effect_get_param_by_name(data.effect, "saturation_max")
  data.params.value_min = obslua.gs_effect_get_param_by_name(data.effect, "value_min")
  data.params.value_max = obslua.gs_effect_get_param_by_name(data.effect, "value_max")

  data.params.unprocessed_alpha = obslua.gs_effect_get_param_by_name(data.effect, "unprocessed_alpha")

  data.params.outline_mode = obslua.gs_effect_get_param_by_name(data.effect, "outline_mode")
  data.params.outline_size = obslua.gs_effect_get_param_by_name(data.effect, "outline_size")
  data.params.outline_color = obslua.gs_effect_get_param_by_name(data.effect, "outline_color")
  data.params.outline_color_mix_ratio = obslua.gs_effect_get_param_by_name(data.effect, "outline_color_mix_ratio")

  data.params.effect_mode = obslua.gs_effect_get_param_by_name(data.effect, "effect_mode")
  data.params.jiggle_radius = obslua.gs_effect_get_param_by_name(data.effect, "jiggle_radius")
  data.params.jiggle_speed = obslua.gs_effect_get_param_by_name(data.effect, "jiggle_speed")
  data.params.texture_data = obslua.gs_effect_get_param_by_name(data.effect, "texture_data")
  data.params.texture_width = obslua.gs_effect_get_param_by_name(data.effect, "texture_width")
  data.params.texture_height = obslua.gs_effect_get_param_by_name(data.effect, "texture_height")
  data.params.texture_scale = obslua.gs_effect_get_param_by_name(data.effect, "texture_scale")
  data.params.texture_scan_size = obslua.gs_effect_get_param_by_name(data.effect, "texture_scan_size")

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  log_debug("Leaving source_info.create\n")
  return data
end

-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)
  log_debug("Entering source_info.update")

  -- Loads or reloads texture file if path changed
  local texture_path = obslua.obs_data_get_string(settings, "texture_path")
  if data.loaded_texture_path ~= texture_path then
    log_debug("Loading new texture file: " .. texture_path)
    obslua.obs_enter_graphics()

    -- Free any existing image
    if data.texture_image then
      obslua.gs_image_file_free(data.texture_image)
    end

    -- Loads and inits image for texture
    if string.len(texture_path) > 0 then
      -- Loads and inits image for texture
      data.texture_image = obslua.gs_image_file()
      obslua.gs_image_file_init(data.texture_image, texture_path)
      obslua.gs_image_file_init_texture(data.texture_image)
      log_debug("Texture loaded - cx=" .. tostring(data.texture_image.cx) ..
                 " cy=" .. tostring(data.texture_image.cy))
    else
      data.texture_image = nil
    end

    data.loaded_texture_path = texture_path
    obslua.obs_leave_graphics()
  end

  -- Prepares other parameters in data
  data.hue_min = obslua.obs_data_get_double(settings, "hue_min")
  data.hue_max = obslua.obs_data_get_double(settings, "hue_max")
  data.saturation_min = obslua.obs_data_get_double(settings, "saturation_min")
  data.saturation_max = obslua.obs_data_get_double(settings, "saturation_max")
  data.value_min = obslua.obs_data_get_double(settings, "value_min")
  data.value_max = obslua.obs_data_get_double(settings, "value_max")

  data.unprocessed_alpha = obslua.obs_data_get_double(settings, "unprocessed_alpha")

  data.outline_mode = obslua.obs_data_get_int(settings, "outline_mode")
  data.outline_size = obslua.obs_data_get_double(settings, "outline_size")
  local c = obslua.obs_data_get_int(settings, "outline_color")
  data.outline_color = 0xff000000 + (c%256)*65536 + (math.floor(c/256)%256)*256 + (math.floor(c/65536)%256)
  data.outline_color_mix_ratio = obslua.obs_data_get_double(settings, "outline_color_mix_ratio")

  data.effect_mode = obslua.obs_data_get_int(settings, "effect_mode")
  data.jiggle_radius = obslua.obs_data_get_double(settings, "jiggle_radius")
  data.jiggle_speed = obslua.obs_data_get_double(settings, "jiggle_speed")
  data.texture_scale = obslua.obs_data_get_double(settings, "texture_scale")
  data.texture_scan_size = obslua.obs_data_get_int(settings, "texture_scan_size")

  log_debug("Effect mode: " .. tostring(data.effect_mode))
  log_debug("Outline mode: " .. tostring(data.outline_mode))

  log_debug("Leaving source_info.update\n")
end

-- Returns the width of the source, this callback is required if this is a video source and is synchronous
source_info.get_width = function(data)
  local target = obslua.obs_filter_get_target(data.source)
  if target ~= nil then data.width = obslua.obs_source_get_base_width(target) end
  return data.width
end
-- Returns the height of the source, this callback is required if this is a video source and is synchronous
source_info.get_height = function(data)
  local target = obslua.obs_filter_get_target(data.source)
  if target ~= nil then data.height = obslua.obs_source_get_base_height(target) end
  return data.height
end

-- Called when rendering the source with the graphics subsystem
-- If this is a filter source, it wraps source draw calls (for example applying a custom effect with custom parameters
--   to a source). In this case, it’s highly recommended to use the obs_source_process_filter_begin() and
--   obs_source_process_filter_end() functions to automatically handle effect-based filter processing. However, you
--   can implement custom draw handling as desired as well.
-- See https://obsproject.com/docs/graphics.html#rendering-video-effect-filters
source_info.video_render = function(data)
  obslua.obs_source_process_filter_begin(data.source, obslua.GS_RGBA, obslua.OBS_NO_DIRECT_RENDERING)

  -- Resolution
  obslua.gs_effect_set_float(data.params.width, data.width)
  obslua.gs_effect_set_float(data.params.height, data.height)

  -- Time
  obslua.gs_effect_set_float(data.params.time, obslua.os_gettime_ns()/1e9)

  -- HSV thresholds
  obslua.gs_effect_set_float(data.params.hue_min, data.hue_min)
  obslua.gs_effect_set_float(data.params.hue_max, data.hue_max)
  obslua.gs_effect_set_float(data.params.saturation_min, data.saturation_min)
  obslua.gs_effect_set_float(data.params.saturation_max, data.saturation_max)
  obslua.gs_effect_set_float(data.params.value_min, data.value_min)
  obslua.gs_effect_set_float(data.params.value_max, data.value_max)

  -- original blend
  obslua.gs_effect_set_float(data.params.unprocessed_alpha, data.unprocessed_alpha)

  -- Outline
  obslua.gs_effect_set_int(data.params.outline_mode, data.outline_mode)
  obslua.gs_effect_set_float(data.params.outline_size, data.outline_size)
  obslua.gs_effect_set_color(data.params.outline_color, data.outline_color)
  obslua.gs_effect_set_float(data.params.outline_color_mix_ratio, data.outline_color_mix_ratio)

  -- Effect Mode
  obslua.gs_effect_set_int(data.params.effect_mode, data.effect_mode)

  -- Jiggle
  obslua.gs_effect_set_float(data.params.jiggle_radius, data.jiggle_radius)
  obslua.gs_effect_set_float(data.params.jiggle_speed, data.jiggle_speed)

  -- Texture
  if data.texture_image then
    obslua.gs_effect_set_texture(data.params.texture_data, data.texture_image.texture)
    obslua.gs_effect_set_int(data.params.texture_width, data.texture_image.cx)
    obslua.gs_effect_set_int(data.params.texture_height, data.texture_image.cy)
  end
  obslua.gs_effect_set_float(data.params.texture_scale, data.texture_scale)
  obslua.gs_effect_set_int(data.params.texture_scan_size, data.texture_scan_size)
  
  obslua.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end

-- Destroys the implementation data for the source
source_info.destroy = function(data)
  log_debug("Entering source_info.destroy")
  
  if data.effect ~= nil then
    obslua.obs_enter_graphics()
    obslua.gs_effect_destroy(data.effect)
    data.effect = nil
    obslua.obs_leave_graphics()
  end
  
  log_debug("Leaving source_info.destroy\n")
end

-- Called when the source has been activated in the main view (visible on stream/recording) (Optional)
source_info.activate = function(data)
  log_debug("Entering source_info.activate")
  log_debug("Leaving source_info.activate\n")
end

-- Called when the source has been deactivated in the main view (no longer visible on stream/recording) (Optional)
source_info.deactivate = function(data)
  log_debug("Entering source_info.deactivate")
  log_debug("Leaving source_info.deactivate\n")
end

-- Called when the source is visible on any display and/or on the main view (Optional)
source_info.show = function(data)
  log_debug("Entering source_info.show")
  log_debug("Leaving source_info.show\n")
end

-- Called when the source is no longer visible on any display and/or on the main view (Optional)
source_info.hide = function(data)
  log_debug("Entering source_info.hide")
  log_debug("Leaving source_info.hide\n")
end

-- Called when saving custom data for a source.
-- This is a separate function because sometimes a source needs to know when it is being saved so it doesn’t always have
-- to update the current settings until a certain point (Optional)
source_info.save = function(data, settings)
  log_debug("Entering source_info.save")
  log_debug("Leaving source_info.save\n")
end

-- Called when loading custom data from saved source data.
-- This is called after all the loading sources have actually been created, allowing the ability to reference other
-- sources if desired (Optional)
source_info.load = function(data, settings)
  log_debug("Entering source_info.load")
  log_debug("Leaving source_info.load")
end

-- Called when the filter is removed from a source (Optional)
source_info.filter_remove = function(data, source)
  log_debug("Entering source_info.filter_remove")
  log_debug("Leaving source_info.filter_remove")
end
