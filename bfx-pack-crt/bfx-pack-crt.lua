-------------------------------------------------=--------------------------------------------------
--                                                                                                --
--                          Collection of typical Cathodic Ray Tube effects                       --
--                                                                                                --
--                                     v1.0 - bfxdev - 2023                                       --
--                                                                                                --
--                                                                                                --
-- To be implemented: curvature, HSync lost and weak, VSync lost and weak, noise (source+filter), --
--                    scan lines, RGB convergence, PAL colors, gain (white), moving dark band,    --
--                    echo, bloom, ...                                                            --
--                    aperture grille / shadow mask https://www.youtube.com/watch?v=13bpgc8ZxTo,  --
--                    transition after weak then lost signal                                      --
--                                                                                                --
-------------------------------------------------=--------------------------------------------------

-- Module obslua renamed by convention for commonality with Python code
obs = obslua

--------------------------------------- OBS SCRIPT FUNCTIONS ---------------------------------------

-- Returns the description to be displayed in the Scripts window
-- See https://obsproject.com/docs/scripting.html#script_description
function script_description()

  -- See https://doc.qt.io/qt-5/richtext-html-subset.html
  local description = [[<center><h2> BFX Pack CRT </h2></center><br/>
                        <p>Pack of filters and transitions to reproduce typical glitches and
                        appearance of Cathodic Ray Tube devices</p>]]

  return description
end

-- Called on script startup
-- See https://obsproject.com/docs/scripting.html#script_load
script_effect = nil
function script_load(settings)

  -- Compiles the effect from a .effect file in the same folder as the Lua script
  -- See https://obsproject.com/docs/graphics.html
  obs.obs_enter_graphics()
  local effect_file_path = script_path() .. 'bfx-pack-crt.effect.hlsl'
  script_effect = obs.gs_effect_create_from_file(effect_file_path, nil)
  -- data.effect = obs.gs_effect_create(EFFECT, 'lua_embedded_effect', nil)

  -- Replaces the effect with an annoying solid PINK color if the compilation failed
  local params = nil
  if script_effect == nil then
    print("Effect compilation failed")
    local FALLBACK_EFFECT=[[uniform float4x4 ViewProj; uniform texture2d image;
      struct ShaderData { float4 pos : POSITION; float2 uv  : TEXCOORD0; };
      ShaderData vertex_shader(ShaderData vtx)
      { vtx.pos = mul(float4(vtx.pos.xyz, 1.0), ViewProj); return vtx; }
      float4 pixel_shader(ShaderData pix) : TARGET
      { return float4(1.0,0.0, 0.5, 1.0); }
      technique Draw {
        pass {
          vertex_shader = vertex_shader(vtx);
          pixel_shader  = pixel_shader(pix);
        }
      } ]]
      script_effect = obs.gs_effect_create(FALLBACK_EFFECT, 'fallback_effect', nil)

  -- If the compilation was successful then retrieves parameters for the shader uniform variables
  else
    local uniforms = {"time", "random", "resolution", "source_resolution", "level",
      "hsync_shift_threshold", "hsync_shift_scale", "hsync_wave_level", "hsync_wave_scale",
      "hsync_wave_speed", "hsync_lost", "sync_bars_displayed", "sync_bars_color"}
    params = {}
    for _,name in ipairs(uniforms) do
      params[name] = obs.gs_effect_get_param_by_name(script_effect, name)
    end
  end
  obs.obs_leave_graphics()

  -- Creates and registers the source_info structure for the HSync filter
  local hsync = create_source_info(script_effect, params, 'bfx-crt-hsync', "BFX CRT H-Sync", 1,
    obs.OBS_SOURCE_TYPE_FILTER, obs.OBS_SOURCE_VIDEO,
    hsync_get_defaults, hsync_get_properties, hsync_update, hsync_video_render)
  obs.obs_register_source(hsync)

  -- Creates and registers the source_info structure for the Noise filter
  local noise = create_source_info(script_effect, params, 'bfx-crt-noise', "BFX CRT Noise", 1,
    obs.OBS_SOURCE_TYPE_FILTER, obs.OBS_SOURCE_VIDEO,
    noise_get_defaults, noise_get_properties, noise_update, noise_video_render)
  obs.obs_register_source(noise)

end

-- Called when the script is being unloaded
-- See https://obsproject.com/docs/scripting.html#script_unload
function script_unload()

  -- Destroys the previously compiled effect if any (custom effect or fallback)
  if script_effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(script_effect)
    script_effect = nil
    obs.obs_leave_graphics()
  end
end

------------------------------------- GENERIC SOURCE FUNCTIONS -------------------------------------

