-- Convention
obs = obslua

-- Returns the description to be displayed in the Scripts window
function script_description()

  local alien="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAVCAYAAACkCdXRAAAAAXNSR0IArs4c6QAAAARnQU1BAACxj"..
  "wv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAADwSURBVDhPtZQxDsIwDEUDYoSBHWhHbsPC2tOxsnAbxhbYGWBEAn0rBid20lDBk1BS17z+hBT3"..
  "S0Z+TFItq6efuu7cZfuTN1ky26/d9XCh2mR3pzElNYsQQSJhIYDUEqqCJWL6hGM/EjlRzKOZBvsJ3uZSkUwHZMIgWQnzzcLPNGTkVLftkYqMlTT"..
  "uwXI5nUrWnlr6gPiLfC17JOYy61XtZx+BFMv7EiXjRuvJsmYJSYb14slyj6zmuCb3C9cq2TfnLCY4wSVnLfcWmD/AUIJkIJeu791UMmAJB/1rMB"..
  "BihJRFkABLBJIyhqUgJfkDzr0Amw2KoGT2/LMAAAAASUVORK5CYII="

  local description = [[<center><h2>CPC</h2></center><center><img width=38 height=42 src=']] .. alien .. [['/><br/>
  <a href="https://github.com/bfxdev/OBS">bfxdev</a> - 2023</center>
  <p>This Lua script adds a new filter named "BFX CPC" that reproduces the display of the Amstrad CPC, an 8-bits
  personal home computer of the 80s.</p>]]

  return description
end

-- Called on script startup
function script_load(settings)
  obs.obs_register_source(source_info)
end

-- Definition of the global variable containing the source_info structure
source_info = {}
source_info.id = 'filter-bfx-cpc'               -- Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
source_info.get_name = function()
  return "BFX CPC"
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
  local effect_file_path = script_path() .. 'filter-bfx-cpc.effect.hlsl'
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

  data.params.DisplayCPCMode = obs.gs_effect_get_param_by_name(data.effect, "DisplayCPCMode")
  data.params.DisplayDownscale = obs.gs_effect_get_param_by_name(data.effect, "DisplayDownscale")
  data.params.DisplayGammaCorrection = obs.gs_effect_get_param_by_name(data.effect,
                                                                       "DisplayGammaCorrection")
  data.params.DisplayGrayscale = obs.gs_effect_get_param_by_name(data.effect, "DisplayGrayscale")
  data.params.DitheringSpread = obs.gs_effect_get_param_by_name(data.effect, "DitheringSpread")
  data.params.DitheringMatrix = obs.gs_effect_get_param_by_name(data.effect, "DitheringMatrix")
  data.params.OutlineEdge = obs.gs_effect_get_param_by_name(data.effect, "OutlineEdge")
  data.params.OutlineEdgeColor = obs.gs_effect_get_param_by_name(data.effect, "OutlineEdgeColor")
  data.params.PaletteAdaptedColors = obs.gs_effect_get_param_by_name(data.effect, "PaletteAdaptedColors")
  data.params.PaletteInks = obs.gs_effect_get_param_by_name(data.effect, "PaletteInks")

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

  obs.gs_effect_set_int(data.params.DisplayCPCMode, data.DisplayCPCMode)
  obs.gs_effect_set_float(data.params.DisplayDownscale, data.DisplayDownscale)
  obs.gs_effect_set_float(data.params.DisplayGammaCorrection, data.DisplayGammaCorrection)
  obs.gs_effect_set_bool(data.params.DisplayGrayscale, data.DisplayGrayscale)
  obs.gs_effect_set_float(data.params.DitheringSpread, data.DitheringSpread)
  obs.gs_effect_set_int(data.params.DitheringMatrix, data.DitheringMatrix)
  obs.gs_effect_set_float(data.params.OutlineEdge, data.OutlineEdge)
  obs.gs_effect_set_color(data.params.OutlineEdgeColor, data.OutlineEdgeColor)
  obs.gs_effect_set_int(data.params.PaletteAdaptedColors, data.PaletteAdaptedColors)

  local palette = obs.matrix4()
  local inks = data.PaletteInks
  local component = obs.vec4()
  obs.vec4_set(component, inks[0],  inks[1],  inks[2],  inks[3])
  obs.vec4_copy(palette.x, component)
  obs.vec4_set(component, inks[4],  inks[5],  inks[6],  inks[7])
  obs.vec4_copy(palette.y, component)
  obs.vec4_set(component, inks[8],  inks[9],  inks[10], inks[11])
  obs.vec4_copy(palette.z, component)
  obs.vec4_set(component, inks[12], inks[13], inks[14], inks[15])
  obs.vec4_copy(palette.t, component)
  obs.gs_effect_set_matrix4(data.params.PaletteInks, palette)

  obs.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end

