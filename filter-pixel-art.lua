------------------------------------------------------------------------------------------------------------------------
--                                                                                                                    --
--                               Pixel Art filter for OBS the Open Broadcaster Software                               --
--                                                                                                                    --
--                                    By bfxdev - https://github.com/bfxdev - 2020                                    --
--                                                                                                                    --
------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------- IMPORTS -------------------------------------------------------

-- Bitwise operations see https://luajit.org/extensions.html
-- bit = require("bit") 

-- FFI library see https://luajit.org/ext_ffi.html
-- ffi = require("ffi")



------------------------------------------------- GLOBAL HELPER FUNCTIONS ----------------------------------------------

-- List of log levels used for display and property selection
LOG_LEVEL_NAMES = {"Debug", "Info", "Warning", "Error", "Nothing"}

-- Global log level
log_level = 1

-- Recursive transformation of table to string
function table_to_string(content)

	local res

	-- Stop condition for recursion
	if type(content) ~= "table" then
		res =  tostring(content)
	
	-- Lists all elements of a table
	else
		res = "{"
		for k,v in pairs(content) do
			if string.len(res) > 1 then res = res .. ", " end
			res = res .. k .. "=" .. table_to_string(v)
		end
		res = res .. "}"
	end
	
	return res
end

-- Main log function, do not use directly
function log(content, level)
	if log_level<= level then
		local str = string.upper(LOG_LEVEL_NAMES[log_level]) .. ": "
		str = str .. table_to_string(content)
		print(str)
	end
end

-- Log functions to be used
function log_debug(content)   log(content, 1) end
function log_info(content)    log(content, 2) end
function log_warning(content) log(content, 3) end
function log_error(content)   log(content, 4) end

-------------------------------------------------------- PRESETS -------------------------------------------------------

-- Types of palettes, used as well as indices of customizable palettes
PALETTE_LIST       = 1
PALETTE_BIT_DEPTHS = 2
PALETTE_LEVELS =     3

-- Set of palettes definition
palettes = {{name="Custom by list of colors"},
            {name="Custom by RGB bit depths"},
            {name="Amstrad CPC", colors={0x000201, 0x00026B, 0x0C02F4, 0x6C0201, 0x690268, 0x6C02F2,
             0xF30506, 0xF00268, 0xF302F4, 0x027801, 0x007868, 0x0C7BF4, 0x6E7B01, 0x6E7D6B, 0x6E7BF6,
             0xF37D0D, 0xF37D6B, 0xFA80F9, 0x02F001, 0x00F36B, 0x0FF3F2, 0x71F504, 0x71F36B, 0x71F3F4,
             0xF3F30D, 0xF3F36D, 0xFFF3F9}},
            {name="Amstrad CPC+", bit_depths={4, 4, 4}},
            {name="Commodore C64", colors={0x000000, 0xf8fcf8, 0x883830, 0x60b4b8, 0x883c90, 0x50a048,
             0x403088, 0xb8cc70, 0x885428, 0x504000, 0xb86860, 0x505050, 0x787878, 0x90e088, 0x7868c0,
             0x989c98}},
            {name="Commodore Amiga", bit_depths={4, 4, 4}}}

-- Index of preset once something is modified
PRESET_CUSTOM = 1

-- Presets of retro computers
presets = {{name="Custom"},
           {name="Amstrad CPC Mode 0", palette_index = 3},
           {name="Amstrad CPC Mode 1", palette_index = 3},
           {name="Amstrad CPC Mode 2", palette_index = 3},
           {name="Commodore C64",      palette_index = 5}}

-- Default preset to apply if a source is created and added to a video source, modifiable in script properties
default_preset_index = 3

------------------------------------------------- GLOBAL SCRIPT FUNCTIONS ----------------------------------------------

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
    obslua.obs_data_set_default_int(settings, "default_preset_index", default_preset_index)

end

-- Called on script startup with specific settings associated with the script.
function script_load(settings)

    print("In script_load")

    -- Registers the template object source_info
    obslua.obs_register_source(source_info)

end

-- Called when the script’s settings (if any) have been changed by the user.
function script_update(settings)

    print("In script_update")

    default_preset_index = obslua.obs_data_get_int(settings, "default_preset_index")

    print("Current default_preset_index: " .. tostring(obslua.obs_data_get_int(settings, "default_preset_index")))

end

-- Called to define user properties associated with the script.
-- These properties are used to define how to show settings properties to a user.
-- Returns: obs_properties_t object created via obs_properties_create().
function script_properties()

    print("In script_properties")

    -- Creates properties object to be displayed on dialog window
    local properties = obslua.obs_properties_create()
    local list = obslua.obs_properties_add_list(properties, "default_preset_index", "Default Preset",
                                                obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)

    -- Fills list with values from presets except PRESET_CUSTOM (special value only displayed once some
    -- other setting part of the preset was changed)
    for k,v in ipairs(presets) do
        if k ~= PRESET_CUSTOM then obslua.obs_property_list_add_int(list, v.name, k) end
    end
  
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