-- Returns a source_info structure with the given parameters.
-- Default functions are implemented such that the `data` structure will contain `width`, `height`,
-- `effect`, `params` set to nil for fallback effect, `this_source` as reference of the source
-- object and will finally by initialized by calling `update`.
-- See https://obsproject.com/docs/reference-sources.html
---@param effect any Compiled effect of type gs_effect_t
---@param params table Table of gs_eparam_t userdata for uniform variables (same name as in shader)
---@param id string Unique string identifier for the source
---@param name string String returned by get_name()
---@param version integer Source version, incremented if previous settings are no longer compatible
---@param type integer Either obs.OBS_SOURCE_TYPE_FILTER or _SOURCE or _TRANSITION
---@param output_flags integer Combination obs.OBS_SOURCE_VIDEO, _AUDIO, _CUSTOM_DRAW, _INTERACTION
---@param get_defaults function Custom implementation of get_defaults(settings)
---@param get_properties function Custom implementation of get_properties(data)
---@param update function Custom implementation of update(data, settings)
---@param video_render function Custom implementation of video_render(data)
---@return table source_info The source_info structure filled with the necessary members
function create_source_info(effect, params, id, name, version, type, output_flags,
                            get_defaults, get_properties, update, video_render)

  -- Sets given parameters
  local res = {}
  res.effect = effect
  res.params = params
  res.id = id
  res.version = version
  res.type = type
  res.output_flags = output_flags
  res.get_defaults = get_defaults
  res.update = update

  -- Get the translated name of the source type
  -- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_name
  res.get_name = function()
    return name
  end

  -- Default implementation that initializes the data structure and calls `update`
  -- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.create
  res.create = function(settings, source)

    -- Initializes the custom data table with source reference and dummy size for initialization
    local data = {this_source=source, width=1, height=1, effect=effect, params=params}

    -- Calls `update` to initialize the rest of the properties-managed settings
    res.update(data, settings)
    --data.level = 0.5

    return data
  end

  -- Creates a set of properties to be displayed in the filter GUI
  -- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_properties
  res.get_properties = function(data)

    -- Calls the custom get_properties function if compilation was successful
    if data.params ~= nil then
      return get_properties(data)

    -- Displays a simple message in the properties if compilation failed
    else
      local props = obs.obs_properties_create()
      local description = [[<center>THE EFFECT COULD NOT BE COMPILED - CHECK THE LOGS</center>]]
      obs.obs_properties_add_text(props, "dummy", description, obs.OBS_TEXT_INFO)
      return props
    end

  end

  -- Returns the width of the source
  -- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_width
  res.get_width = function(data)
    return data.width
  end

  -- Returns the height of the source
  -- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_height
  res.get_height = function(data)
    return data.height
  end

  -- Called when rendering the source with the graphics subsystem
  -- Default implementation that manages the fallback effect and the common shader parameters
  -- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.video_render
  res.video_render = function(data)

    -- Determines the target source resolution, taking potential re-scaling into account in filter
    -- chain. Values of width and height need to be kept to be returned by get_width and get_height.
    local target = obs.obs_filter_get_target(data.this_source)
    data.width = obs.obs_source_get_base_width(target)
    data.height = obs.obs_source_get_base_height(target)

    -- Sets common shader parameters if compilation was successful, then calls the custom rendering
    if data.params ~= nil then

      -- Calls the custom video_render
      video_render(data)

    -- Renders the fallback shader if compilation failed
    else
      obs.obs_source_process_filter_begin(data.this_source, obs.GS_RGBA,obs.OBS_NO_DIRECT_RENDERING)
      obs.obs_source_process_filter_end(data.this_source, data.effect, data.width, data.height)
    end

  end

  return res
end

-- Sets the uniform variables in the shader (to be called after obs_source_process_filter_begin)
---@param data table The data structure of this source
function set_common_shader_parameters(data)

  if data.params ~= nil then

    -- Resolutions
    local resolution = obs.vec2()
    obs.vec2_set(resolution, data.width, data.height)
    obs.gs_effect_set_vec2(data.params.resolution, resolution)
    local parent = obs.obs_filter_get_parent(data.this_source)
    local source_resolution = obs.vec2()
    obs.vec2_set(source_resolution, obs.obs_source_get_base_width(parent),
                                    obs.obs_source_get_base_height(parent))
    obs.gs_effect_set_vec2(data.params.source_resolution, source_resolution)

    -- Time and random
    obs.gs_effect_set_float(data.params.time, os.clock())
    obs.gs_effect_set_float(data.params.random, math.random())

  end
end

------------------------------------------- H-SYNC FILTER ------------------------------------------

-- Sets the default settings for this source
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_defaults
-- See https://obsproject.com/docs/reference-settings.html
function hsync_get_defaults(settings)

  obs.obs_data_set_default_double(settings, "hsync_shift_threshold", 0.5)
  obs.obs_data_set_default_double(settings, "hsync_shift_scale", 1.0)
  obs.obs_data_set_default_double(settings, "hsync_wave_level", 0.5)
  obs.obs_data_set_default_double(settings, "hsync_wave_scale", 1.0)
  obs.obs_data_set_default_double(settings, "hsync_wave_speed", 1.0)
  obs.obs_data_set_default_bool(settings, "hsync_lost", false)
  obs.obs_data_set_default_bool(settings, "sync_bars_displayed", false)
  obs.obs_data_set_default_int(settings, "sync_bars_color", 0xFF000000)
end

