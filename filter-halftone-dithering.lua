obs = obslua

-- Returns the description displayed in the Scripts window
function script_description()
  return [[<center><h2>Halftone Filter with Dithering</h2></center>
  <p>This Lua script adds a video filter named <it>Halftone Dithering</it>. The filter can be added
  to a video source to reduce the number of colors of the input picture. It reproduces
  the style of a magnified printed picture.</p>]]
end

-- Called on script startup
function script_load(settings)
  obs.obs_register_source(source_info)
end

-- Definition of the global variable containing the source_info structure
source_info = {}
source_info.id = 'filter-halftone-dithering'              -- Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
source_info.get_name = function()
  print("In source_info.get_name")
  return "Halftone Dithering"
end

-- Creates the implementation data for the source
source_info.create = function(settings, source)
  print("In source_info.create")

  -- Initializes the custom data table
  local data = {}
  data.source = source -- Keeps a reference to this filter as a source object
  data.width = 1       -- Dummy value during initialization phase
  data.height = 1      -- Dummy value during initialization phase

  -- Compiles the effect
  obs.obs_enter_graphics()
  local effect_file_path = script_path() .. 'filter-halftone-dithering.effect.hlsl'
  -- local effect_file_path = "C:/Program Files/obs-studio/data/obs-plugins/obs-filters/sharpness.effect"
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

function set_texture_effect_parameters(image, param_texture, param_size)
  local size = obs.vec2()
  if image then
    obs.gs_effect_set_texture(param_texture, image.texture)
    obs.vec2_set(size, image.cx, image.cy)
  else
    obs.vec2_set(size, -1, -1)
  end
  obs.gs_effect_set_vec2(param_size, size)
end

-- Called when rendering the source with the graphics subsystem
source_info.video_render = function(data)

  local parent = obs.obs_filter_get_target(data.source)
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

  -- Pattern texture
  set_texture_effect_parameters(data.pattern, data.params.pattern_texture, data.params.pattern_size)
  obs.gs_effect_set_float(data.params.pattern_gamma, data.pattern_gamma)

  -- Palette texture
  set_texture_effect_parameters(data.palette, data.params.palette_texture, data.params.palette_size)
  obs.gs_effect_set_float(data.params.palette_gamma, data.palette_gamma)

  obs.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end

-- Sets the default settings for this source
source_info.get_defaults = function(settings)
  print("In source_info.get_defaults")
  obs.obs_data_set_default_double(settings, "gamma", 1.0)
  obs.obs_data_set_default_double(settings, "gamma_shift", 0.0)
  obs.obs_data_set_default_double(settings, "scale", 1.0)
  obs.obs_data_set_default_double(settings, "amplitude", 0.2)
  obs.obs_data_set_default_int(settings, "number_of_color_levels", 4)

  obs.obs_data_set_default_string(settings, "pattern_path", "")
  obs.obs_data_set_default_double(settings, "pattern_gamma", 1.0)
  obs.obs_data_set_default_string(settings, "palette_path", "")
  obs.obs_data_set_default_double(settings, "palette_gamma", 1.0)
end