MAX_PALETTE_LENGTH = 64

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


function get_palette_parameters(palette_index)

	local res = {}
	
	--[[ Default values
	for i=1,MAX_PALETTE_LENGTH do
		res["palette_color_" .. i] = 0xFF000000
    end
    res.palette_length = 2
    res.palette_color_2 = 0xFFFFFFFF
    res.palette_red_bit_depth = 3
    res.palette_green_bit_depth = 3
    res.palette_blue_bit_depth = 3 ]]

    -- Retrieves palette info
	local palette = palettes[palette_index]
	if palette.colors ~= nil then
		-- Palette by colors
        res.palette_type = PALETTE_LIST
		res.palette_length = #palette.colors
		for i=1,res.palette_length do
			res["palette_color_" .. i] = palette.colors[i] + 0xFF000000
		end
	elseif palette.bit_depths ~= nil then
		-- Palette by bit depths
		res.palette_type = PALETTE_BIT_DEPTHS
		res.palette_red_bit_depth = palette.bit_depths[1]
		res.palette_green_bit_depth = palette.bit_depths[2]
		res.palette_blue_bit_depth = palette.bit_depths[3]
	else
		print("Palette type not supported yet")
	end

	return res
end

-- Returns an object with members set to key/values
function get_preset_parameters(preset_index)

	-- Retrieves palette index and creates object with palette info
	local palette_index = presets[preset_index].palette_index
	local res = get_palette_parameters(palette_index)
	res.palette_index = palette_index

	-- Additional preset parameters to be added here

	--print("Built by get_preset_parameters():")
	--for k,v in pairs(res) do print(k .. " : " .. v) end
	
	return res
end

-- Sets the default settings for this source
source_info.get_defaults = function(settings)

    print("In source_info.get_defaults")

    -- Main preset (possibly set to PRESET_CUSTOM)
    obslua.obs_data_set_default_int(settings, "preset_index", default_preset_index)
	
	-- Avoids cascaded changes performed by the callback 
    obslua.obs_data_set_default_bool(settings, "forced_change", true)

    -- Downscaled resolution
    -- obslua.obs_data_set_default_int(settings, "width", 320)
    -- obslua.obs_data_set_default_int(settings, "height", 200)

	-- Set defaults from preset
	local parameters = get_preset_parameters(default_preset_index)
	for k,v in pairs(parameters) do
		obslua.obs_data_set_default_int(settings, k, v)
	end

end

-- Updates the settings for this source (Optional)
source_info.update = function(data, settings)

    log_debug("In source_info.update")
	
	-- Makes sure that palette_type reflects the palette selected by the user
	local palette_index = obslua.obs_data_get_int(settings, "palette_index")
	if palette_index == PALETTE_LIST or palette_index == PALETTE_BIT_DEPTHS then
		obslua.obs_data_set_int(settings, "palette_type", palette_index)
    end
	
	-- Keeps a ref on the settings for later use
	data.settings = settings

    -- Downscaled resolution
    -- data.width = obslua.obs_data_get_int(settings, "width")
    -- data.height = obslua.obs_data_get_int(settings, "height")

    --[[ Palette image 
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
    end ]]--

end


function property_modified(props, property, settings)

	print("In property_modified for " .. obslua.obs_property_name(property) .. " forced_change=" .. tostring(obslua.obs_data_get_bool(settings, "forced_change")))
	
    -- Checks and sets flag to prevent cascaded changes
    if obslua.obs_data_get_bool(settings, "forced_change") then
        return false
    end
    obslua.obs_data_set_bool(settings, "forced_change", true)

    -- Gets name of property that was just modified
    local name = obslua.obs_property_name(property)

	-- Return value to trigger refresh or not
    local refresh = false

    -- Main preset
    if name == "preset_index" then
        local preset_index = obslua.obs_data_get_int(settings, "preset_index")
        if preset_index ~= PRESET_CUSTOM then
            local params = get_preset_parameters(preset_index)
            for k,v in pairs(params) do
                obslua.obs_data_set_int(settings, k, v)
            end
        end
		
		-- Refreshes visibility of properties
        set_properties_visibility(props, property, settings)
		refresh = true
		
    -- Palette preset
    elseif name == "palette_index" then
        local palette_index = obslua.obs_data_get_int(settings, "palette_index")
		
		-- Just updates the pallete type in case the user selected "Custom by.." manually
        if palette_index == PALETTE_LIST or palette_index == PALETTE_BIT_DEPTHS then
			obslua.obs_data_set_int(settings, "palette_type", palette_index)
		
		-- Updates all palette parameters if a palette preset was selected
		else
            local params = get_palette_parameters(palette_index)
            for k,v in pairs(params) do
                obslua.obs_data_set_int(settings, k, v)
            end
        end

		-- Set main preset to "Custom" to indicate the main preset was changed 
		obslua.obs_data_set_int(settings, "preset_index", PRESET_CUSTOM)

		-- Refreshes visibility of properties
        set_properties_visibility(props, property, settings)
		refresh = true
    end

    -- Resets flag and returns true if a refersh is necessary
    obslua.obs_data_set_bool(settings, "forced_change", false)
    return refresh
