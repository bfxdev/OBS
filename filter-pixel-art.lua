------------------------------------------------------------------------------------------------------------------------
--                                                                                                                    --
--                                                                                                                    --
--                                                                                                                    --
--                                                                                                                    --
--                                                                                                                    --
--                                                                                                                    --
------------------------------------------------------------------------------------------------------------------------
--        1         2         3         4         5         6         7         8         9        10        11       --
-- 345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------- IMPORTS -------------------------------------------------------


-- Bitwise operations
bit = require("bit")

------------------------------------------------ SCRIPT GLOBAL FUNCTIONS -----------------------------------------------

-- Initial call sequence: script_defaults, script_description, script_load, script_update, script_properties

-- Called to set default settings (if any) associated with the script.
-- You would typically call Default Value Functions on the settings in order to set its default values.
function script_defaults(settings)

    print("In script_defaults")

    obslua.obs_data_set_default_int(settings, "default_preset", 1)

end

-- Called to retrieve the description string and display it in the script management dialog
function script_description()

    print("In script_description")

    local description = "Pixel Art filter" ..
    "\n\nThis LUA plugin adds a new 'Pixel Art' filter that can be applied on any video source to reduce the " ..
    "pixel resolution and the number of colors and obtain a gorgeous retro-looking picture. " ..
    "It can work with a custom or pre-defined palette and features dithering, downscaling, outlines, etc." ..
    "\n\nAs a main global setting, the default preset can be chosen below. " ..
    "Other settings are available when the filter is added on a source."

    return description

end

-- Called on script startup with specific settings associated with the script.
-- The settings parameter provided is not typically used for settings that are set by the user,
-- instead the parameter is used for any extra internal settings data that may be used in the script.
function script_load(settings)

    print("In script_load")

end

-- Called when the script’s settings (if any) have been changed by the user.
function script_update(settings)

    print("In script_update")

end

-- Called to define user properties associated with the script.
-- These properties are used to define how to show settings properties to a user.
-- Returns: obs_properties_t object created via obs_properties_create().
function script_properties()

    print("In script_properties")

    -- Creates properties object to be displayed on dialog window
    local properties = obslua.obs_properties_create()
    local list = obslua.obs_properties_add_list(properties, "default_preset", "Default Preset",
                                                obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
    obslua.obs_property_list_add_int(list, "Amstrad CPC Mode 0", 0)
    obslua.obs_property_list_add_int(list, "Amstrad CPC Mode 1", 1)
    obslua.obs_property_list_add_int(list, "Amstrad CPC Mode 2", 2)
  
    return properties
end

-- Called when the script is being saved. This is not necessary for settings that are set by the user,
-- instead this is used for any extra internal settings data that may be used in the script.
function script_save(settings)

    print("In script_save")

end

-- Called when the script is being unloaded.
function script_unload()

    print("In script_unload\n")

end


-------------------------------------------------------- SOURCE --------------------------------------------------------



-- Creates structure to define video source filter
source_def = {}
source_def.id = 'filter-pixel-art'
source_def.type = obslua.OBS_SOURCE_TYPE_FILTER
source_def.output_flags = bit.bor(obslua.OBS_SOURCE_VIDEO)

function set_render_size(filter)
    target = obslua.obs_filter_get_target(filter.context)

    local width, height
    if target == nil then
        width = 0
        height = 0
    else
        width = obslua.obs_source_get_base_width(target)
        height = obslua.obs_source_get_base_height(target)
    end

    filter.width = width
    filter.height = height

    local vs = obslua.gs_effect_get_param_by_name(filter.effect, 'ViewSize')
    local v = obslua.vec2()
    v.x = width
    v.y = height
    obslua.gs_effect_set_vec2(vs, v)

end

source_def.get_name = function()
    return "Pixel Art"
end

source_def.create = function(settings, source)


    filter = {}
    filter.params = {}
    filter.context = source

    set_render_size(filter)

    obslua.obs_enter_graphics()
    local error_string = ""
    filter.effect = obslua.gs_effect_create_from_file(script_path() .. 'filter-pixel-art.hlsl', nil)
    -- filter.effect = obslua.gs_effect_create(SHADER, "pixel-art.effect", nil)

    -- if filter.effect ~= nil then
      --  filter.params.hue_steps = obslua.gs_effect_get_param_by_name(filter.effect, 'hue_steps')
      --  filter.params.value_steps = obslua.gs_effect_get_param_by_name(filter.effect, 'value_steps')
    -- end

    obslua.obs_leave_graphics()

    if filter.effect == nil then
        print("effect not compiled:" .. error_string)
        source_def.destroy(filter)
        return nil
    end

    source_def.update(filter, settings)
    return filter
end

source_def.destroy = function(filter)
    if filter.effect ~= nil then
        obslua.obs_enter_graphics()
        obslua.gs_effect_destroy(filter.effect)
        obslua.obs_leave_graphics()
    end
end

source_def.get_width = function(filter)
    return filter.width
end

source_def.get_height = function(filter)
    return filter.height
end

source_def.update = function(filter, settings)
    -- filter.hue_steps = obslua.obs_data_get_int(settings, SETTING_HUE_STEPS)
    -- filter.value_steps = obslua.obs_data_get_int(settings, SETTING_VALUE_STEPS)

    set_render_size(filter)
end

source_def.video_render = function(filter, effect)
    obslua.obs_source_process_filter_begin(filter.context, obslua.GS_RGBA, obslua.OBS_NO_DIRECT_RENDERING)

    -- obslua.gs_effect_set_int(filter.params.hue_steps, filter.hue_steps)
    -- obslua.gs_effect_set_int(filter.params.value_steps, filter.value_steps)

    obslua.obs_source_process_filter_end(filter.context, filter.effect, filter.width, filter.height)
end

source_def.get_properties = function(settings)
    props = obslua.obs_properties_create()

    -- obslua.obs_properties_add_int_slider(props, SETTING_HUE_STEPS, TEXT_HUE_STEPS, 1, 10, 1)
    -- obslua.obs_properties_add_int_slider(props, SETTING_VALUE_STEPS, TEXT_VALUE_STEPS, 1, 10, 1)

    return props
end

source_def.get_defaults = function(settings)
    -- obslua.obs_data_set_default_int(settings, SETTING_HUE_STEPS, 5)
    -- obslua.obs_data_set_default_int(settings, SETTING_VALUE_STEPS, 5)
end

source_def.video_tick = function(filter, seconds)
    set_render_size(filter)
end

print("Calls obs_register_source")
obslua.obs_register_source(source_def)
