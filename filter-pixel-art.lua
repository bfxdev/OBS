------------------------------------------------------------------------------------------------------------------------
--                                                                                                                    --
--                               Pixel Art filter for OBS the Open Broadcaster Software                               --
--                                                                                                                    --
--                                    By bfxdev - https://github.com/bfxdev - 2020                                    --
--                                                                                                                    --
-- Motivation: The main purpose of this video filter plugin is to produce a picture with various constraints on the   --
--             resolution, the number of colors and color space in order to mimic the display of computers of the     --
--             8-bits / 16-bits era or Pixel Art pictures. Another aim of this plugin is to showcase what can be      --
--             done using the Lua framework of OBS, with an explicit intent to hide the underlying complexity and     --
--             make the settings easily understandable for the user.                                                  --
--                                                                                                                    --
--             Needs and requirements can be summarized as:                                                           --
--              - Multi-stage, highly-parameterized processing through activable steps including:                     --
--                 1. Downscale: resolution adaptation (pixelization and border), no color adaptation                 --
--                 2. Palette: definition of overall set of colors allowed in the ouput pictures                      --
--                 3. Coloration: reduction to a fixed number of colors in the output picture                         --
--                 4. Dithering: use of mix of dots of several colors to render different shades                      --
--                 5. Outline: line drawn drawn on top of the final picture, following detected edges                 --
--              - Some parameters are not part of the main preset: downscale method, dithering, outline               --
--              - Palette given either by a list of RGB colors or by a reduced number of levels on RGB components     --
--                and Intensity (RGBI model for e.g. https://en.wikipedia.org/wiki/Color_Graphics_Adapter), with      --
--                pre-defined palettes that can e selected and customized if necessary                                --
--              - Emulation of hardware constraints such as reduced resolution with non-square pixels, border,        --
--                limited number of displayed colors, to mimic e.g. Mode 2 on Amstrad CPC with 640x200 pixels in 2    --
--                displayed colors out of 27 in the palette and 1x2 pixel blocks on monitor resolution of 768x544     --
--              - Support of pre-defined, customizable and automatic Coloration for the assignment of palette         --
--                colors to displayed colors (automatic Coloration based on source picture analysis)                  --
--              - GUI allowing the user to select and customize in a similar way the different presets (main preset   --
--                to select in one click all properties of e.g. a particular computer to emulate, including the       --
--                selection of sub-presets such as the Palette or Coloration), with a large collection of well-known  --
--                retro computers and common Pixel Art palettes                                                       --
--              - GUI allowing the user to activate/de-activate the different processing stages, to understand easily --
--                which parameters are related to which stage, and to see directly the result of any change           --
--              - Single-pixel outline based on Sobel filters or pixel-level rules, then optimzed according to        --
--                https://sites.google.com/site/tiffanycinglis/research/pixelating-vector-line-art                    --
--              - Downscale based on several methods like sub-smapling, bilinear interpolation or methods like        --
--                http://people.inf.ethz.ch/~cengizo/Files/Sig15PerceptualDownscaling.pdf or                          --
--                https://johanneskopf.de/publications/downscaling/paper/downscaling.pdf                              --
--                                                                                                                    --
------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------- IMPORTS -------------------------------------------------------

-- Bitwise operations see https://luajit.org/extensions.html
-- bit = require("bit") 

-- FFI library see https://luajit.org/ext_ffi.html
ffi = require("ffi")

-------------------------------------------------- GLOBAL LOG FUNCTIONS ------------------------------------------------

-- List of log levels used for display and property selection
LOG_LEVEL_NAMES = {"Debug", "Info", "Warning", "Error", "Nothing"}

-- Global log level
log_level = 3

-- Recursive transformation of any object to string (with max depth)
MAX_PARSE_DEPTH = 10
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

	-- Lists all elements of a function
	elseif type(content) == "function" then
        res = "function" -- .. as_string(debug.getinfo(content), MAX_PARSE_DEPTH) -- removed not useful

    -- Type string
    elseif type(content) == "string" then
        res =  tostring(content)
        if depth > 0 then
            res = "\"" .. res .. "\""
        end

    -- Everything else
    else
        res =  tostring(content)
    end

	return res
end

-- Main log function, do not use directly
-- Level to track if we are at level 0 (not quotes on string) and avoid infinite recursions
-- Multiple arguments displayed with spaces  between (python-like)
function log(level, ...)
    if log_level<= level then
        local str = string.upper(LOG_LEVEL_NAMES[level]) .. ":"
        for k,v in pairs({...}) do
            str = str .. " " .. as_string(v, 0)
        end
        print(str)
	end
end

-- Log functions to be used
function log_debug(...)   log(1, ...) end
function log_info(...)    log(2, ...) end
function log_warning(...) log(3, ...) end
function log_error(...)   log(4, ...) end

------------------------------------------------ GLOBAL HELPER FUNCTIONS -----------------------------------------------

-- Sets variables and values in the obs_data object `settings` according to the typed data given in `parameters`
-- Uses the obs_data_set_default_* if `default` is true
function set_obs_data_settings(settings, parameters, default)

    for k,v in pairs(parameters) do
        -- Float/double
        if type(v) == 'number' and (string.find(k, "_ratio")~=nil or string.find(k, "_float")~=nil) then
            if default then
                -- log_debug("set_default_int:", k, v)
                obslua.obs_data_set_default_double(settings, k, v)
            else
                obslua.obs_data_set_double(settings, k, v)
            end
        -- Integer
        elseif type(v) == 'number' then
            if default then
                -- log_debug("set_default_int:", k, v)
                obslua.obs_data_set_default_int(settings, k, v)
            else
                obslua.obs_data_set_int(settings, k, v)
            end
        -- Boolean
        elseif type(v) == 'boolean' then
            if default then
                -- log_debug("set_default_bool:", k, v)
                obslua.obs_data_set_default_bool(settings, k, v)
            else
                obslua.obs_data_set_bool(settings, k, v)
            end
        -- String
        elseif type(v) == 'string' then
            if default then
                -- log_debug("set_default_bool:", k, v)
                obslua.obs_data_set_default_string(settings, k, v)
            else
                obslua.obs_data_set_string(settings, k, v)
            end
        end
    end
end


-------------------------------------------------------- PRESETS -------------------------------------------------------

-- Types of palettes, used as well as indices of customizable palettes
PALETTE_LIST  = 1
PALETTE_MODEL = 2

--- Set of palette presets
-- Defined as list of colors by a table of RGB 24-bits integers
-- Defined as model by { range of values R, G, B, I, minimums R, G, B, maximums R, G, B}  
PALETTES = {{name="Custom list of colors", list={0x000000, 0x808080, 0xFFFFFF}},
            {name="Custom RGBI model", model={5,5,5,2, 30,30,30, 280,280,280}},
            {name="Amstrad CPC", list={0x000201, 0x00026B, 0x0C02F4, 0x6C0201, 0x690268, 0x6C02F2,
             0xF30506, 0xF00268, 0xF302F4, 0x027801, 0x007868, 0x0C7BF4, 0x6E7B01, 0x6E7D6B, 0x6E7BF6,
             0xF37D0D, 0xF37D6B, 0xFA80F9, 0x02F001, 0x00F36B, 0x0FF3F2, 0x71F504, 0x71F36B, 0x71F3F4,
             0xF3F30D, 0xF3F36D, 0xFFF3F9}},
            {name="Amstrad CPC+", model={16,16,16,1, 0,0,0, 255,255,255}},
            {name="Commodore C64", list={0x000000, 0xf8fcf8, 0x883830, 0x60b4b8, 0x883c90, 0x50a048,
             0x403088, 0xb8cc70, 0x885428, 0x504000, 0xb86860, 0x505050, 0x787878, 0x90e088, 0x7868c0,
             0x989c98}},
            {name="Commodore Amiga", model={16,16,16,1, 0,0,0, 255,255,255}}}


--- Index of preset once something is modified
PRESET_CUSTOM = 1

--- Presets of retro computers
-- Main parameters: palette for palette_index, coloration for coloration_index, colors for inks count
-- Resolution defined as {visible area base width, height, pixel width, height, border width, height}
-- Note: for PAL CPC resolution 768x544 --> (64+640+64)x(72+400+72) 
PRESETS = {{name="Custom", palette=1, coloration=1, colors=4, resolution={320,200, 2,2, 0,0}},
           {name="Amstrad CPC Mode 0", palette=3, coloration=1, colors=16, resolution={640,400, 4,2, 64,72}},
           {name="Amstrad CPC Mode 1", palette=3, coloration=1, colors=4,  resolution={640,400, 2,2, 64,72}},
           {name="Amstrad CPC Mode 2", palette=3, coloration=1, colors=2,  resolution={640,400, 1,2, 64,72}},
           {name="Commodore C64",      palette=5, coloration=1, colors=16, resolution={640,400, 1,1, 64,72}}}

-- Default preset to apply if a source is created and added to a video source, modifiable in script properties
default_preset_index = 3

------------------------------------------------- GLOBAL SCRIPT FUNCTIONS ----------------------------------------------

-- Initial call sequence: script_defaults, script_description, script_load, script_update, script_properties
-- See https://obsproject.com/docs/scripting.html#script-function-exports

-- Called to retrieve the description string and display it in the script management dialog
-- NOTE: not documented
function script_description()
    log_debug("Entering script_description")

    local description = "Pixel Art filter" ..
    "\n\nThis LUA plugin adds a new 'Pixel Art' filter that can be applied on any video source to reduce the " ..
    "pixel resolution and the number of colors and obtain a gorgeous retro-looking picture. " ..
    "It can work with a custom or pre-defined palette and features dithering, downscaling, outlines, etc." ..
    "\n\nAs a main global setting, the default preset can be chosen below. " ..
    "Other settings are available when the filter is added on a source."

    log_debug("Leaving script_description\n")
    return description

end

--- Called to set default settings (if any) associated with the script.
--- You would typically call Default Value Functions on the settings in order to set its default values.
--- A default value will create the related setting if not already existing, then passed to the first `script_load`
--- The parameter `settings` is of type `obs_data_t`, see https://obsproject.com/docs/reference-settings.html
--- @param settings obs_data_t
function script_defaults(settings)
    log_debug("Entering script_defaults")

    -- Set default preset and log level at first addition of the script to OBS (if changed later on,
    -- then the value set by the user will be kept and the set_default commands will have no effect)
    obslua.obs_data_set_default_int(settings, "default_preset_index", default_preset_index)
    obslua.obs_data_set_default_int(settings, "log_level", log_level)

    -- Reads default or stored values as soon as possible
    default_preset_index = obslua.obs_data_get_int(settings, "default_preset_index")
    log_level = obslua.obs_data_get_int(settings, "log_level")

    log_debug("Leaving script_defaults\n")
end

-- Called on script startup with specific settings associated with the script.
function script_load(settings)
    log_debug("Entering script_load")

    -- Logs presets content
    log_debug("Content of PALETTES:", PALETTES)
    log_debug("Content of PRESETS:", PRESETS)
    
    --[[ Logs all members of the "obslua" module
    log_debug("Content of the obslua module:")
    for k,v in pairs(obslua) do
        log_debug(k, ":", as_string(v,1))
    end ]]

    -- Registers the template object source_info, used when adding the filter to a video source
    log_info("Call to obslua.obs_register_source(source_info)")
    obslua.obs_register_source(source_info)

    log_debug("Leaving script_load\n")
end

-- Called when the script’s settings (if any) have been changed by the user.
function script_update(settings)
    log_debug("Entering script_update")

    -- Stores potentially new default main preset as global variable
    default_preset_index = obslua.obs_data_get_int(settings, "default_preset_index")
    log_info("Current default_preset_index: " .. tostring(obslua.obs_data_get_int(settings, "default_preset_index")))

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

    -- List of main presets
    local list = obslua.obs_properties_add_list(properties, "default_preset_index", "Default Preset",
                                                obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
    -- Fills list with values from presets except PRESET_CUSTOM (special value only displayed once some
    -- other setting part of the preset was changed)
    for k,v in ipairs(PRESETS) do
        if k ~= PRESET_CUSTOM then obslua.obs_property_list_add_int(list, v.name, k) end
    end

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

-- Returns an object with members set to key / integer values from the pre-defined palettes, with the same variable
-- names as the settings and properties used in the plugin
function get_palette_parameters(palette_index)

    local res = {}

    -- Retrieves palette info
	local palette = PALETTES[palette_index]
	if palette.list ~= nil then
		-- Palette by list of colors
        res.palette_type = PALETTE_LIST
		res.palette_length = #palette.list
		for i=1,res.palette_length do
			res["palette_color_" .. i] = palette.list[i] + 0xFF000000
		end
	else
		-- Palette by model
        res.palette_type = PALETTE_MODEL
		res.palette_range_red = palette.model[1]
		res.palette_range_green = palette.model[2]
		res.palette_range_blue = palette.model[3]
		res.palette_range_intensity = palette.model[4]
		res.palette_min_red = palette.model[5]
		res.palette_min_green = palette.model[6]
		res.palette_min_blue = palette.model[7]
		res.palette_max_red = palette.model[8]
		res.palette_max_green = palette.model[9]
		res.palette_max_blue = palette.model[10]
    end

    res.test_boolean = true

    log_debug("Result of get_palette_parameters(" .. tostring(palette_index) .. ")", res)

	return res
end

-- Returns an object with members set to key / integer values containing
-- retro computer preset parameters
function get_preset_parameters(preset_index)

    local res = {}

    -- Inserts main preset info
    local preset = PRESETS[preset_index]
    res.palette_index = preset.palette
    res.coloration_index = preset.coloration
    res.display_colors = preset.colors

    -- Inserts resolution parameters
    res.resolution_visible_width = preset.resolution[1]
    res.resolution_visible_height = preset.resolution[2]
    res.resolution_pixel_width = preset.resolution[3]
    res.resolution_pixel_height = preset.resolution[4]
    res.resolution_border_width = preset.resolution[5]
    res.resolution_border_height = preset.resolution[6]

    log_debug("Result of get_preset_parameters(" .. tostring(preset_index) .. ")", res)

	return res
end

-- Sets the default settings for this source
-- Defaults are set to simple settings for custom palettes in case the user selects the palette manually
-- and the default preset is set to a non-customized one  
source_info.get_defaults = function(settings)
    log_debug("Entering source_info.get_defaults")

    -- Fills default settings just in case the user selects manually one of the Custom drop-down
    set_obs_data_settings(settings, get_palette_parameters(PALETTE_MODEL), true)
    set_obs_data_settings(settings, get_palette_parameters(PALETTE_LIST), true)
    set_obs_data_settings(settings, get_preset_parameters(PRESET_CUSTOM), true)

    -- Set default palette model before customization
	--[[parameters = get_palette_parameters(PALETTE_MODEL)
	for k,v in pairs(parameters) do
		obslua.obs_data_set_default_int(settings, k, v)
    end]]

    -- Set default list of colors before customization
	--[[local parameters = get_palette_parameters(PALETTE_LIST)
	for k,v in pairs(parameters) do
		obslua.obs_data_set_default_int(settings, k, v)
    end]]

    -- Set default preset parameters before customization
	--[[local parameters = get_preset_parameters(PRESET_CUSTOM)
	for k,v in pairs(parameters) do
		obslua.obs_data_set_default_int(settings, k, v)
    end]]

    -- Set default preset parameter (not custom as chosen in script properties)
    obslua.obs_data_set_default_int(settings, "preset_index", default_preset_index)

    log_debug("Leaving source_info.get_defaults\n")
end

-- Updates the settings for this source (Optional)
source_info.update = function(data, settings)
    log_debug("Entering source_info.update")

    --local buf = ffi.new("uint8_t[?]", 64*4)
    --local tex = obslua.gs_texture_create(64, 1, obslua.GS_RGBA, 1, buf, 0)

        
	--[[ Makes sure that palette_type reflects the palette selected by the user
	local palette_index = obslua.obs_data_get_int(settings, "palette_index")
	if palette_index == PALETTE_LIST or palette_index == PALETTE_MODEL then
		obslua.obs_data_set_int(settings, "palette_type", palette_index)
    end ]]--
	
	-- Keeps a ref on the settings for later use
	-- data.settings = settings

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

    log_debug("Value of resolution_activated", obslua.obs_data_get_bool(settings, "resolution_activated"))
    log_debug("Value of palette_activated", obslua.obs_data_get_bool(settings, "palette_activated"))

    log_debug("Leaving source_info.update\n")
end

function customize_preset(data)
    log_debug("Entering customize_preset for preset_index ",
              obslua.obs_data_get_int(data.settings, "preset_index"))

    -- Retrieves preset parameters
    local preset_index = obslua.obs_data_get_int(data.settings, "preset_index")
    local parameters = get_preset_parameters(preset_index)
	for k,v in pairs(parameters) do
		obslua.obs_data_set_int(data.settings, k, v)
    end

    -- Sets preset index to custom preset
    obslua.obs_data_set_int(data.settings, "preset_index", PRESET_CUSTOM)

    -- Calls necessary modification callbacks
    obslua.obs_properties_apply_settings(data.props, data.settings)

    log_debug("Leaving customize_preset")
end

function customize_palette(data)
    log_debug("Entering customize_palette for palette_index ",
              obslua.obs_data_get_int(data.settings, "palette_index"))

    -- Retrieves palette parameters and fills settings with values
    local palette_index = obslua.obs_data_get_int(data.settings, "palette_index")
    set_obs_data_settings(data.settings, get_palette_parameters(palette_index), false)
	--[[local parameters = get_palette_parameters(palette_index)
	for k,v in pairs(parameters) do
		obslua.obs_data_set_int(data.settings, k, v)
    end]]

    -- Sets palette index to custom palette type
    obslua.obs_data_set_int(data.settings, "palette_index", obslua.obs_data_get_int(data.settings, "palette_type"))

    -- Calls necessary modification callbacks
    obslua.obs_properties_apply_settings(data.props, data.settings)

    log_debug("Leaving customize_palette")
end



-- Callback to set visible flags of the displayed preset properties to hide unnecessary parameters
function set_preset_properties_visibility(props, property, settings)
    log_debug("Entering set_preset_properties_visibility")

    -- Retrieves main values and determines general visibility
    local preset_index = obslua.obs_data_get_int(settings, "preset_index")
    local show_groups = (preset_index == PRESET_CUSTOM)

    -- Preset parameters
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "preset_customize"), not show_groups)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "resolution_activated"), show_groups)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_activated"), show_groups)
    -- obslua.obs_property_set_visible(obslua.obs_properties_get(props, "coloration_activated"), show_groups)

    log_debug("Leaving set_preset_properties_visibility")
    return true
