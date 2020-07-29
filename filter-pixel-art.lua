------------------------------------------------------------------------------------------------------------------------
--                                                                                                                    --
--                               Pixel Art filter for OBS the Open Broadcaster Software                               --
--                                                                                                                    --
--                                    By bfxdev - https://github.com/bfxdev - 2020                                    --
--                                                                                                                    --
------------------------------------------------------------------------------------------------------------------------
--        1         2         3         4         5         6         7         8         9        10        11       --
-- 345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------- IMPORTS -------------------------------------------------------

-- Bitwise operations see https://luajit.org/extensions.html
-- bit = require("bit") 

 -- FFI library see https://luajit.org/ext_ffi.html
-- ffi = require("ffi")

------------------------------------------------- SCRIPT GLOBAL FUNCTIONS ----------------------------------------------

-- Default preset to apply if a source is created and added to a video source
default_preset = 1

-- Initial call sequence: script_defaults, script_description, script_load, script_update, script_properties
-- See https://obsproject.com/docs/scripting.html#script-function-exports

-- Called to retrieve the description string and display it in the script management dialog
-- NOTE: not documented
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

-- Called to set default settings (if any) associated with the script.
-- You would typically call Default Value Functions on the settings in order to set its default values.
-- A default value will create the related setting if not already existing, then passed to the first script_load
-- The parameter settings is of type obs_data_t, see https://obsproject.com/docs/reference-settings.html
function script_defaults(settings)

    print("In script_defaults")

    -- Set default preset at first addition of the script to OBS (if changed later on, then the new value is kept)
    obslua.obs_data_set_default_int(settings, "default_preset", default_preset)

end

-- Called on script startup with specific settings associated with the script.
function script_load(settings)

    print("In script_load")

    -- The source_info is defined below
    print("Calls obs_register_source")
    obslua.obs_register_source(source_info)

end

-- Called when the script’s settings (if any) have been changed by the user.
function script_update(settings)

    print("In script_update")

    default_preset = obslua.obs_data_get_int(settings, "default_preset")

    print("Current default_preset: " .. tostring(obslua.obs_data_get_int(settings, "default_preset")))

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

------------------------------------------------------ EFFECT FILES ----------------------------------------------------

-- The code of the effects files is copied here to avoid distributing several files

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

------------------------------------------------------ SOURCE INFO -----------------------------------------------------

-- Starts the definition of the global variable of type obs_source_info_t, used to create source object instances
-- when the filter is added on a video source or re-created in a scene at OBS start.
-- See https://obsproject.com/docs/reference-sources.html
source_info = {}

-- Unique string identifier for the source (required)
source_info.id = 'filter-pixel-art'

-- Type of source (one of INPUT/FILTER/TRANSITION)
source_info.type = obslua.OBS_SOURCE_TYPE_FILTER

-- Source output capability flags (required)
-- A bitwise OR combination of VIDEO/AUDIO/ASYNC/etc
source_info.output_flags = obslua.OBS_SOURCE_VIDEO

-- Get the translated name of the source type
-- NOTE: normally there is an argument "type_data", unclear what it means
source_info.get_name = function()
    return "Pixel Art"
end

-- Sets the default settings for this source
source_info.get_defaults = function(settings)

    print("In source_info.get_defaults")

    -- Downscaled resolution
    obslua.obs_data_set_default_int(settings, "width", 320)
    obslua.obs_data_set_default_int(settings, "height", 200)

    -- Palette
    -- obslua.obs_data_set_default_string(settings, "palette_image_path", "")
    obslua.obs_data_set_default_int(settings, "palette_preset", 0)
    obslua.obs_data_set_default_bool(settings, "palette_use_bit_depths", false)
    obslua.obs_data_set_default_int(settings, "palette_red_bit_depth", 3)
    obslua.obs_data_set_default_int(settings, "palette_green_bit_depth", 3)
    obslua.obs_data_set_default_int(settings, "palette_blue_bit_depth", 3)
    obslua.obs_data_set_default_int(settings, "palette_length", 16)
    for i=1,64 do
        obslua.obs_data_set_default_int(settings, "palette_color_" .. i, 0xFFFFFFFF)
    end