-- Sets the default settings for this source
source_info.get_defaults = function(settings)

  obs.obs_data_set_default_int(settings, "DisplayCPCMode", 1)
  obs.obs_data_set_default_double(settings, "DisplayDownscale", 1.0)
  obs.obs_data_set_default_double(settings, "DisplayGammaCorrection", 0.0)
  obs.obs_data_set_default_bool(settings, "DisplayGrayscale", false)
  obs.obs_data_set_default_double(settings, "DitheringSpread", 0.15)
  obs.obs_data_set_default_int(settings, "DitheringMatrix", 3)
  obs.obs_data_set_default_double(settings, "OutlineEdge", 0.5)
  obs.obs_data_set_default_int(settings, "OutlineEdgeColor", 0xff000000)
  obs.obs_data_set_default_int(settings, "PaletteAdaptedColors", 1)

  local default_palette = {0, 26, 15, 2, 1, 6, 3, 18, 9, 25, 0, 0, 0, 0, 0, 0}
  for i=1,16 do
    obs.obs_data_set_default_int(settings, "PaletteInk" .. (i-1), default_palette[i])
  end

end

-- Callback to set the visibility of properties (and colors)
function set_visibility(props, property, settings)

  local colors = {"#000000", "#000080", "#0000FF", "#800000", "#800080", "#8000FF", "#FF0000",
                  "#FF0080", "#FF00FF", "#008000", "#008080", "#0080FF", "#808000", "#808080",
                  "#8080FF", "#FF8000", "#FF8080", "#FF80FF", "#00FF00", "#00FF80", "#00FFFF",
                  "#80FF00", "#80FF80", "#80FFFF", "#FFFF00", "#FFFF80", "#FFFFFF"}
  local mode = obs.obs_data_get_int(settings, "DisplayCPCMode")

  for i=0,15 do
    local prop = obs.obs_properties_get(props, "PaletteInk" .. i)
    local ink = obs.obs_data_get_int(settings, "PaletteInk" .. i)
    local color_block = "<span style='background-color:" .. colors[ink+1] .. "'>&nbsp;&nbsp;</span>"
    obs.obs_property_set_description(prop, "Ink " .. i .. "&nbsp;" .. color_block)

    local visibility = (mode==0) or (mode==1 and i<4) or (mode==2 and i<2)
    obs.obs_property_set_visible(prop, visibility)
  end

  return true
end


