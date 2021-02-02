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
  print("In source_info.get_name")
  return "Halftone"
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
  local effect_file_path = script_path() .. 'filter-halftone.effect.hlsl'
  -- local effect_file_path = "C:/Program Files/obs-studio/data/obs-plugins/obs-filters/sharpness.effect"
  data.effect = obslua.gs_effect_create_from_file(effect_file_path, nil)
  obslua.obs_leave_graphics()

  -- Calls the destroy function if the effect was not compiled properly
  if data.effect == nil then
    obs.blog(obs.LOG_ERROR, "Effect compilation failed for " .. effect_file_path)
    source_info.destroy(data)
    return nil
  end

  -- Retrieves the shader uniform variables
  data.params = {}
  data.params.width = obslua.gs_effect_get_param_by_name(data.effect, "width")
  data.params.height = obslua.gs_effect_get_param_by_name(data.effect, "height")

  return data
end

-- Destroys and release resources linked to the custom data
source_info.destroy = function(data)
  if data.effect ~= nil then
    obslua.obs_enter_graphics()
    obslua.gs_effect_destroy(data.effect)
    data.effect = nil
    obslua.obs_leave_graphics()
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

  local parent = obs.obs_filter_get_target(data.source)
  if data.width ~= obs.obs_source_get_base_width(parent) then
    print("new width: " .. tostring(obs.obs_source_get_base_width(parent)))
  end
  data.width = obs.obs_source_get_base_width(parent)
  data.height = obs.obs_source_get_base_height(parent)

  obslua.obs_source_process_filter_begin(data.source, obslua.GS_RGBA, obslua.OBS_NO_DIRECT_RENDERING)

  -- Effect parameters initialization goes here
  obslua.gs_effect_set_int(data.params.width, data.width)
  obslua.gs_effect_set_int(data.params.height, data.height)

  obslua.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end


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

]]


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


--[[
-- Sets the default settings for this source
-- Defaults are set to simple settings for custom palettes in case the user selects the palette manually
-- and the default preset is set to a non-customized one
source_info.get_defaults = function(settings)

  obslua.obs_data_set_default_string(settings, "texture_path", "")
  obslua.obs_data_set_default_double(settings, "texture_scale", 1.0)
  obslua.obs_data_set_default_double(settings, "gamma", 1.0)
  obslua.obs_data_set_default_double(settings, "intensity_level", 0.5)
  obslua.obs_data_set_default_double(settings, "intensity_range", 0.1)

end

-- Gets the property information of this source (Optional)
source_info.get_properties = function(data)
  local props = obslua.obs_properties_create()
  obslua.obs_properties_add_path(props, "texture_path", "Texture path", obslua.OBS_PATH_FILE,
    "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obslua.obs_properties_add_float_slider(props, "texture_scale", "Texture scale", 0.01, 10.0, 0.01)

  obslua.obs_properties_add_float_slider(props, "gamma", "Gamma correction", 0.1, 2.5, 0.01)
  obslua.obs_properties_add_float_slider(props, "intensity_level", "Dithering level", 0.0, 1.0, 0.01)
  obslua.obs_properties_add_float_slider(props, "intensity_range", "Dithering range", 0.0, 10.0, 0.01)
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
  obslua.obs_enter_graphics()
  local effect_file_path = script_path() .. 'filter-halftone.effect.hlsl'
  data.effect = obslua.gs_effect_create_from_file(effect_file_path, nil)
  obslua.obs_leave_graphics()

  -- Destroys everything if shader was not compiled properly
  if data.effect == nil then
    print("Effect could not be compiled")
    source_info.destroy(data)
    return nil
  end

  -- Retrieves the shader uniform variables
  data.params = {}
  data.params.width = obslua.gs_effect_get_param_by_name(data.effect, "width")
  data.params.height = obslua.gs_effect_get_param_by_name(data.effect, "height")
  data.params.texture_data = obslua.gs_effect_get_param_by_name(data.effect, "texture_data")
  data.params.texture_width = obslua.gs_effect_get_param_by_name(data.effect, "texture_width")
  data.params.texture_height = obslua.gs_effect_get_param_by_name(data.effect, "texture_height")
  data.params.texture_scale = obslua.gs_effect_get_param_by_name(data.effect, "texture_scale")

  data.params.gamma = obslua.gs_effect_get_param_by_name(data.effect, "gamma")
  data.params.intensity_level = obslua.gs_effect_get_param_by_name(data.effect, "intensity_level")
  data.params.intensity_range = obslua.gs_effect_get_param_by_name(data.effect, "intensity_range")

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  return data
end

-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)
  -- Loads or reloads texture file if path changed
  local texture_path = obslua.obs_data_get_string(settings, "texture_path")
  if data.loaded_texture_path ~= texture_path then
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
      print("Texture loaded - cx=" .. tostring(data.texture_image.cx) ..
                 " cy=" .. tostring(data.texture_image.cy))
    else
      data.texture_image = nil
    end

    data.loaded_texture_path = texture_path
    obslua.obs_leave_graphics()
  end

  data.texture_scale = obslua.obs_data_get_double(settings, "texture_scale")

  data.gamma = obslua.obs_data_get_double(settings, "gamma")
  data.intensity_level = obslua.obs_data_get_double(settings, "intensity_level")
  data.intensity_range = obslua.obs_data_get_double(settings, "intensity_range")

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

  -- Size
  obslua.gs_effect_set_int(data.params.width, data.width)
  obslua.gs_effect_set_int(data.params.height, data.height)

  -- Corrections
  obslua.gs_effect_set_float(data.params.gamma, data.gamma)
  obslua.gs_effect_set_float(data.params.intensity_level, data.intensity_level)
  obslua.gs_effect_set_float(data.params.intensity_range, data.intensity_range)

  -- Texture
  if data.texture_image then
    obslua.gs_effect_set_texture(data.params.texture_data, data.texture_image.texture)
    obslua.gs_effect_set_int(data.params.texture_width, data.texture_image.cx)
    obslua.gs_effect_set_int(data.params.texture_height, data.texture_image.cy)
  end
  obslua.gs_effect_set_float(data.params.texture_scale, data.texture_scale)
  
  obslua.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end

-- Destroys the implementation data for the source
source_info.destroy = function(data)
  if data.effect ~= nil then
    obslua.obs_enter_graphics()
    obslua.gs_effect_destroy(data.effect)
    data.effect = nil
    obslua.obs_leave_graphics()
  end
end

]]