end

-- Updates the settings for this source (Optional)
source_info.update = function(data, settings)

    print("In source_info.update")

    -- Downscaled resolution
    data.width = obslua.obs_data_get_int(settings, "width")
    data.height = obslua.obs_data_get_int(settings, "height")

    -- Palette image
    local current_path = obslua.obs_data_get_string(settings, "palette_image_path")
    if data.palette_image_path ~= current_path then

        obslua.obs_enter_graphics()

        local image = obslua.gs_image_file()
        obslua.gs_image_file_init(image, current_path)
        obslua.gs_image_file_init_texture(image)
        local tex = image.tex -- obslua.gs_texture_create_from_file(current_path)
        if tex ~= nil then
            data.palette_image_path = current_path
            print("Texture created")
            --obslua.gs_texture_destroy(tex)
        end
        obslua.gs_image_file_free(image)

        obslua.obs_leave_graphics()
    end

    -- Palette preset
    data.palette_preset = obslua.obs_data_get_int(settings, "palette_preset")
    data.palette_use_bit_depths = obslua.obs_data_get_bool(settings, "palette_use_bit_depths")
    data.palette_red_bit_depth = obslua.obs_data_get_int(settings, "palette_red_bit_depth")
    data.palette_green_bit_depth = obslua.obs_data_get_int(settings, "palette_green_bit_depth")
    data.palette_blue_bit_depth = obslua.obs_data_get_int(settings, "palette_blue_bit_depth")
    data.palette_length = obslua.obs_data_get_int(settings, "palette_length")
    -- for i=0,63 do
    --     obslua.obs_data_set_default_int(settings, "palette_color_" .. i, 0xFFFFFFFF)
    -- end

end