--[[
-- Callback to set the visibility of properties
-- See https://obsproject.com/docs/reference-properties.html#c.obs_property_set_modified_callback
function set_visibility(props, property, settings)

  --local checked = obs.obs_data_get_bool(settings, "matrix_group")

  --local prop = obs.obs_properties_get(props, "template_matrix4_" .. i)
  --obs.obs_property_set_visible(prop, checked)

  -- Returns true to trigger a refresh of the properties window
  return true
end
]]

-- Creates a set of properties to be displayed in the filter GUI
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_properties
-- See https://obsproject.com/docs/reference-properties.html
function hsync_get_properties(data)

  -- Creates the data structure to be returned
  local props = obs.obs_properties_create()

  -- Recommendations
  --local description = [[<center>text</center>]]
  --obs.obs_properties_add_text(props, "dummy", description, obs.OBS_TEXT_INFO)

  obs.obs_properties_add_bool(props, "hsync_lost", "H-Sync Lost")
  obs.obs_properties_add_bool(props, "sync_bars_displayed", "Display Sync Bars")
  obs.obs_properties_add_color_alpha(props, "sync_bars_color", "Color of Sync Bars")
  obs.obs_properties_add_float_slider(props, "hsync_shift_threshold", "Shift Threshold",
                                      0.0, 1.1, 0.01)
  obs.obs_properties_add_float_slider(props, "hsync_shift_scale", "Shift Scale", 0.0, 5.0, 0.01)
  obs.obs_properties_add_float_slider(props, "hsync_wave_level", "Wave Influence", 0.0, 1.0, 0.01)
  obs.obs_properties_add_float_slider(props, "hsync_wave_scale", "Wave Scale", 0.01, 30.0, 0.01)
  obs.obs_properties_add_float_slider(props, "hsync_wave_speed", "Wave Speed", 0.0, 5.0, 0.01)

  return props
end

-- Updates the internal data for this source upon settings change
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.update
function hsync_update(data, settings)

  data.hsync_shift_threshold = obs.obs_data_get_double(settings, "hsync_shift_threshold")
  data.hsync_shift_scale = obs.obs_data_get_double(settings, "hsync_shift_scale")
  data.hsync_wave_level = obs.obs_data_get_double(settings, "hsync_wave_level")
  data.hsync_wave_scale = obs.obs_data_get_double(settings, "hsync_wave_scale")
  data.hsync_wave_speed = obs.obs_data_get_double(settings, "hsync_wave_speed")
  data.hsync_lost = obs.obs_data_get_bool(settings, "hsync_lost")
  data.sync_bars_displayed = obs.obs_data_get_bool(settings, "sync_bars_displayed")

  local c = obs.obs_data_get_int(settings, "sync_bars_color")
  data.sync_bars_color = obs.vec4()
  obs.vec4_set(data.sync_bars_color, (c%256)/255, (math.floor(c/256)%256)/255,
                                     (math.floor(c/256^2)%256)/255, (math.floor(c/256^3)%256)/255)

end

-- Called when rendering the source with the graphics subsystem
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.video_render
function hsync_video_render(data)

  -- Begins the rendering
  local technique = "DrawHSync"
  obs.obs_source_process_filter_begin(data.this_source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)
  set_common_shader_parameters(data)

  -- Sets filter-specific uniform variables in the shader
  obs.gs_effect_set_float(data.params.hsync_shift_threshold, data.hsync_shift_threshold)
  obs.gs_effect_set_float(data.params.hsync_shift_scale, data.hsync_shift_scale)
  obs.gs_effect_set_float(data.params.hsync_wave_level, data.hsync_wave_level)
  obs.gs_effect_set_float(data.params.hsync_wave_scale, data.hsync_wave_scale)
  obs.gs_effect_set_float(data.params.hsync_wave_speed, data.hsync_wave_speed)
  obs.gs_effect_set_bool(data.params.hsync_lost, data.hsync_lost)
  obs.gs_effect_set_bool(data.params.sync_bars_displayed, data.sync_bars_displayed)
  obs.gs_effect_set_vec4(data.params.sync_bars_color, data.sync_bars_color)

  -- Completes the filter processing i.e. starts the draw through the effect shaders
  obs.obs_source_process_filter_tech_end(data.this_source, data.effect,
                                         data.width, data.height, technique)
end


-------------------------------------------- NOISE FILTER ------------------------------------------

function noise_get_defaults(settings)
  obs.obs_data_set_default_double(settings, "level", 0.5)
end

function noise_update(data, settings)
  data.level = obs.obs_data_get_double(settings, "level")
end

function noise_get_properties(data)
  local props = obs.obs_properties_create()
  obs.obs_properties_add_float_slider(props, "level", "Level", 0.0, 1.0, 0.01)
  return props
end

function noise_video_render(data)

  -- Begins the rendering
  local technique = "DrawNoise"
  obs.obs_source_process_filter_begin(data.this_source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)
  set_common_shader_parameters(data)

  -- Sets filter-specific uniform variables in the shader
  obs.gs_effect_set_float(data.params.level, data.level)

  -- Completes the filter processing i.e. starts the draw through the effect shaders
  obs.obs_source_process_filter_tech_end(data.this_source, data.effect,
                                         data.width, data.height, technique)
end