-- Gets the property information of this source
source_info.get_properties = function(data)
  local props = obs.obs_properties_create()

  local lprop = obs.obs_properties_add_list(props, "DisplayCPCMode", "CPC Video Mode",
                                      obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
  obs.obs_property_list_add_int(lprop, "Mode 0: 160x200 with 16 colors out of 27", 0)
  obs.obs_property_list_add_int(lprop, "Mode 1: 320x200 with 4 colors out of 27", 1)
  obs.obs_property_list_add_int(lprop, "Mode 2: 640x200 with 2 colors out of 27", 2)
  obs.obs_property_list_add_int(lprop, "Mode 3: 640x400 with 27 colors (not available on CPC)", 3)
  obs.obs_property_set_modified_callback(lprop, set_visibility)

  obs.obs_properties_add_float_slider(props, "DisplayDownscale", "Pixel size (0 for CPC resolution)",
                                      0.0, 8.0, 1.0)
  obs.obs_properties_add_float_slider(props, "DisplayGammaCorrection", "Gamma correction",
                                      -0.8, 0.8, 0.01)
  obs.obs_properties_add_bool(props, "DisplayGrayscale", "Grayscale conversion of the source")
  obs.obs_properties_add_float_slider(props, "DitheringSpread", "Dithering Spread", 0.0, 1.0, 0.01)

  local lprop2 = obs.obs_properties_add_list(props, "DitheringMatrix", "Dithering Pattern",
                                             obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
  obs.obs_property_list_add_int(lprop2, "1: 2x2 Bayer", 1)
  obs.obs_property_list_add_int(lprop2, "2: 4x4 Bayer", 2)
  obs.obs_property_list_add_int(lprop2, "3: 8x8 Bayer", 3)
  obs.obs_property_list_add_int(lprop2, "4: 3x3 Dot", 4)
  obs.obs_property_list_add_int(lprop2, "5: 3x3 Dot with RGB offsets", 5)
  obs.obs_property_list_add_int(lprop2, "6: 4: 5x5 Dot", 6)
  obs.obs_property_list_add_int(lprop2, "7: 5x5 Dot with RGB offsets", 7)
  obs.obs_property_list_add_int(lprop2, "8: 6x6 Dot", 8)
  obs.obs_property_list_add_int(lprop2, "9: 6x6 Dot with RGB offsets", 9)

  obs.obs_properties_add_float_slider(props, "OutlineEdge", "Outline Edge Level", 0.0, 4.0, 0.01)
  obs.obs_properties_add_color(props, "OutlineEdgeColor", "Outline Color")


  local lprop3 = obs.obs_properties_add_list(props, "PaletteAdaptedColors", "Palette",
                                             obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
  obs.obs_property_list_add_int(lprop3, "1: Gate Array", 1)
  obs.obs_property_list_add_int(lprop3, "2: ASIC", 2)
  obs.obs_property_list_add_int(lprop3, "3: Perfect no gray", 3)

  local palette = {"Black", "Blue", "Bright Blue", "Red", "Magenta", "Mauve", "Bright Red",
                   "Purple", "Bright Magenta", "Green", "Cyan", "Sky Blue", "Yellow", "White",
                   "Pastel Blue", "Orange", "Pink", "Pastel Magenta", "Bright Green",
                   "Sea Green", "Bright Cyan", "Lime", "Pastel Green", "Pastel Cyan",
                   "Bright Yellow", "Pastel Yellow", "Bright White"}
  for i=0,15 do
    lprop = obs.obs_properties_add_list(props, "PaletteInk" .. i, "Ink " .. i,
                                        obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
    for c=1,27 do
      obs.obs_property_list_add_int(lprop, (c-1) .. ": " .. palette[c], c-1)
    end
    obs.obs_property_set_modified_callback(lprop, set_visibility)

  end

  return props
end

-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)

  data.DisplayCPCMode = obs.obs_data_get_int(settings, "DisplayCPCMode")
  data.DisplayDownscale = obs.obs_data_get_double(settings, "DisplayDownscale")
  data.DisplayGammaCorrection = obs.obs_data_get_double(settings, "DisplayGammaCorrection")
  data.DisplayGrayscale = obs.obs_data_get_bool(settings, "DisplayGrayscale")
  data.DitheringSpread = obs.obs_data_get_double(settings, "DitheringSpread")
  data.DitheringMatrix = obs.obs_data_get_int(settings, "DitheringMatrix")
  data.OutlineEdge = obs.obs_data_get_double(settings, "OutlineEdge")
  local c = obs.obs_data_get_int(settings, "OutlineEdgeColor")
  data.OutlineEdgeColor = (c%256)*65536 + (math.floor(c/256)%256)*256 + (math.floor(c/65536)%256)
  data.OutlineEdgeColor = data.OutlineEdgeColor + 0xff000000
  data.PaletteAdaptedColors = obs.obs_data_get_int(settings, "PaletteAdaptedColors")

  data.PaletteInks = {}
  for i=0,15 do
    data.PaletteInks[i] = obs.obs_data_get_int(settings, "PaletteInk" .. i)
  end

end