-- Gets the property information of this source (Optional)
source_info.get_properties = function(data)

    print("In source_info.get_properties")

    props = obslua.obs_properties_create()

    -- Downscaled resolution
    obslua.obs_properties_add_int(props, "width", "Width", 1, 5000, 1)
    obslua.obs_properties_add_int(props, "height", "Height", 1, 5000, 1)

    -- Palette presets
    local list = obslua.obs_properties_add_list(props, "palette_preset", "Palette preset",
    obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
    obslua.obs_property_list_add_int(list, "Custom by colors",     0)
    obslua.obs_property_list_add_int(list, "Custom by bit depths", 1)
    obslua.obs_property_list_add_int(list, "Amstrad CPC",          2)
    obslua.obs_property_list_add_int(list, "Amstrad CPC+",         3)
    obslua.obs_property_list_add_int(list, "Commodore C64",        4)

    -- Palette by colors
    if data.palette_preset == 0 then
        obslua.obs_properties_add_int(props, "palette_length", "Number of colors", 2, 64, 1)
        for i=1,data.palette_length do
            obslua.obs_properties_add_color(props, "palette_color_" .. i, "Color " .. i)
        end
    end

    -- obslua.obs_properties_add_path(props, "palette_image_path", "Read palette from file",
    --                                obslua.OBS_PATH_FILE, "Bitmap picture (*.jpg *.png)", nil)

    -- obslua.obs_properties_add_color(props, "color", "my color")

    return props
end

-- Creates the implementation data for the source
-- Parameters:	settings – Settings to initialize the source with
--              source – Source that this data is associated with
-- Returns:	The implementation data associated with this source
source_info.create = function(settings, source)

    print("In source_info.create")

    -- Inits filter data object (arbitrary data structure used to keep own data between calls)
    data = {}

    -- The source object instance of the filter itself
    data.source = source

    -- Empty path at the beginning
    data.palette_image_path = ""

    -- Compiles shader
    obslua.obs_enter_graphics()
    data.effect = obslua.gs_effect_create_from_file(script_path() .. 'filter-pixel-art.hlsl', nil)
    if data.effect == nil then
        print("Effect file not compiled - Reverting to luminance effect")
        data.effect = obslua.gs_effect_create(EFFECT_LUMINANCE, "luminance", nil)
    end
    obslua.obs_leave_graphics()

    -- Destroys everything if shader was not compiled properly
    if data.effect == nil then
        print("ERROR: HLSL code not compiled")
        source_info.destroy(data)
        return nil
    end

    -- Calls update to initialize the rest of the propertis-managed settings
    source_info.update(data, settings)

    return data
end

-- Destroys the implementation data for the source
source_info.destroy = function(data)

    print("In source_info.destroy")

    if data.effect ~= nil then
        obslua.obs_enter_graphics()
        obslua.gs_effect_destroy(data.effect)
        obslua.obs_leave_graphics()
    end
end

-- Returns the width of the source, this callback is required if this is a video source and is synchronous
source_info.get_width = function(data)

    local target = obslua.obs_filter_get_target(data.source)

    if target ~= nil then
        --data.width = obslua.obs_source_get_base_width(target)
        --print("Target: " .. obslua.obs_source_get_name(target))
    end

    return data.width
end

-- Returns the height of the source, this callback is required if this is a video source and is synchronous
source_info.get_height = function(data)

    local target = obslua.obs_filter_get_target(data.source)

    if target ~= nil then
        --data.height = obslua.obs_source_get_base_height(target)
    end

    return data.height
end

-- Called when the source has been activated in the main view (visible on stream/recording) (Optional)
source_info.activate = function(data)
    print("In source_info.activate")
end

-- Called when the source has been deactivated in the main view (no longer visible on stream/recording) (Optional)
source_info.deactivate = function(data)
    print("In source_info.deactivate")
end

-- Called when the source is visible on any display and/or on the main view (Optional) 
source_info.show = function(data)
    print("In source_info.show")
end

-- Called when the source is no longer visible on any display and/or on the main view (Optional) 
source_info.hide = function(data)
    print("In source_info.hide")
end

-- Called each video frame with the time elapsed (Optional)
-- source_info.video_tick = function(data, seconds)
    -- set_render_size(data)
-- end

-- Called when rendering the source with the graphics subsystem
-- If this is an input/transition source, this is called to draw the source texture with the graphics subsystem.
-- If this is a filter source, it wraps source draw calls (for example applying a custom effect with custom parameters
--   to a source). In this case, it’s highly recommended to use the obs_source_process_filter_begin() and
--   obs_source_process_filter_end() functions to automatically handle effect-based filter processing. However, you
--   can implement custom draw handling as desired as well.
-- If the source output capability flags do not include OBS_SOURCE_CUSTOM_DRAW, the source must 
--   use obs_source_draw() to render the source’s texture.
-- NOTE: effect – This parameter is no longer used. Instead, call obs_source_draw()
-- See https://obsproject.com/docs/graphics.html#rendering-video-effect-filters
source_info.video_render = function(data, effect)

    obslua.obs_source_process_filter_begin(data.source, obslua.GS_RGBA, obslua.OBS_NO_DIRECT_RENDERING)

    -- obslua.gs_effect_set_int(data.params.hue_steps, data.hue_steps)
    -- obslua.gs_effect_set_int(data.params.value_steps, data.value_steps)

    obslua.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end

-- Called when saving custom data for a source.
-- This is a separate function because sometimes a source needs to know when it is being saved so it doesn’t always have
-- to update the current settings until a certain point (Optional)
source_info.save = function(data, settings)
    print("In source_info.save")
end

-- Called when loading custom data from saved source data.
-- This is called after all the loading sources have actually been created, allowing the ability to reference other
-- sources if desired (Optional)
source_info.load = function(data, settings)
    print("In source_info.load")
end

-- Called when the filter is removed from a source (Optional)
source_info.filter_remove = function(data, source)
    print("In source_info.filter_remove")
end