end



-- Sets visible flags of the displayed properties to hide unnecessary parameters
-- Callback on several properties (called as well at first properties widget display)
function set_properties_visibility(props, property, settings)
    print("In set_properties_visibility callback")

    -- Retrieves values from the settings
    local palette_index = obslua.obs_data_get_int(settings, "palette_index")
    local palette_length = obslua.obs_data_get_int(settings, "palette_length")
    local palette_type = obslua.obs_data_get_int(settings, "palette_type")
    local by_colors = (palette_type == PALETTE_LIST)
    local by_bit_depths = (palette_type == PALETTE_BIT_DEPTHS)
	-- print("by_colors=" .. tostring(by_colors) .. " palette_index=" .. palette_index)

	-- Palette
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_length"), by_colors)
	for i=1,MAX_PALETTE_LENGTH do
		obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_color_" .. i), by_colors and i<=palette_length)
	end
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_red_bit_depth"), by_bit_depths)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_green_bit_depth"), by_bit_depths)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_blue_bit_depth"), by_bit_depths)

    -- IMPORTANT TO TRIGGER PROPERTIES REFRESH ON GUI
    return true
end

-- Gets the property information of this source (Optional)
source_info.get_properties = function(data)

    print("In source_info.get_properties")

    -- Always re-create object, and keeps a ref on it
    data.props = obslua.obs_properties_create()

	-- Main preset
    local list = obslua.obs_properties_add_list(data.props, "preset_index", "Main preset",
	                                            obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
	for k,v in ipairs(presets) do
        obslua.obs_property_list_add_int(list, v.name, k)
    end
    obslua.obs_property_set_modified_callback(list, property_modified)
	
    -- Downscaled resolution
    -- obslua.obs_properties_add_int(data.props, "width", "Width", 1, 5000, 1)
    -- obslua.obs_properties_add_int(data.props, "height", "Height", 1, 5000, 1)

    -- Palette presets
    list = obslua.obs_properties_add_list(data.props, "palette_index", "Palette",
	                                      obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
	for k,v in ipairs(palettes) do
        obslua.obs_property_list_add_int(list, v.name, k)
    end
    obslua.obs_property_set_modified_callback(list, property_modified)
	
    -- Palette by colors list
    local pl = obslua.obs_properties_add_int(data.props, "palette_length", "Number of colors", 2, MAX_PALETTE_LENGTH, 1)
    for i=1,MAX_PALETTE_LENGTH do
        obslua.obs_properties_add_color(data.props, "palette_color_" .. i, "Color " .. i)
    end

	-- Palette by bit depths
    obslua.obs_properties_add_int(data.props, "palette_red_bit_depth", "Bit depth Red", 1, 8, 1)
    obslua.obs_properties_add_int(data.props, "palette_green_bit_depth", "Bit depth Green", 1, 8, 1)
    obslua.obs_properties_add_int(data.props, "palette_blue_bit_depth", "Bit depth Blue", 1, 8, 1)

    -- obslua.obs_properties_add_path(props, "palette_image_path", "Read palette from file",
    --                                obslua.OBS_PATH_FILE, "Bitmap picture (*.jpg *.png)", nil)

    obslua.obs_property_set_modified_callback(pl, set_properties_visibility)
	
	-- Activates changes based on property callback
    obslua.obs_data_set_bool(data.settings, "forced_change", false)

    return data.props
end

-- Creates the implementation data for the source
-- Parameters:	settings – Settings to initialize the source with
--              source – Source that this data is associated with
-- Returns:	The implementation data associated with this source
source_info.create = function(settings, source)

    print("In source_info.create")

    -- Inits filter data object (arbitrary data structure used to keep own data between calls)
    data = {}

    -- Defalut resolution values (potentially used before rendering, just in case)
    data.width = 320
    data.height = 200

    -- The source object instance of the filter itself
    data.source = source

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
        data.width = obslua.obs_source_get_base_width(target)
    end

    return data.width
end

-- Returns the height of the source, this callback is required if this is a video source and is synchronous
source_info.get_height = function(data)

    local target = obslua.obs_filter_get_target(data.source)

    if target ~= nil then
        data.height = obslua.obs_source_get_base_height(target)
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

--[[ Prints all members of the "obslua" module
for key,value in pairs(obslua) do
    print(key .. " : " .. tostring(value));
end ]]

--[[ Prints all members of the palettes array
print("Defined palettes:")
for key,value in ipairs(palettes) do
    print(key .. " : " .. tostring(value.name));
end
print("") ]]

--[[ Prints all members of the presets array
print("Defined presets:")
for key,value in ipairs(presets) do
    print(key .. " : " .. tostring(value.name));
end
print("") ]]