-- Gets the property information of this source
source_info.get_properties = function(data)
  print("In source_info.get_properties")
  local props = obs.obs_properties_create()
  obs.obs_properties_add_float_slider(props, "gamma", "Gamma encoding exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_float_slider(props, "gamma_shift", "Gamma shift", -2.0, 2.0, 0.01)
  obs.obs_properties_add_float_slider(props, "scale", "Pattern scale", 0.01, 10.0, 0.01)
  obs.obs_properties_add_float_slider(props, "amplitude", "Perturbation amplitude", 0.0, 2.0, 0.01)

  obs.obs_properties_add_path(props, "pattern_path", "Pattern path", obs.OBS_PATH_FILE,
                              "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_properties_add_float_slider(props, "pattern_gamma", "Pattern gamma exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_button(props, "pattern_reset", "Reset pattern", function()
    obs.obs_data_set_string(data.settings, "pattern_path", ""); data.pattern = nil; return true; end)

  obs.obs_properties_add_int_slider(props, "number_of_color_levels", "Number of color levels", 2, 10, 1)

  obs.obs_properties_add_path(props, "palette_path", "Palette path", obs.OBS_PATH_FILE,
                              "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_properties_add_float_slider(props, "palette_gamma", "Palette gamma exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_button(props, "palette_reset", "Reset palette", function()
     obs.obs_data_set_string(data.settings, "palette_path", ""); data.palette = nil; return true; end)

  return props
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
  print("In source_info.update")
  data.gamma = obs.obs_data_get_double(settings, "gamma")
  data.gamma_shift = obs.obs_data_get_double(settings, "gamma_shift")
  data.scale = obs.obs_data_get_double(settings, "scale")
  data.amplitude = obs.obs_data_get_double(settings, "amplitude")
  data.number_of_color_levels = obs.obs_data_get_int(settings, "number_of_color_levels")

  -- NEW Keeps a reference on the settings NEW
  data.settings = settings

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

--[[
  local pattern_path = obs.obs_data_get_string(settings, "pattern_path")
  if data.loaded_pattern_path ~= pattern_path then
    print("Loading " .. pattern_path)
    obs.obs_enter_graphics()

    -- Free any existing image
    if data.pattern then
      obs.gs_image_file_free(data.pattern)
    end

    -- Loads and inits image for texture
    if string.len(pattern_path) > 0 then
      -- Loads and inits image for texture
      data.pattern = obs.gs_image_file()
      obs.gs_image_file_init(data.pattern, pattern_path)
      obs.gs_image_file_init_texture(data.pattern)
      print("Pattern loaded - cx=" .. tostring(data.pattern.cx) ..
                 " cy=" .. tostring(data.pattern.cy))
    else
      data.pattern = nil
    end

    data.loaded_pattern_path = pattern_path
    obs.obs_leave_graphics()
  end
]]

--[[
OBS Start:
[filter-halftone.lua] In source_info.get_name
[filter-halftone.lua] In source_info.create
[filter-halftone.lua] In source_info.create
[filter-halftone.lua] In source_info.create
[filter-halftone.lua] In source_info.load
[filter-halftone.lua] In source_info.load
[filter-halftone.lua] In source_info.load
[filter-halftone.lua] In source_info.show
[filter-halftone.lua] In source_info.activate
[filter-halftone.lua] In source_info.show
[filter-halftone.lua] In source_info.activate
[filter-halftone.lua] In source_info.show
[filter-halftone.lua] In source_info.activate

Script Reload:
[Unknown Script] In source_info.destroy
[Unknown Script] In source_info.destroy
[Unknown Script] In source_info.destroy
[filter-halftone.lua] In source_info.get_name
[filter-halftone.lua] In source_info.create
[filter-halftone.lua] In source_info.create
[filter-halftone.lua] In source_info.create

OBS Closure:
21:29:28.869: [Lua: filter-halftone.lua] In source_info.save
21:29:28.869: [Lua: filter-halftone.lua] In source_info.save
21:29:28.869: [Lua: filter-halftone.lua] In source_info.save
21:29:28.887: [Unknown Script] In source_info.destroy
21:29:28.887: [Unknown Script] In source_info.destroy
21:29:28.887: [Unknown Script] In source_info.destroy

Filter added:
21:34:42.929: [Lua: filter-halftone.lua] In source_info.create
21:34:42.929: User added filter 'Halftone' (filter-halftone) to source 'Media Source'

Filter removed:
21:33:37.310: User removed filter 'Halftone' (filter-halftone) from source 'Media Source'
21:33:37.310: [Lua: filter-halftone.lua] In source_info.destroy
21:33:37.314: [Lua: filter-halftone.lua] In source_info.save
21:33:37.315: [Lua: filter-halftone.lua] In source_info.save



source_info.update = function(data, settings)
  print("In source_info.update")
end


source_info.activate = function(data)
  print("In source_info.activate")
end

source_info.deactivate = function(data)
  print("In source_info.deactivate")
end

source_info.show = function(data)
  print("In source_info.show")
end

source_info.hide = function(data)
  print("In source_info.hide")
end

source_info.save = function(data)
  print("In source_info.save")
end

source_info.load = function(data)
  print("In source_info.load")
end
]]


--[[
-- Sets the default settings for this source
-- Defaults are set to simple settings for custom palettes in case the user selects the palette manually
-- and the default preset is set to a non-customized one
source_info.get_defaults = function(settings)

  obs.obs_data_set_default_string(settings, "texture_path", "")
  obs.obs_data_set_default_double(settings, "texture_scale", 1.0)
  obs.obs_data_set_default_double(settings, "gamma", 1.0)
  obs.obs_data_set_default_double(settings, "intensity_level", 0.5)
  obs.obs_data_set_default_double(settings, "intensity_range", 0.1)

end

-- Gets the property information of this source (Optional)
source_info.get_properties = function(data)
  local props = obs.obs_properties_create()
  obs.obs_properties_add_path(props, "texture_path", "Texture path", obs.OBS_PATH_FILE,
    "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_properties_add_float_slider(props, "texture_scale", "Texture scale", 0.01, 10.0, 0.01)

  obs.obs_properties_add_float_slider(props, "gamma", "Gamma correction", 0.1, 2.5, 0.01)
  obs.obs_properties_add_float_slider(props, "intensity_level", "Dithering level", 0.0, 1.0, 0.01)
  obs.obs_properties_add_float_slider(props, "intensity_range", "Dithering range", 0.0, 10.0, 0.01)
  return props
end

-- Creates the implementation data for the source
-- Parameters:	settings – Settings to initialize the source with
--              source – Source that this data is associated with
-- Returns:	The implementation data associated with this source
source_info.create = function(settings, source)
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
  obs.obs_enter_graphics()
  local effect_file_path = script_path() .. 'filter-halftone.effect.hlsl'
  data.effect = obs.gs_effect_create_from_file(effect_file_path, nil)
  obs.obs_leave_graphics()

  -- Destroys everything if shader was not compiled properly
  if data.effect == nil then
    print("Effect could not be compiled")
    source_info.destroy(data)
    return nil
  end

  -- Retrieves the shader uniform variables
  data.params = {}
  data.params.width = obs.gs_effect_get_param_by_name(data.effect, "width")
  data.params.height = obs.gs_effect_get_param_by_name(data.effect, "height")
  data.params.texture_data = obs.gs_effect_get_param_by_name(data.effect, "texture_data")
  data.params.texture_width = obs.gs_effect_get_param_by_name(data.effect, "texture_width")
  data.params.texture_height = obs.gs_effect_get_param_by_name(data.effect, "texture_height")
  data.params.texture_scale = obs.gs_effect_get_param_by_name(data.effect, "texture_scale")

  data.params.gamma = obs.gs_effect_get_param_by_name(data.effect, "gamma")
  data.params.intensity_level = obs.gs_effect_get_param_by_name(data.effect, "intensity_level")
  data.params.intensity_range = obs.gs_effect_get_param_by_name(data.effect, "intensity_range")

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  return data
end

-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)
  -- Loads or reloads texture file if path changed
  local texture_path = obs.obs_data_get_string(settings, "texture_path")
  if data.loaded_texture_path ~= texture_path then
    obs.obs_enter_graphics()

    -- Free any existing image
    if data.texture_image then
      obs.gs_image_file_free(data.texture_image)
    end

    -- Loads and inits image for texture
    if string.len(texture_path) > 0 then
      -- Loads and inits image for texture
      data.texture_image = obs.gs_image_file()
      obs.gs_image_file_init(data.texture_image, texture_path)
      obs.gs_image_file_init_texture(data.texture_image)
      print("Texture loaded - cx=" .. tostring(data.texture_image.cx) ..
                 " cy=" .. tostring(data.texture_image.cy))
    else
      data.texture_image = nil
    end

    data.loaded_texture_path = texture_path
    obs.obs_leave_graphics()
  end

  data.texture_scale = obs.obs_data_get_double(settings, "texture_scale")

  data.gamma = obs.obs_data_get_double(settings, "gamma")
  data.intensity_level = obs.obs_data_get_double(settings, "intensity_level")
  data.intensity_range = obs.obs_data_get_double(settings, "intensity_range")

end

-- Returns the width of the source, this callback is required if this is a video source and is synchronous
source_info.get_width = function(data)
  local target = obs.obs_filter_get_target(data.source)
  if target ~= nil then data.width = obs.obs_source_get_base_width(target) end
  return data.width
end
-- Returns the height of the source, this callback is required if this is a video source and is synchronous
source_info.get_height = function(data)
  local target = obs.obs_filter_get_target(data.source)
  if target ~= nil then data.height = obs.obs_source_get_base_height(target) end
  return data.height
end

-- Called when rendering the source with the graphics subsystem
-- If this is a filter source, it wraps source draw calls (for example applying a custom effect with custom parameters
--   to a source). In this case, it’s highly recommended to use the obs_source_process_filter_begin() and
--   obs_source_process_filter_end() functions to automatically handle effect-based filter processing. However, you
--   can implement custom draw handling as desired as well.
-- See https://obsproject.com/docs/graphics.html#rendering-video-effect-filters
source_info.video_render = function(data)
  obs.obs_source_process_filter_begin(data.source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)

  -- Size
  obs.gs_effect_set_int(data.params.width, data.width)
  obs.gs_effect_set_int(data.params.height, data.height)

  -- Corrections
  obs.gs_effect_set_float(data.params.gamma, data.gamma)
  obs.gs_effect_set_float(data.params.intensity_level, data.intensity_level)
  obs.gs_effect_set_float(data.params.intensity_range, data.intensity_range)

  -- Texture
  if data.texture_image then
    obs.gs_effect_set_texture(data.params.texture_data, data.texture_image.texture)
    obs.gs_effect_set_int(data.params.texture_width, data.texture_image.cx)
    obs.gs_effect_set_int(data.params.texture_height, data.texture_image.cy)
  end
  obs.gs_effect_set_float(data.params.texture_scale, data.texture_scale)
  
  obs.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end

-- Destroys the implementation data for the source
source_info.destroy = function(data)
  if data.effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(data.effect)
    data.effect = nil
    obs.obs_leave_graphics()
  end
end

]]
