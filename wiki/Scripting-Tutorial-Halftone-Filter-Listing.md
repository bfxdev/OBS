
# Scripting Tutorial Halftone Filter Listing

Complete source code of the [Scripting Tutorial Halftone Filter](Scripting-Tutorial-Halftone-Filter.md).

## First part

In the first part, a minimal video effect is proposed. Use it as a starting point for your project.

Copy both files in the same directory, add the script in OBS, add the filter to a source. Don't forget to reload the script after any modification of the Lua file, and to restart OBS after any modification of the effect file (the compiled effect is cached).

### Lua script `filter-halftone.lua`

``` Lua
obs = obslua

-- Returns the description displayed in the Scripts window
function script_description()
  return [[<center><h2>Halftone Filter</h2></center>
  <p>This Lua script adds a video filter named <it>Halftone</it>. The filter can be added
  to a video source to reduce the number of colors of the input picture. It reproduces
  the style of a magnified printed picture.</p>]]
end

-- Called on script startup
function script_load(settings)
  obs.obs_register_source(source_info)
end

-- Definition of the global variable containing the source_info structure
source_info = {}
source_info.id = 'filter-halftone'              -- Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
source_info.get_name = function()
  return "Halftone"
end

-- Creates the implementation data for the source
source_info.create = function(settings, source)

  -- Initializes the custom data table
  local data = {}
  data.source = source -- Keeps a reference to this filter as a source object
  data.width = 1       -- Dummy value during initialization phase
  data.height = 1      -- Dummy value during initialization phase

  -- Compiles the effect
  obs.obs_enter_graphics()
  local effect_file_path = script_path() .. 'filter-halftone.effect.hlsl'
  data.effect = obs.gs_effect_create_from_file(effect_file_path, nil)
  obs.obs_leave_graphics()

  -- Calls the destroy function if the effect was not compiled properly
  if data.effect == nil then
    obs.blog(obs.LOG_ERROR, "Effect compilation failed for " .. effect_file_path)
    source_info.destroy(data)
    return nil
  end

  -- Retrieves the shader uniform variables
  data.params = {}
  data.params.width = obs.gs_effect_get_param_by_name(data.effect, "width")
  data.params.height = obs.gs_effect_get_param_by_name(data.effect, "height")
  data.params.gamma = obs.gs_effect_get_param_by_name(data.effect, "gamma")
  data.params.gamma_shift = obs.gs_effect_get_param_by_name(data.effect, "gamma_shift")
  data.params.amplitude = obs.gs_effect_get_param_by_name(data.effect, "amplitude")
  data.params.scale = obs.gs_effect_get_param_by_name(data.effect, "scale")
  data.params.number_of_color_levels = obs.gs_effect_get_param_by_name(data.effect, "number_of_color_levels")

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  return data
end

-- Destroys and release resources linked to the custom data
source_info.destroy = function(data)
  if data.effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(data.effect)
    data.effect = nil
    obs.obs_leave_graphics()
  end
end

-- Returns the width of the source
source_info.get_width = function(data)
  return data.width
end

-- Returns the height of the source
source_info.get_height = function(data)
  return data.height
end

-- Called when rendering the source with the graphics subsystem
source_info.video_render = function(data)
  local parent = obs.obs_filter_get_parent(data.source)
  data.width = obs.obs_source_get_base_width(parent)
  data.height = obs.obs_source_get_base_height(parent)

  obs.obs_source_process_filter_begin(data.source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)

  -- Effect parameters initialization goes here
  obs.gs_effect_set_int(data.params.width, data.width)
  obs.gs_effect_set_int(data.params.height, data.height)
  obs.gs_effect_set_float(data.params.gamma, data.gamma)
  obs.gs_effect_set_float(data.params.gamma_shift, data.gamma_shift)
  obs.gs_effect_set_float(data.params.amplitude, data.amplitude)
  obs.gs_effect_set_float(data.params.scale, data.scale)
  obs.gs_effect_set_int(data.params.number_of_color_levels, data.number_of_color_levels)

  obs.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end

-- Sets the default settings for this source
source_info.get_defaults = function(settings)
  obs.obs_data_set_default_double(settings, "gamma", 1.0)
  obs.obs_data_set_default_double(settings, "gamma_shift", 0.0)
  obs.obs_data_set_default_double(settings, "scale", 1.0)
  obs.obs_data_set_default_double(settings, "amplitude", 0.2)
  obs.obs_data_set_default_int(settings, "number_of_color_levels", 4)
end

-- Gets the property information of this source
source_info.get_properties = function(data)
  local props = obs.obs_properties_create()
  obs.obs_properties_add_float_slider(props, "gamma", "Gamma encoding exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_float_slider(props, "gamma_shift", "Gamma shift", -2.0, 2.0, 0.01)
  obs.obs_properties_add_float_slider(props, "scale", "Pattern scale", 0.01, 10.0, 0.01)
  obs.obs_properties_add_float_slider(props, "amplitude", "Perturbation amplitude", 0.0, 2.0, 0.01)
  obs.obs_properties_add_int_slider(props, "number_of_color_levels", "Number of color levels", 2, 10, 1)

  return props
end

-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)
  data.gamma = obs.obs_data_get_double(settings, "gamma")
  data.gamma_shift = obs.obs_data_get_double(settings, "gamma_shift")
  data.scale = obs.obs_data_get_double(settings, "scale")
  data.amplitude = obs.obs_data_get_double(settings, "amplitude")
  data.number_of_color_levels = obs.obs_data_get_int(settings, "number_of_color_levels")
end
```