end






-- Callback to set visible flags of the displayed palette properties to hide unnecessary parameters
function set_palette_properties_visibility(props, property, settings)
    log_debug("Entering set_palette_properties_visibility")

    -- Retrieves main values and determines general visibility
    local palette_activated = obslua.obs_data_get_bool(settings, "palette_activated")
    local palette_index = obslua.obs_data_get_int(settings, "palette_index")
    local palette_length = obslua.obs_data_get_int(settings, "palette_length")
    local by_list = palette_activated and (palette_index == PALETTE_LIST)
    local by_model = palette_activated and (palette_index == PALETTE_MODEL)

    -- Main palette parameters
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_index"), palette_activated)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_customize"), palette_activated)

    -- Palette by list of colors
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_length"), by_list)
    for i=1,MAX_PALETTE_LENGTH do
        obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_color_" .. i),
                                                                  by_list and i<=palette_length)
    end

    -- Palette by model
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_range_red"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_range_green"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_range_blue"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_range_intensity"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_min_red"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_min_green"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_min_blue"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_max_red"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_max_green"), by_model)
    obslua.obs_property_set_visible(obslua.obs_properties_get(props, "palette_max_blue"), by_model)

    log_debug("Leaving set_palette_properties_visibility")
    return true
end


-- Gets the property information of this source (Optional)
source_info.get_properties = function(data)
    log_debug("Entering source_info.get_properties")

    -- Always re-create properties object and keeps a reference for use in callbacks
    local props = obslua.obs_properties_create()
    data.props = props

	-- Main preset
    local p = obslua.obs_properties_add_list(props, "preset_index", "Main preset",
	                                         obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
	for k,v in ipairs(PRESETS) do
        obslua.obs_property_list_add_int(p, v.name, k)
    end
    obslua.obs_property_set_modified_callback(p, set_preset_properties_visibility)
    obslua.obs_properties_add_button(props, "preset_customize", "Copy preset parameters and customize",
                                     function() customize_preset(data) return true end)

    -- Display parameters
    local gprops = obslua.obs_properties_create()
    obslua.obs_properties_add_group(props, "resolution_activated", "Resolution", obslua.OBS_GROUP_CHECKABLE, gprops)
    obslua.obs_properties_add_int(gprops, "resolution_visible_width", "Visible area width", 1, 2000, 1)
    obslua.obs_properties_add_int(gprops, "resolution_visible_height", "Visible area height", 1, 2000, 1)
    obslua.obs_properties_add_int(gprops, "resolution_pixel_width", "Pixel width", 1, 10, 1)
    obslua.obs_properties_add_int(gprops, "resolution_pixel_height", "Pixel height", 1, 10, 1)
    obslua.obs_properties_add_int(gprops, "resolution_border_width", "Border width", 1, 500, 1)
    obslua.obs_properties_add_int(gprops, "resolution_border_height", "Border height", 1, 500, 1)

    -- Palette parameters
    gprops = obslua.obs_properties_create()
    p = obslua.obs_properties_add_group(props, "palette_activated", "Palette", obslua.OBS_GROUP_CHECKABLE, gprops)
    obslua.obs_property_set_modified_callback(p, set_palette_properties_visibility)
    p = obslua.obs_properties_add_list(gprops, "palette_index", "Palette preset",
	                                   obslua.OBS_COMBO_TYPE_LIST, obslua.OBS_COMBO_FORMAT_INT)
	for k,v in ipairs(PALETTES) do
        obslua.obs_property_list_add_int(p, v.name, k)
    end
    obslua.obs_property_set_modified_callback(p, set_palette_properties_visibility)
    obslua.obs_properties_add_button(gprops, "palette_customize", "Copy palette parameters and customize",
                                     function() customize_palette(data) return true end)

    -- Palette by colors list
    p = obslua.obs_properties_add_int(gprops, "palette_length", "Palette length", 2, MAX_PALETTE_LENGTH, 1)
    obslua.obs_property_set_modified_callback(p, set_palette_properties_visibility)
    for i=1,MAX_PALETTE_LENGTH do
        obslua.obs_properties_add_color(gprops, "palette_color_" .. i, "Palette color " .. i)
    end

	-- Palette by model
    obslua.obs_properties_add_int(gprops, "palette_range_red", "Palette levels range Red", 1, 256, 1)
    obslua.obs_properties_add_int(gprops, "palette_range_green", "Palette levels range Green", 1, 256, 1)
    obslua.obs_properties_add_int(gprops, "palette_range_blue", "Palette levels range Blue", 1, 256, 1)
    obslua.obs_properties_add_int(gprops, "palette_range_intensity", "Palette levels range Intensity", 1, 256, 1)
    obslua.obs_properties_add_int(gprops, "palette_min_red", "Palette minimum Red", 0, 255, 1)
    obslua.obs_properties_add_int(gprops, "palette_min_green", "Palette minimum Green", 0, 255, 1)
    obslua.obs_properties_add_int(gprops, "palette_min_blue", "Palette minimum Blue", 0, 255, 1)
    obslua.obs_properties_add_int(gprops, "palette_max_red", "Palette maximum Red", 0, 255, 1)
    obslua.obs_properties_add_int(gprops, "palette_max_green", "Palette maximum Green", 0, 255, 1)
    obslua.obs_properties_add_int(gprops, "palette_max_blue", "Palette maximum Blue", 0, 255, 1)

    -- obslua.obs_properties_add_path(props, "palette_image_path", "Read palette from file",
    --                                obslua.OBS_PATH_FILE, "Bitmap picture (*.jpg *.png)", nil)

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
    data = {}

    -- Defalut resolution values (potentially used before rendering, just in case)
    data.width = 320
    data.height = 200

    -- The source object instance of the filter itself
    data.source = source

    -- Saves the settings for later use
    data.settings = settings

    -- Compiles shader
    obslua.obs_enter_graphics()
    local effect_file_path = script_path() .. 'filter-pixel-art.effect.hlsl'
    log_debug("effect_file_path:", effect_file_path)
    data.effect = obslua.gs_effect_create_from_file(effect_file_path, nil)
    if data.effect == nil then
        log_warning("Effect file not compiled - Reverting to luminance effect")
        data.effect = obslua.gs_effect_create(EFFECT_LUMINANCE, "luminance", nil)
    end
    obslua.obs_leave_graphics()

    -- Destroys everything if shader was not compiled properly
    if data.effect == nil then
        log_error("HLSL code not compiled")
        source_info.destroy(data)
        return nil
    end

    -- Calls update to initialize the rest of the properties-managed settings
    source_info.update(data, settings)

    log_debug("Leaving source_info.create\n")
    return data
end

-- Destroys the implementation data for the source
source_info.destroy = function(data)
    log_debug("Entering source_info.destroy")

    if data.effect ~= nil then
        obslua.obs_enter_graphics()
        obslua.gs_effect_destroy(data.effect)
        obslua.obs_leave_graphics()
    end

    log_debug("Leaving source_info.destroy\n")
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



--- Returns data URL of BMP RGBA picture, see https://docs.microsoft.com/en-us/windows/win32/gdi/bitmap-storage
-- See also https://en.wikipedia.org/wiki/BMP_file_format#Example_2
function encode_bitmap(width, height, data)

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
    local f = assert(io.open(script_path() .. 'test-generated-bitmap.bmp', "wb"))
    f:write(bmp)
    f:close()

    -- Function to convert to base64 from http://lua-users.org/wiki/BaseSixtyFour
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

    return "data:image/bmp;base64," .. encode_base64(bmp)
end

function hex_dump(buf)
    local res = ""
    for i = 1,string.len(buf) do
        res = res .. string.format( "%02x ", string.byte(buf, i))
    end
    return res
end

print("Building table")
local w=1000
local h=1000
local t = {}
for i=0,(w*h-1) do table.insert(t, 0xFF000000 + i) end

print("Building LUT")
local url = encode_bitmap(w,h,t)
print("Finished LUT")

--local bmp = encode_bitmap(3,2,{0xFF0000FF, 0xFFFFFFFF, 0xFFFF0000, 0x7F0000FF, 0x7FFFFFFF, 0x7FFF0000})
print("------------- TEST encode --->" .. url .. "<-------")

obslua.obs_enter_graphics()

local image = obslua.gs_image_file()
obslua.gs_image_file_init(image, url)
obslua.gs_image_file_init_texture(image)
local tex = image.tex
tex = obslua.gs_texture_create_from_file(url)
if tex ~= nil then
    print("Texture created width=" .. tostring(obslua.gs_texture_get_width(tex)) .. " height=" .. tostring(obslua.gs_texture_get_height(tex)))
    obslua.gs_texture_destroy(tex)
else
    print("ERROR: texture not created--------------------")
end
obslua.gs_image_file_free(image)

obslua.obs_leave_graphics()

