-- https://www.shadertoy.com/view/Mdf3Dn
-- https://www.shadertoy.com/view/ltfcRM
-- https://www.shadertoy.com/view/wssGzs
-- https://www.reddit.com/r/Unity3D/comments/bfvxtm/experienced_unity_developers_any_idea_on_how_this/

-- Returns the description displayed in the Scripts window
function script_description()
  return [[<center><h2>Halftone Filter</h2></center>
  <p>This Lua script adds a new video filter named <it>Halftone</it> that approximates colors
  using single-color dots of various sizes. The result look like a magnified printed photo.</p>]]
end

-- Called on script startup with specific settings associated to the script
function script_load(settings)
  -- Registers the template object source_info, used when adding the filter to a video source
  obslua.obs_register_source(source_info)
end


-- Starts the definition of the global variable of type obs_source_info_t, used to create source object instances
-- when the filter is added on a video source or re-created in a scene at OBS start.
-- See https://obsproject.com/docs/reference-sources.html
source_info = {}

-- Unique string identifier for the source (required)
source_info.id = 'filter-halftone'

-- Type of source (one of INPUT/FILTER/TRANSITION)
source_info.type = obslua.OBS_SOURCE_TYPE_FILTER

-- Source output capability flags (required)
-- A bitwise OR combination of VIDEO/AUDIO/ASYNC/etc
source_info.output_flags = obslua.OBS_SOURCE_VIDEO

-- Get the translated name of the source type
-- NOTE: normally there is an argument "type_data", unclear what it means
source_info.get_name = function()
  return "Halftone"
end

-- Sets the default settings for this source
-- Defaults are set to simple settings for custom palettes in case the user selects the palette manually
-- and the default preset is set to a non-customized one
source_info.get_defaults = function(settings)

  obslua.obs_data_set_default_string(settings, "texture_path", "")

end

-- Gets the property information of this source (Optional)
source_info.get_properties = function(data)
  local props = obslua.obs_properties_create()
  obslua.obs_properties_add_path(props, "texture_path", "Texture path", obslua.OBS_PATH_FILE,
    "Picture (*.png *.bmp *.jpg *.gif)", nil)
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

  -- Scale
  obslua.gs_effect_set_int(data.params.width, data.width)
  obslua.gs_effect_set_int(data.params.height, data.height)

  -- Texture
  if data.texture_image then
    obslua.gs_effect_set_texture(data.params.texture_data, data.texture_image.texture)
    obslua.gs_effect_set_int(data.params.texture_width, data.texture_image.cx)
    obslua.gs_effect_set_int(data.params.texture_height, data.texture_image.cy)
  end
  
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