### Effect file `filter-halftone.effect.hlsl`

``` HLSL
// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d

// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture

// General properties
uniform float gamma = 1.0;
uniform float gamma_shift = 0.6;
uniform int number_of_color_levels = 4.0;

// Size of the source picture
uniform int width;
uniform int height;

// Constants
#define PI 3.141592653589793238

// General properties
uniform float amplitude = 0.2;
uniform float scale = 1.0;

// Interpolation method and wrap mode for sampling a texture
SamplerState linear_clamp
{
    Filter    = Linear;     // Anisotropy / Point / Linear
    AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    BorderColor = 00000000; // Used only with Border edges (optional)
};

// Data type of the input of the vertex shader
struct vertex_data
{
    float4 pos : POSITION;  // Homogeneous space coordinates XYZW
    float2 uv  : TEXCOORD0; // UV coordinates in the source picture
};

// Data type of the output returned by the vertex shader, and used as input 
// for the pixel shader after interpolation for each pixel
struct pixel_data
{
    float4 pos : POSITION;  // Homogeneous screen coordinates XYZW
    float2 uv  : TEXCOORD0; // UV coordinates in the source picture
};

// Vertex shader used to compute position of rendered pixels and pass UV
pixel_data vertex_shader_halftone(vertex_data vertex)
{
    pixel_data pixel;
    pixel.pos = mul(float4(vertex.pos.xyz, 1.0), ViewProj);
    pixel.uv  = vertex.uv;
    return pixel;
}

float3 decode_gamma(float3 color, float exponent, float shift)
{
    return pow(clamp(color, 0.0, 1.0), exponent - shift);
}

float3 encode_gamma(float3 color, float exponent)
{
    return pow(clamp(color, 0.0, 1.0), 1.0/exponent);
}

// Pixel shader used to compute an RGBA color at a given pixel position
float4 pixel_shader_halftone(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float3 linear_color = decode_gamma(source_sample.rgb, gamma, gamma_shift);

    float luminance = dot(linear_color, float3(0.299, 0.587, 0.114));
    float2 position = pixel.uv * float2(width, height);
    float perturbation = amplitude * cos(PI*position.x/scale/4.0) * cos(PI*position.y/scale/4.0);
    float3 result = (luminance + perturbation).xxx;

    result = round((number_of_color_levels-1)*result)/(number_of_color_levels-1);

    return float4(encode_gamma(result, gamma), source_sample.a);
}

technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_halftone(vertex);
        pixel_shader  = pixel_shader_halftone(pixel);
    }
}
```

## Second part

In the second part, functions to use textures for a bitmap dithering pattern and a palette are added. The Lua file contains the effect file:

``` Lua
obs = obslua

-- Returns the description displayed in the Scripts window
function script_description()
  return [[<center><h2>Halftone Filter</h2></center>
  <p>This Lua script adds a video filter named <it>Halftone</it>. The filter can be added
  to a video source to reduce the number of colors of the input picture. It reproduces
  the style of a magnified printed picture.</p>]]
end

-- Called on script startup
function script_load(settings)
  obs.obs_register_source(source_info)
end

-- Definition of the global variable containing the source_info structure
source_info = {}
source_info.id = 'filter-halftone'              -- Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
source_info.get_name = function()
  return "Halftone"
end

-- Creates the implementation data for the source
source_info.create = function(settings, source)

  -- Initializes the custom data table
  local data = {}
  data.source = source -- Keeps a reference to this filter as a source object
  data.width = 1       -- Dummy value during initialization phase
  data.height = 1      -- Dummy value during initialization phase

  -- Compiles the effect
  obs.obs_enter_graphics()
  -- local effect_file_path = script_path() .. 'filter-halftone-evolution.effect.hlsl'
  -- data.effect = obs.gs_effect_create_from_file(effect_file_path, nil)
  data.effect = obs.gs_effect_create(EFFECT, "halftone_effect_code", nil)
  obs.obs_leave_graphics()

  -- Calls the destroy function if the effect was not compiled properly
  if data.effect == nil then
    obs.blog(obs.LOG_ERROR, "Effect compilation failed")
    source_info.destroy(data)
    return nil
  end

  -- Retrieves the shader uniform variables
  data.params = {}
  data.params.width = obs.gs_effect_get_param_by_name(data.effect, "width")
  data.params.height = obs.gs_effect_get_param_by_name(data.effect, "height")
  data.params.gamma = obs.gs_effect_get_param_by_name(data.effect, "gamma")
  data.params.gamma_shift = obs.gs_effect_get_param_by_name(data.effect, "gamma_shift")
  data.params.amplitude = obs.gs_effect_get_param_by_name(data.effect, "amplitude")
  data.params.scale = obs.gs_effect_get_param_by_name(data.effect, "scale")
  data.params.number_of_color_levels = obs.gs_effect_get_param_by_name(data.effect, "number_of_color_levels")

  data.params.offset = obs.gs_effect_get_param_by_name(data.effect, "offset")

  data.params.pattern_texture = obs.gs_effect_get_param_by_name(data.effect, "pattern_texture")
  data.params.pattern_size = obs.gs_effect_get_param_by_name(data.effect, "pattern_size")
  data.params.pattern_gamma = obs.gs_effect_get_param_by_name(data.effect, "pattern_gamma")

  data.params.palette_texture = obs.gs_effect_get_param_by_name(data.effect, "palette_texture")
  data.params.palette_size = obs.gs_effect_get_param_by_name(data.effect, "palette_size")
  data.params.palette_gamma = obs.gs_effect_get_param_by_name(data.effect, "palette_gamma")

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  return data
end

-- Destroys and release resources linked to the custom data
source_info.destroy = function(data)
  if data.effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(data.effect)
    data.effect = nil
    obs.obs_leave_graphics()
  end
end

-- Returns the width of the source
source_info.get_width = function(data)
  return data.width
end

-- Returns the height of the source
source_info.get_height = function(data)
  return data.height
end

function set_texture_effect_parameters(image, param_texture, param_size, nanoseconds)
  local size = obs.vec2()
  if image then
    obs.gs_image_file_tick(image, nanoseconds)
    obs.gs_image_file_update_texture(image)
    obs.gs_effect_set_texture(param_texture, image.texture)
    obs.vec2_set(size, image.cx, image.cy)
  else
    obs.vec2_set(size, -1, -1)
  end
  obs.gs_effect_set_vec2(param_size, size)
end

-- Called when rendering the source with the graphics subsystem
source_info.video_render = function(data)
  local parent = obs.obs_filter_get_parent(data.source)
  data.width = obs.obs_source_get_base_width(parent)
  data.height = obs.obs_source_get_base_height(parent)

  obs.obs_source_process_filter_begin(data.source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)

  -- Effect parameters initialization goes here
  obs.gs_effect_set_int(data.params.width, data.width)
  obs.gs_effect_set_int(data.params.height, data.height)
  obs.gs_effect_set_float(data.params.gamma, data.gamma)
  obs.gs_effect_set_float(data.params.gamma_shift, data.gamma_shift)
  obs.gs_effect_set_float(data.params.amplitude, data.amplitude)
  obs.gs_effect_set_float(data.params.scale, data.scale)
  obs.gs_effect_set_int(data.params.number_of_color_levels, data.number_of_color_levels)

  obs.gs_effect_set_float(data.params.offset, data.offset)

  -- Pattern texture
  set_texture_effect_parameters(data.pattern, data.params.pattern_texture,
                                data.params.pattern_size, data.nanoseconds)
  obs.gs_effect_set_float(data.params.pattern_gamma, data.pattern_gamma)

  -- Palette texture
  set_texture_effect_parameters(data.palette, data.params.palette_texture,
                                data.params.palette_size, data.nanoseconds)
  obs.gs_effect_set_float(data.params.palette_gamma, data.palette_gamma)


  obs.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end

-- Sets the default settings for this source
source_info.get_defaults = function(settings)
  obs.obs_data_set_default_double(settings, "gamma", 1.0)
  obs.obs_data_set_default_double(settings, "gamma_shift", 0.0)
  obs.obs_data_set_default_double(settings, "scale", 1.0)
  obs.obs_data_set_default_double(settings, "amplitude", 0.2)
  obs.obs_data_set_default_int(settings, "number_of_color_levels", 4)

  obs.obs_data_set_default_double(settings, "offset", 0.0)

  obs.obs_data_set_default_string(settings, "pattern_path", "")
  obs.obs_data_set_default_double(settings, "pattern_gamma", 1.0)
  obs.obs_data_set_default_string(settings, "palette_path", "")
  obs.obs_data_set_default_double(settings, "palette_gamma", 1.0)

end

-- Properties "modified callback" to set visible flags of the displayed properties
function set_properties_visibility(props, property, settings)

  local pattern = string.len(obslua.obs_data_get_string(settings, "pattern_path")) > 0
  local palette = string.len(obslua.obs_data_get_string(settings, "palette_path")) > 0

  obs.obs_property_set_visible(obs.obs_properties_get(props, "pattern_reset"), pattern)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "pattern_gamma"), pattern)

  obs.obs_property_set_visible(obs.obs_properties_get(props, "number_of_color_levels"), not palette)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "palette_reset"), palette)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "palette_gamma"), palette)

  return true
end


-- Gets the property information of this source
source_info.get_properties = function(data)
  print("In source_info.get_properties")

  local props = obs.obs_properties_create()

  local gprops = obs.obs_properties_create()
  obs.obs_properties_add_group(props, "input", "Input Source", obs.OBS_GROUP_NORMAL, gprops)
  obs.obs_properties_add_float_slider(gprops, "gamma", "Gamma encoding exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_float_slider(gprops, "gamma_shift", "Gamma shift", -2.0, 2.0, 0.01)

  gprops = obs.obs_properties_create()
  obs.obs_properties_add_group(props, "pattern", "Dithering Pattern", obs.OBS_GROUP_NORMAL, gprops)
  obs.obs_properties_add_float_slider(gprops, "scale", "Pattern scale", 0.01, 10.0, 0.01)
  obs.obs_properties_add_float_slider(gprops, "amplitude", "Dithering amplitude", -2.0, 2.0, 0.01)
  obs.obs_properties_add_float_slider(gprops, "offset", "Dithering luminosity shift", -2.0, 2.0, 0.01)

  local p = obs.obs_properties_add_path(gprops, "pattern_path", "Pattern texture", obs.OBS_PATH_FILE,
                              "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_property_set_modified_callback(p, set_properties_visibility)
  obs.obs_properties_add_float_slider(gprops, "pattern_gamma", "Pattern gamma exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_button(gprops, "pattern_reset", "Reset pattern texture", function(properties, property)
    obs.obs_data_set_string(data.settings, "pattern_path", ""); data.pattern = nil;
    set_properties_visibility(properties, property, data.settings); return true; end)

  gprops = obs.obs_properties_create()
  obs.obs_properties_add_group(props, "palette", "Color palette", obs.OBS_GROUP_NORMAL, gprops)
  obs.obs_properties_add_int_slider(gprops, "number_of_color_levels", "Number of color levels", 2, 10, 1)
  p = obs.obs_properties_add_path(gprops, "palette_path", "Palette texture", obs.OBS_PATH_FILE,
                              "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_property_set_modified_callback(p, set_properties_visibility)
  obs.obs_properties_add_float_slider(gprops, "palette_gamma", "Palette gamma exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_button(gprops, "palette_reset", "Reset palette texture", function(properties, property)
    obs.obs_data_set_string(data.settings, "palette_path", ""); data.palette = nil;
    set_properties_visibility(properties, property, data.settings); return true; end)

  return props
end

-- Called each frame
source_info.video_tick = function(data, seconds)
  data.nanoseconds = seconds*1e9
end


-- Returns new texture and free current texture if loaded
function load_texture(path, current_texture)

  obs.obs_enter_graphics()

  -- Free any existing image
  if current_texture then
    obs.gs_image_file_free(current_texture)
  end

  -- Loads and inits image for texture
  local new_texture = nil
  if string.len(path) > 0 then
    new_texture = obs.gs_image_file()
    obs.gs_image_file_init(new_texture, path)
    if new_texture.loaded then
      obs.gs_image_file_init_texture(new_texture)
    else
      obs.blog(obs.LOG_ERROR, "Cannot load image " .. path)
      obs.gs_image_file_free(current_texture)
      new_texture = nil
    end
  end

  obs.obs_leave_graphics()
  return new_texture
end

-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)
  data.gamma = obs.obs_data_get_double(settings, "gamma")
  data.gamma_shift = obs.obs_data_get_double(settings, "gamma_shift")
  data.scale = obs.obs_data_get_double(settings, "scale")
  data.amplitude = obs.obs_data_get_double(settings, "amplitude")
  data.number_of_color_levels = obs.obs_data_get_int(settings, "number_of_color_levels")

  -- Keeps a reference on the settings
  data.settings = settings

  data.offset = obs.obs_data_get_double(settings, "offset")

  local pattern_path = obs.obs_data_get_string(settings, "pattern_path")
  if data.loaded_pattern_path ~= pattern_path then
    data.pattern = load_texture(pattern_path, data.pattern)
    data.loaded_pattern_path = pattern_path
  end
  data.pattern_gamma = obs.obs_data_get_double(settings, "pattern_gamma")

  local palette_path = obs.obs_data_get_string(settings, "palette_path")
  if data.loaded_palette_path ~= palette_path then
    data.palette = load_texture(palette_path, data.palette)
    data.loaded_palette_path = palette_path
  end
  data.palette_gamma = obs.obs_data_get_double(settings, "palette_gamma")

end

EFFECT = [[

  // OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
  #define SamplerState sampler_state
  #define Texture2D texture2d
  
  // Uniform variables set by OBS (required)
  uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
  uniform Texture2D image;   // Texture containing the source picture
  
  // General properties
  uniform float gamma = 1.0;
  uniform float gamma_shift = 0.6;
  uniform int number_of_color_levels = 4.0;
  
  // Size of the source picture
  uniform int width;
  uniform int height;
  
  // Constants
  #define PI 3.141592653589793238
  
  // General properties
  uniform float amplitude = 0.2;
  uniform float scale = 1.0;
  uniform float offset = 0.5;
  
  // Pattern texture
  uniform Texture2D pattern_texture;
  uniform float2 pattern_size = {-1.0, -1.0};
  uniform float pattern_gamma = 1.0;
  
  // Palette texture
  uniform Texture2D palette_texture;
  uniform float2 palette_size = {-1.0, -1.0};
  uniform float palette_gamma = 1.0;
  
  // Interpolation method and wrap mode for sampling a texture
  SamplerState linear_clamp
  {
      Filter    = Linear;     // Anisotropy / Point / Linear
      AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
      AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
      BorderColor = 00000000; // Used only with Border edges (optional)
  };
  
  SamplerState linear_wrap
  {
      Filter    = Linear; 
      AddressU  = Wrap;
      AddressV  = Wrap;
  };
  
  SamplerState point_clamp
  {
      Filter    = Point; 
      AddressU  = Clamp;
      AddressV  = Clamp;
  };
  
  // Data type of the input of the vertex shader
  struct vertex_data
  {
      float4 pos : POSITION;  // Homogeneous space coordinates XYZW
      float2 uv  : TEXCOORD0; // UV coordinates in the source picture
  };
  
  // Data type of the output returned by the vertex shader, and used as input 
  // for the pixel shader after interpolation for each pixel
  struct pixel_data
  {
      float4 pos : POSITION;  // Homogeneous screen coordinates XYZW
      float2 uv  : TEXCOORD0; // UV coordinates in the source picture
  };
  
  // Vertex shader used to compute position of rendered pixels and pass UV
  pixel_data vertex_shader_halftone(vertex_data vertex)
  {
      pixel_data pixel;
      pixel.pos = mul(float4(vertex.pos.xyz, 1.0), ViewProj);
      pixel.uv  = vertex.uv;
      return pixel;
  }
  
  float3 decode_gamma(float3 color, float exponent, float shift)
  {
      return pow(clamp(color, 0.0, 1.0), exponent - shift);
  }
  
  float3 encode_gamma(float3 color, float exponent)
  {
      return pow(clamp(color, 0.0, 1.0), 1.0/exponent);
  }
  
  float4 get_perturbation(float2 position)
  {
      if (pattern_size.x>0)
      {
          float2 pattern_uv = position / pattern_size;
          float4 pattern_sample = pattern_texture.Sample(linear_wrap, pattern_uv / scale);
          float3 linear_color = decode_gamma(pattern_sample.rgb, pattern_gamma, 0.0);
          return float4(2.0*(linear_color-0.5), pattern_sample.a);
      }
      else
          return float4((cos(PI*position.x/scale/4.0) * cos(PI*position.y/scale/4.0)).xxx, 1.0);
  }
  
  float4 get_closest_color(float3 input_color)
  {
      float4 result;
      if (palette_size.x>0)
      {
          float min_distance = 1e10;
          float2 pixel_size = 1.0 / min(256, palette_size);
          for (float u=pixel_size.x/2.0; u<1.0; u+=pixel_size.x)
              for (float v=pixel_size.y/2.0; v<1.0; v+=pixel_size.y)
              {
                  float4 palette_sample = palette_texture.Sample(point_clamp, float2(u, v));
                  float3 linear_color = decode_gamma(palette_sample.rgb, palette_gamma, 0.0);
  
                  float current_distance = distance(input_color, linear_color);
                  if (current_distance < min_distance)
                  {
                      result = float4(linear_color, palette_sample.a);
                      min_distance = current_distance;
                  }
              }
      }
      else
          result = float4(round((number_of_color_levels-1)*input_color)/(number_of_color_levels-1), 1.0);
  
      return result;
  }
  
  float4 pixel_shader_halftone(pixel_data pixel) : TARGET
  {
      float4 source_sample = image.Sample(linear_clamp, pixel.uv);
      float3 linear_color = decode_gamma(source_sample.rgb, gamma, gamma_shift);
  
      float2 position = pixel.uv * float2(width, height);
      float4 perturbation = get_perturbation(position);
  
      float3 perturbed_color = linear_color + offset + amplitude*perturbation.rgb;
  
      float4 closest_color = get_closest_color(clamp(perturbed_color, 0.0, 1.0));
  
      float mix_alpha = perturbation.a * closest_color.a;
      float3 mixed_color = lerp(source_sample.rgb, closest_color.rgb, mix_alpha);
  
      return float4(encode_gamma(mixed_color, gamma), source_sample.a);
  }
  
  
  technique Draw
  {
      pass
      {
          vertex_shader = vertex_shader_halftone(vertex);
          pixel_shader  = pixel_shader_halftone(pixel);
      }
  }
  
]]
```
