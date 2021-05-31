-------------------=-------------------=-------------------=-------------------=-------------------=--------------------
--                                                                                                                    --
--                                               Pixel Art Filter for OBS                                             --
--                                                   bfxdev - 2021                                                    --
--                                                                                                                    --
-- The main purpose of this video filter script is to produce a picture with various constraints on the resolution    --
--  and the color palette in order to mimic the style of computer picture of the 8/16-bits era or Pixel Art.          --
-- Another aim of this plugin is to showcase what can be done using the Lua framework of OBS, with an explicit intent --
--  to hide the underlying complexity and make the settings easily understandable for the user.                       --
--                                                                                                                    --
-- The video processing chain comprises different steps with their own sets of parameters:                            --
--                                                                                                                    --
-- Pixelation                                                                                                      --
-- See https://sites.google.com/site/tiffanycinglis/research/pixelating-vector-line-art
-- See http://people.inf.ethz.ch/~cengizo/Files/Sig15PerceptualDownscaling.pdf or                          --
-- See https://johanneskopf.de/publications/downscaling/paper/downscaling.pdf                              --


--  Edge detection: used internally and for the outline
--  Blur: used internally
--  Palette detection: definition of overall set of colors allowed in the output pictures                             --


--  Color quantization
-- See http://datahacker.rs/007-color-quantization-using-k-means-clustering/
-- See http://web.cs.wpi.edu/~matt/courses/cs563/talks/color_quant/CQindex.html

--  Coloration: reduction to a fixed number of colors in the output picture                         --
--  Dithering: use of mix of dots of several colors to render different shades                      --
--  Outline: line drawn drawn on top of the final picture, following detected edges                 --
--  Upscale

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

--              - Single-pixel outline based on Sobel filters or pixel-level rules, then optimized according to        --
--                https://sites.google.com/site/tiffanycinglis/research/pixelating-vector-line-art                    --

--                                                                                                                    --
------------------------------------------------------------------------------------------------------------------------

-- TODO: Re-define log functions to use blog, define is_log_debug() etc functions
-- TODO: Add global script parameters:
--        - Log level
--        - Default usage mode: Basic, Advanced, Expert
--        - Default global preset
-- TODO: Add source info parameters in non-checkable "Global" group:
--        - Usage mode
--        - Global preset
--        - Preview pictures on/off
--        - Show detailed presets on/off

-------------------------------------------------------- GLOBALS -------------------------------------------------------

-- Renamed import by convention
obs = obslua

-- Additional asserts if set to true
DEBUG = true

--- Maximum recursion level for `as_string` function
MAX_PARSE_DEPTH = 10
--- Recursive transformation of any object to string (with max depth)
function as_string(content, depth)

  local res
  if not depth then depth = 0 end

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

  -- Type string
  elseif type(content) == "string" then
    res =  tostring(content)
    if depth > 0 then
      res = "\"" .. res .. "\""
    end

  else
    res =  tostring(content)
  end

  return res
end

-------------------------------------------------- GLOBAL LOG FUNCTIONS ------------------------------------------------

--- List of log levels used for display and property selection (e.g. obslua.LOG_DEBUG = 400)
LOG_LEVELS = {ERROR=obs.LOG_ERROR,     [obs.LOG_ERROR]    = "ERROR",
              WARNING=obs.LOG_WARNING, [obs.LOG_WARNING]  = "WARN",
              INFO=obs.LOG_INFO,       [obs.LOG_INFO]     = "INFO",
              DEBUG=obs.LOG_DEBUG,     [obs.LOG_DEBUG]    = "DEBUG"}

--- Global log level
log_level = LOG_LEVELS.DEBUG

--- Main log function (do not use directly) with parameter `level` to track if we are at level 0 (no quotes on string)
--- and avoid infinite recursions, multiple arguments `...` displayed with spaces between them (python-like)
function log(level, ...)
  if level <= log_level then
    local str = LOG_LEVELS[level] .. ":"
    for k,v in pairs({...}) do
      str = str .. " " .. as_string(v, 0)
    end
    print(str)
  end
end

--- Logs at error level
function is_log_error() return log_level <= LOG_LEVELS.ERROR end
function log_error(...)   log(LOG_LEVELS.ERROR, ...) end
--- Logs at warning level
function is_log_warning() return log_level <= LOG_LEVELS.WARNING end
function log_warning(...) log(LOG_LEVELS.WARNING, ...) end
--- Logs at info level
function is_log_info() return log_level <= LOG_LEVELS.INFO end
function log_info(...)    log(LOG_LEVELS.INFO, ...) end
--- Logs at debug level
function is_log_debug() return log_level <= LOG_LEVELS.DEBUG end
function log_debug(...)   log(LOG_LEVELS.DEBUG, ...) end

------------------------------------------------- PROPERTY HELPER CLASS ------------------------------------------------

PROPERTY_TYPES = {UNDEFINED = 0, INT = 1, FLOAT = 2, BOOL = 3, STRING = 4, VEC2 = 5,
                  TEXTURE = 10, PRESET = 20}

--- @class Property
Property = {type = PROPERTY_TYPES.UNDEFINED, name = "UNDEFINED NAME", description = "UNDEFINED DESCRIPTION",
            default = "UNDEFINED DEFAULT", min = -1, max = -1, step = -1, is_slider = false, is_multiline = false,
            list = {{"UNDEFINED", "UNDEFINED"}} }

-- TODO: Copy input object template if nothing is given as argument

--- Property constructor - Do not use directly
--- It will either create a new object initialized with the default settings of Property, or re-use the passed
---  object and check that the members are part of the original Property table
--- @param o Property Optional source object
--- @return Property
function Property:new(o)
  -- Checks basic validity of input object
  if o and DEBUG then
    for k,v in pairs(o) do
      assert(Property[k] ~= nil, "Unknown member " .. k)
      assert(v ~= nil, "Passed nil value for member " .. k)
    end
  elseif o == nil then
    o = {}
  end
  setmetatable(o, self)
  self.__index = self
  self.__tostring = as_string
  return o
end

--- Returns a new Property object initialized as INT
--- @param name        string  Name of the property in the data settings
--- @param description string  Description to be displayed on properties dialog
--- @param default     integer Default value (default 0)
--- @param min         integer Minimum value (default -100)
--- @param max         integer Maximum value (default 100)
--- @param step        integer Increment (default 1)
--- @param is_slider   boolean Property displayed as slider (default true)
function Property:new_int(name, description, default, min, max, step, is_slider)
  if is_slider==nil then is_slider=true end
  return Property:new{type=PROPERTY_TYPES.INT, name=name, description=description, default=default or 0,
                      min=min or -100, max=max or 100, step=step or 1, is_slider=is_slider}
end

--- Returns a new Property object initialized as LIST of INT
--- @param name        string  Name of the property in the data settings
--- @param description string  Description to be displayed on properties dialog
--- @param default     integer Default value (default 0)
--- @param list        table   Table of ordered {DESCRIPTION,VALUE} entries or indexed list of DESCRIPTION strings
--- @param is_indexed  boolean If true the passed list is considered as a simple table with ordered integer indices
function Property:new_int_list(name, description, default, list, is_indexed)
  if is_indexed then
    local indices = {}
    for k,_ in pairs(list) do
      if type(k)=="number" then table.insert(indices, k) end
    end
    local new_list = {}
    table.sort(indices)
    for _,i in ipairs(indices) do table.insert(new_list, {list[i], i}) end
    list = new_list
  end
  return Property:new{type=PROPERTY_TYPES.INT, name=name, description=description, default=default or 0,
                      list=list or {{"DEFAULT", default or 0}} }
end

--- Returns a new Property object initialized as FLOAT
--- @param name        string  Name of the property in the data settings
--- @param description string  Description to be displayed on properties dialog
--- @param default     number  Default value (default 0.0)
--- @param min         number  Minimum value (default -1.0)
--- @param max         number  Maximum value (default 1.0)
--- @param step        number  Increment (default 0.01)
--- @param is_slider   boolean Property displayed as slider (default true)
function Property:new_float(name, description, default, min, max, step, is_slider)
  if is_slider==nil then is_slider=true end
  return Property:new{type=PROPERTY_TYPES.FLOAT, name=name, description=description, default=default or 0,
                      min=min or -1, max=max or 1, step=step or 0.01, is_slider=is_slider}
end

--- Returns a new Property object initialized as BOOL
--- @param name        string  Name of the property in the data settings
--- @param description string  Description to be displayed on properties dialog
--- @param default     boolean Default value (default false)
function Property:new_bool(name, description, default)
  return Property:new{type=PROPERTY_TYPES.BOOL, name=name, description=description, default=default or false}
end

--- Returns a new Property object initialized as STRING
--- @param name         string  Name of the property in the data settings
--- @param description  string  Description to be displayed on properties dialog
--- @param default      string  Default value
--- @param is_multiline boolean True if the string can contain new lines
function Property:new_string(name, description, default, is_multiline)
  return Property:new{type=PROPERTY_TYPES.STRING, name=name, description=description, default=default,
                      is_multiline=is_multiline}
end

--- Returns a new Property object initialized as VEC2
--- @param name        string        Name of the property in the data settings
--- @param description table|string  Description to be displayed on properties dialog
--- @param default     table|number  Default value (default {0,0})
--- @param min         table|number  Minimum value (default {-100,-100})
--- @param max         table|number  Maximum value (default {100,100})
--- @param step        table|number  Increment (default {1,1})
--- @param is_slider   boolean       Property displayed as sliders (default true)
function Property:new_vec2(name, description, default, min, max, step, is_slider)
  if is_slider==nil then is_slider=true end
  if type(description)=="string" then description = {description, description} end
  if type(default)=="number" then default = {default, default} end
  if type(min)=="number" then min = {min, min} end
  if type(max)=="number" then max = {max, max} end
  if type(step)=="number" then step = {step, step} end
  return Property:new{type=PROPERTY_TYPES.VEC2, name=name, description=description, default=default or {0,0},
                      min=min or {-100,-100}, max=max or {100,100}, step=step or {1,1}, is_slider=is_slider}
end

--- Sets the default value of the property in OBS data settings
--- @param settings any Data settings object of type obs_data_t
function Property:write_default_values(settings)
  log_debug("Writing default values for", self.name)
  if     self.type == PROPERTY_TYPES.INT then
    obs.obs_data_set_default_int(settings, self.name, self.default)
  elseif self.type == PROPERTY_TYPES.FLOAT then
    obs.obs_data_set_default_double(settings, self.name, self.default)
  elseif self.type == PROPERTY_TYPES.BOOL then
    obs.obs_data_set_default_bool(settings, self.name, self.default)
  elseif self.type == PROPERTY_TYPES.STRING then
    obs.obs_data_set_default_string(settings, self.name, self.default)
  elseif self.type == PROPERTY_TYPES.VEC2 then
    obs.obs_data_set_default_double(settings, self.name .. "_1", self.default[1])
    obs.obs_data_set_default_double(settings, self.name .. "_2", self.default[2])
  end
end

--- Retrieves the effect parameters internally
--- @param effect any Compiled effect
function Property:read_effect_parameters(effect)
  log_debug("Reading effect parameters for", self.name)
  self.param = obs.gs_effect_get_param_by_name(effect, self.name)
  assert(self.param, "Effect parameter " .. self.name .. " not found")
end

--- Retrieves the values of the data settings internally
--- @param settings any Data settings object of type obs_data_t
function Property:read_current_values(settings)
  log_debug("Reading current values for", self.name)
  if     self.type == PROPERTY_TYPES.INT then
    self.value = obs.obs_data_get_int(settings, self.name)
  elseif self.type == PROPERTY_TYPES.FLOAT then
    self.value = obs.obs_data_get_double(settings, self.name)
  elseif self.type == PROPERTY_TYPES.BOOL then
    self.value = obs.obs_data_get_bool(settings, self.name)
  elseif self.type == PROPERTY_TYPES.STRING then
    self.value = obs.obs_data_get_string(settings, self.name)
  elseif self.type == PROPERTY_TYPES.VEC2 then
    local val1 = obs.obs_data_set_double(settings, self.name .. "_1")
    local val2 = obs.obs_data_set_double(settings, self.name .. "_2")
    self.value = obs.vec2()
    obs.vec2_set(self.value, val1, val2)
  end
end

--- Builds graphical user interface in OBS structure of type obs_properties_t
--- @param obs_properties any List of OBS properties to create GUI in
--- @return any obs_property  Created OBS structure of type obs_property_t
function Property:build_user_interface(obs_properties)
  log_debug("Building user interface for", self.name)

  local obs_property = nil

  if self.type == PROPERTY_TYPES.INT and self.list and #self.list > 0 then -- TODO other types
    obs_property = obs.obs_properties_add_list(obs_properties, self.name, self.description,
                                               obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
    for _,entry in pairs(self.list) do
      obs.obs_property_list_add_int(obs_property, entry[1], entry[2])
    end
  elseif self.type == PROPERTY_TYPES.INT and self.is_slider then
    obs_property = obs.obs_properties_add_int_slider(obs_properties, self.name, self.description,
                                                     self.min, self.max, self.step)
  elseif self.type == PROPERTY_TYPES.INT then
    obs_property = obs.obs_properties_add_int(obs_properties, self.name, self.description,
                                              self.min, self.max, self.step)
  elseif self.type == PROPERTY_TYPES.FLOAT and self.is_slider then
    obs_property = obs.obs_properties_add_float_slider(obs_properties, self.name, self.description,
                                                       self.min, self.max, self.step)
  elseif self.type == PROPERTY_TYPES.FLOAT then
    obs_property = obs.obs_properties_add_float(obs_properties, self.name, self.description,
                                                self.min, self.max, self.step)
  elseif self.type == PROPERTY_TYPES.BOOL then
    obs_property = obs.obs_properties_add_bool(obs_properties, self.name, self.description)
  elseif self.type == PROPERTY_TYPES.STRING then
    obs_property = obs.obs_properties_add_text(obs_properties, self.name, self.description,
                                               self.is_multiline and obs.OBS_TEXT_MULTILINE or obs.OBS_TEXT_DEFAULT)
  elseif self.type == PROPERTY_TYPES.VEC2 and self.is_slider then
    obs_property = obs.obs_properties_add_float_slider(obs_properties, self.name .. "_1", self.description[1],
                                                       self.min[1], self.max[1], self.step[1])
    obs_property = obs.obs_properties_add_float_slider(obs_properties, self.name .. "_2", self.description[2],
                                                       self.min[2], self.max[2], self.step[2])
  elseif self.type == PROPERTY_TYPES.VEC2 then
    obs_property = obs.obs_properties_add_float(obs_properties, self.name .. "_1", self.description[1],
                                                self.min[1], self.max[1], self.step[1])
    obs_property = obs.obs_properties_add_float(obs_properties, self.name .. "_2", self.description[2],
                                                self.min[2], self.max[2], self.step[2])
  end

  return obs_property
end

--- Returns the base name (may not match the name in data settings for non-base types)
--- @return string name
function Property:get_name()
  return self.name
end

--- Returns the current value (to be called after read_current_values)
--- @return any value
function Property:get_value()
  return self.value
end


--[[
local prop

prop = Property:new_int("new name", "new description", 12, -10, 10, 2, false)
print("\n\nDefinition new_int:")
for k,_ in pairs(prop) do
  print("prop." .. k .. ": " .. tostring(prop[k]))
end

prop = Property:new_int_list("new name", "new description")
print("\n\nDefinition new_int_list:")
for k,_ in pairs(prop) do
  print("prop." .. k .. ": " .. tostring(prop[k]))
end

prop = Property:new_int2("new name", "new description")
print("\n\nDefinition new_int2:")
for k,_ in pairs(prop) do
  print("prop." .. k .. ": " .. tostring(prop[k]))
end

print("tostring(prop): " .. tostring(prop))
]]

---------------------------------------------- PROPERTY LIST HELPER CLASS ----------------------------------------------

--- @class PropertyList
PropertyList = {properties={}, index={}}

-- TODO: Copy input object template if nothing is given as argument

--- PropertyList constructor
function PropertyList:new(o)
  if o and DEBUG then
    for k,v in pairs(o) do
      assert(PropertyList[k] ~= nil, "Unknown member " .. k)
      assert(v ~= nil, "Passed nil value for member " .. k)
    end
  elseif o == nil then
    o = {}
  end
  setmetatable(o, self)
  self.__index = self
  self.__tostring = as_string
  o.properties = {}
  o.index = {}
  o.groups = {}
  return o
end

--- Adds a property to the list
--- @param property Property Property to add
function PropertyList:add(property)
  -- log_debug("Adding property", property)
  table.insert(self.properties, property)
  self.index[property:get_name()] = property
end

--- Sets the default values of the properties in OBS data settings
--- @param settings any Data settings object of type obs_data_t
function PropertyList:write_default_values(settings)
  for _,property in ipairs(self.properties) do
    property:write_default_values(settings)
  end
end

--- Retrieves the effect params internally
--- @param effect any Compiled effect
function PropertyList:read_effect_parameters(effect)
  for _,property in ipairs(self.properties) do
    property:read_effect_parameters(effect)
  end
end

--- Retrieves the values of the data settings internally
--- @param settings any Data settings object of type obs_data_t
function PropertyList:read_current_values(settings)
  for _,property in ipairs(self.properties) do
    property:read_current_values(settings)
  end
end

--- Builds graphical user interface in OBS structure of type obs_properties_t
--- @param obs_properties any  Optional list of OBS properties (created if not given)
--- @return any obs_properties OBS structure of type obs_properties_t
function PropertyList:build_user_interface(obs_properties)

  obs_properties = obs_properties or obs.obs_properties_create()

  for _,property in ipairs(self.properties) do
    local obs_property = property:build_user_interface(obs_properties)
    -- TODO visibility
  end

  return obs_properties
end

--- Returns the value of the property with given name (to be called after read_current_values)
--- @return any value
function PropertyList:get_value(name)
  if self.index[name] then
    return self.index[name]:get_value()
  else
    return nil
  end
end




------------------------------------------------ PROPERTIES DEFINITION -------------------------------------------------

USAGE_MODES =           {BASIC=1,       [1]="Basic",
                         ADVANCED=2,    [2]="Advanced",
                         EXPERT=3,      [3]="Expert"}

PIXELATION_ALGORITHMS = {SUBSAMPLING=1, [1]="Sub-sampling", -- No interpolation, one pixel color used per block
                         BILINEAR=2,    [2]="Bilinear",     -- Bilinear interpolation
                         BICUBIC=3,     [3]="Bicubic",      -- Bicubic interpolation
                         LANCZOS=4,     [4]="Lanczos"}      -- Lanczos interpolation

PIXELATION_TYPES =      {BLOCK=1,       [1]="Pixel blocks", -- Downscale defined as blocks of pixels
                         RESOLUTION=2,  [2]="Resolution"}   -- Downscale to target resolution

function build_script_property_list()
  local list = PropertyList:new()

  list:add(Property:new_int_list("default_usage_mode", "Default usage mode", USAGE_MODES.BASIC, USAGE_MODES, true))
  list:add(Property:new_int_list("log_level", "Log level", LOG_LEVELS.INFO, LOG_LEVELS, true))

  log_debug("Returned by build_script_property_list:", tostring(list))
  return list
end

--- Returns the set of persistent properties as a PropertyList
function build_source_property_list()
  local list = PropertyList:new()

  --local p = obs.obs_properties_add_group(props, "pixelation", "Pixelation", obs.OBS_GROUP_CHECKABLE, gprops)
  --obs.obs_property_set_modified_callback(p, set_properties_visibility)
  -- Pixelation group

  -- Pixelation interpolation algorithm
  list:add(Property:new_int_list("pixelation_algorithm", "Interpolation algorithm", PIXELATION_ALGORITHMS.SUBSAMPLING,
           PIXELATION_ALGORITHMS, true))

  -- Pixelation type
  list:add(Property:new_int_list("pixelation_type", "Pixelation type", PIXELATION_TYPES.BLOCK,
           PIXELATION_TYPES, true))
  list:add(Property:new_vec2("pixelation_block_size", {"Pixel blocks width","Pixel blocks height"}, 2, 1, 20, 1, true))
  list:add(Property:new_vec2("pixelation_resolution", {"Resolution width","Resolution height"},
                             {320,200}, 1, 1000, 1, false))

  log_debug("Returned by build_source_property_list:", tostring(list))
  return list
end


--[[
  list:add(Property:new_float("gamma", 1.0))
  --data.property_list:add(Property:new("gamma_shift", Property.DATA_TYPE_FLOAT, 0.0))
  --data.property_list:add(Property:new("pattern", Property.DATA_TYPE_IMAGE_FILE, ""))

  obs.obs_data_set_default_double(settings, "gamma", 1.0)
  obs.obs_data_set_default_double(settings, "gamma_shift", 0.0)



  obs.obs_data_set_default_string(settings, "pattern_path", "")
  obs.obs_data_set_default_double(settings, "pattern_gamma", 1.0)
  obs.obs_data_set_default_string(settings, "palette_path", "")
  obs.obs_data_set_default_double(settings, "palette_gamma", 1.0)
  obs.obs_data_set_default_string(settings, "pattern_path", "")
  obs.obs_data_set_default_double(settings, "pattern_gamma", 1.0)
  obs.obs_data_set_default_string(settings, "palette_path", "")
  obs.obs_data_set_default_double(settings, "palette_gamma", 1.0)

  -- Pixelation group

  -- Pixelation parameters for resolution
  obs.obs_properties_add_int(gprops, "pixelation_resolution_width", "Resolution width", 1, 1024, 1)
  obs.obs_properties_add_int(gprops, "pixelation_resolution_height", "Resolution height", 1, 1024, 1)

  -- Pattern group
  gprops = obs.obs_properties_create()
  obs.obs_properties_add_group(props, "pattern", "Dithering Pattern", obs.OBS_GROUP_NORMAL, gprops)
  local p = obs.obs_properties_add_path(gprops, "pattern_path", "Pattern texture", obs.OBS_PATH_FILE,
                              "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_properties_add_float_slider(gprops, "pattern_gamma", "Pattern gamma exponent", 1.0, 2.2, 0.2)

  obs.obs_properties_add_float_slider(gprops, "gamma", "Gamma encoding exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_float_slider(gprops, "gamma_shift", "Gamma shift", -2.0, 2.0, 0.01)

  gprops = obs.obs_properties_create()
  p = obs.obs_properties_add_group(props, "palette", "Color palette", obs.OBS_GROUP_NORMAL, gprops)
  p = obs.obs_properties_add_path(gprops, "palette_path", "Palette texture", obs.OBS_PATH_FILE,
                              "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_property_set_modified_callback(p, set_properties_visibility)
  obs.obs_properties_add_float_slider(gprops, "palette_gamma", "Palette gamma exponent", 1.0, 2.2, 0.2)

  -- Retrieves the shader uniform variables
  data.params = {}
  local names = {"width", "height", "gamma", "gamma_shift", "pattern_texture", "pattern_size", "pattern_gamma",
                 "palette_texture", "palette_size", "palette_gamma"}
  for _,name in pairs(names) do
    data.params[name] = obs.gs_effect_get_param_by_name(effect, name)
  end
  ]]

----------------------------------------------- GLOBAL SCRIPT FUNCTIONS ------------------------------------------------

-- List of properties as PropertyList for the main script functions (not source_info part)
properties = build_script_property_list()

-- Default values for source creation
default_usage_mode = USAGE_MODES.BASIC

-- Returns the description to be displayed in the Scripts window
function script_description()

  local alien="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABMAAAAVCAYAAACkCdXRAAAAAXNSR0IArs4c6QAAAARnQU1BAACxj"..
  "wv8YQUAAAAJcEhZcwAADsIAAA7CARUoSoAAAADwSURBVDhPtZQxDsIwDEUDYoSBHWhHbsPC2tOxsnAbxhbYGWBEAn0rBid20lDBk1BS17z+hBT3"..
  "S0Z+TFItq6efuu7cZfuTN1ky26/d9XCh2mR3pzElNYsQQSJhIYDUEqqCJWL6hGM/EjlRzKOZBvsJ3uZSkUwHZMIgWQnzzcLPNGTkVLftkYqMlTT"..
  "uwXI5nUrWnlr6gPiLfC17JOYy61XtZx+BFMv7EiXjRuvJsmYJSYb14slyj6zmuCb3C9cq2TfnLCY4wSVnLfcWmD/AUIJkIJeu791UMmAJB/1rMB"..
  "BihJRFkABLBJIyhqUgJfkDzr0Amw2KoGT2/LMAAAAASUVORK5CYII="

  local description = [[<center><h2>Pixel Art</h2></center>
  <center><img width=38 height=42 src=']] .. alien .. [['/><br/>
  <a href="https://github.com/bfxdev/OBS">bfxdev</a> - 2021</center>
  <p>This Lua script adds a new filter named "Pixel Art". It can be applied to any video source to reduce the
  pixel resolution and the number of colors, and hence obtain a retro-computer looking picture.</p>
  <p>It works with a custom or a pre-defined palette and features dithering, down-scaling, outlines, etc.</p>
  <p>As a main global setting, the default preset can be chosen below. Additional settings are available when the filter
  is added to a source.</p>]]

  return description
end

--- Initializes default values if necessary - Called by OBS
function script_defaults(settings)
  log_debug("Begin script_defaults")

  -- Setups default values and calls update to set global settings once
  properties:write_default_values(settings)
  script_update(settings)

  log_debug("End script_defaults")
end

--- Registers the source_info structure - Called by OBS
function script_load(settings)
  log_debug("Begin script_load")

  -- Registers the source_info data structure defined below 
  obs.obs_register_source(source_info)

  log_debug("End script_load")
end

--- Reads the current values from the settings - Called by OBS
function script_update(settings)
  log_debug("Begin script_update")

  -- Reads and sets global variables for logging and source creation
  properties:read_current_values(settings)
  log_level = properties:get_value("log_level")
  default_usage_mode = properties:get_value("default_usage_mode")

  log_debug("Properties:", tostring(properties))
  log_debug("End script_update")
end

--- Builds the properties GUI - Called by OBS
function script_properties()
  log_debug("Begin script_properties")
  local props = properties:build_user_interface()
  log_debug("End script_properties")
  return props
end


------------------------------------- SOURCE INFO DEFINITION AND HELPER FUNCTIONS --------------------------------------

-- Instance of the list of properties for the source, used only to set defaults
static_source_properties = build_source_property_list()

-- Definition of the global variable containing the source_info structure
source_info = {}
source_info.id = 'filter-pixel-art'             -- Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
source_info.get_name = function()
  return "Pixel Art"
end

-- Creates the implementation data for the source
source_info.create = function(settings, source)
  log_debug("Begin source_info.create")

  -- Initializes the custom data table
  local data = {}
  data.source = source -- Keeps a reference to this filter as a source object
  data.width = 1       -- Dummy value during initialization phase
  data.height = 1      -- Dummy value during initialization phase

  -- Compiles the effect
  obs.obs_enter_graphics()
  local effect_file_path = script_path() .. 'filter-pixel-art.effect.hlsl'
  data.effect = obs.gs_effect_create_from_file(effect_file_path, nil)
  -- data.effect = obs.gs_effect_create(EFFECT, "halftone_effect_code", nil)
  obs.obs_leave_graphics()

  -- Destroys the creates structures if the effect was not compiled properly and do not allow the source to be used
  if data.effect == nil then
    log_error("Effect compilation failed")
    source_info.destroy(data)
    return nil
  end

  -- Creates the list of properties
  data.properties = build_source_property_list()

  -- Retrieves the common effect uniform variables
  data.params = {}
  data.params.width = obs.gs_effect_get_param_by_name(data.effect, "width")
  data.params.height = obs.gs_effect_get_param_by_name(data.effect, "height")

  -- Retrieves the effect uniform variables related to the properties
  data.properties:read_effect_parameters(data.effect)

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  log_debug("End source_info.create")
  return data
end

-- Sets the default settings for this source
source_info.get_defaults = function(settings)
  log_debug("Begin source_info.get_defaults")

  -- Populate default values
  static_source_properties:write_default_values(settings)

  log_debug("End source_info.get_defaults")
end


-- Returns the width of the source
source_info.get_width = function(data)
  return data.width
end

-- Returns the height of the source
source_info.get_height = function(data)
  return data.height
end

-- Called each frame for GIF animation
source_info.video_tick = function(data, seconds)
  data.nanoseconds = seconds*1e9
end

-- Sets a texture with its size in the shader, updates the GIF animation step if necessary, size set to (-1,-1)
--  if the image is not available
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

-- Destroys and release resources linked to the custom data
source_info.destroy = function(data)
  if data.effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(data.effect)
    data.effect = nil
    obs.obs_leave_graphics()
  end
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

----------------------------------------------- SOURCE INFO PROPERTIES -------------------------------------------------


-- Properties "modified callback" to set visible flags of the displayed properties
function set_properties_visibility(props, property, settings)

  -- Flags
  local pattern = string.len(obslua.obs_data_get_string(settings, "pattern_path")) > 0
  local palette = string.len(obslua.obs_data_get_string(settings, "palette_path")) > 0

  obs.obs_property_set_visible(obs.obs_properties_get(props, "pattern_gamma"), pattern)
  obs.obs_property_set_visible(obs.obs_properties_get(props, "palette_gamma"), palette)

  -- Flags and values
  local pixelation = obs.obs_data_get_bool(settings, "pixelation")
  local pixelation_type = obs.obs_data_get_int(settings, "pixelation_type")

  -- Properties
  local data = {["pixelation_algorithm"] = pixelation, ["pixelation_type"] = pixelation,
                ["pixelation_block_width"] = pixelation and pixelation_type==0,
                ["pixelation_block_height"] = pixelation and pixelation_type==0,
                ["pixelation_resolution_width"] = pixelation and pixelation_type>=1,
                ["pixelation_resolution_height"] = pixelation and pixelation_type>=1}
  for name,flag in pairs(data) do
    obs.obs_property_set_visible(obs.obs_properties_get(props, name), flag)
  end

  return true
end

-- Gets the property information of this source
source_info.get_properties = function(data)
  log_debug("Entering source_info.get_properties")

  -- Main properties object
  local props = data.properties:build_user_interface()

--[[

  -- Pixelation group
  local gprops = obs.obs_properties_create()
  local p = obs.obs_properties_add_group(props, "pixelation", "Pixelation", obs.OBS_GROUP_CHECKABLE, gprops)
  obs.obs_property_set_modified_callback(p, set_properties_visibility)

  -- Interpolation algorithm
  p = obs.obs_properties_add_list(gprops, "pixelation_algorithm", "Interpolation algorithm",
                                  obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
  for n,v in pairs({[0]="Sub-sampling", [1]="Bilinear", [2]="Bicubic", [3]="Lanczos"}) do
    obs.obs_property_list_add_int(p, v, n)
  end
  obs.obs_property_set_modified_callback(p, set_properties_visibility)

  -- Pixelation type
  p = obs.obs_properties_add_list(gprops, "pixelation_type", "Pixelation type",
                                  obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
  for n,v in pairs({[0]="Pixel blocks", [1]="Resolution"}) do
    obs.obs_property_list_add_int(p, v, n)
  end
  obs.obs_property_set_modified_callback(p, set_properties_visibility)

  -- Pixelation parameters for pixel blocks
  obs.obs_properties_add_int_slider(gprops, "pixelation_block_width", "Block width", 1, 20, 1)
  obs.obs_properties_add_int_slider(gprops, "pixelation_block_height", "Block height", 1, 20, 1)

  -- Pixelation parameters for resolution
  obs.obs_properties_add_int(gprops, "pixelation_resolution_width", "Resolution width", 1, 1024, 1)
  obs.obs_properties_add_int(gprops, "pixelation_resolution_height", "Resolution height", 1, 1024, 1)

  -- Pattern group
  gprops = obs.obs_properties_create()
  obs.obs_properties_add_group(props, "pattern", "Dithering Pattern", obs.OBS_GROUP_NORMAL, gprops)
  local p = obs.obs_properties_add_path(gprops, "pattern_path", "Pattern texture", obs.OBS_PATH_FILE,
                              "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_properties_add_float_slider(gprops, "pattern_gamma", "Pattern gamma exponent", 1.0, 2.2, 0.2)

  obs.obs_properties_add_float_slider(gprops, "gamma", "Gamma encoding exponent", 1.0, 2.2, 0.2)
  obs.obs_properties_add_float_slider(gprops, "gamma_shift", "Gamma shift", -2.0, 2.0, 0.01)

  gprops = obs.obs_properties_create()
  p = obs.obs_properties_add_group(props, "palette", "Color palette", obs.OBS_GROUP_NORMAL, gprops)
  p = obs.obs_properties_add_path(gprops, "palette_path", "Palette texture", obs.OBS_PATH_FILE,
                              "Picture (*.png *.bmp *.jpg *.gif)", nil)
  obs.obs_property_set_modified_callback(p, set_properties_visibility)
  obs.obs_properties_add_float_slider(gprops, "palette_gamma", "Palette gamma exponent", 1.0, 2.2, 0.2)
  ]]

  log_debug("Leaving source_info.get_properties")
  return props
end

-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)
  data.gamma = obs.obs_data_get_double(settings, "gamma")
  data.gamma_shift = obs.obs_data_get_double(settings, "gamma_shift")

  -- Keeps a reference on the settings
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

------------------------------------------------- SOURCE INFO RENDER ---------------------------------------------------

-- Called when rendering the source with the graphics subsystem
source_info.video_render = function(data)
  local parent = obs.obs_filter_get_parent(data.source)
  data.width = obs.obs_source_get_base_width(parent)
  data.height = obs.obs_source_get_base_height(parent)

  obs.obs_source_process_filter_begin(data.source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)

  -- Effect parameters initialization
  obs.gs_effect_set_int(data.params.width, data.width)
  obs.gs_effect_set_int(data.params.height, data.height)

  --[[
  obs.gs_effect_set_float(data.params.gamma, data.gamma)
  obs.gs_effect_set_float(data.params.gamma_shift, data.gamma_shift)

  -- Pattern texture
  set_texture_effect_parameters(data.pattern, data.params.pattern_texture,
                                data.params.pattern_size, data.nanoseconds)
  obs.gs_effect_set_float(data.params.pattern_gamma, data.pattern_gamma)

  -- Palette texture
  set_texture_effect_parameters(data.palette, data.params.palette_texture,
                                data.params.palette_size, data.nanoseconds)
  obs.gs_effect_set_float(data.params.palette_gamma, data.palette_gamma)
  ]]

  obs.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end


--[[
  source = obs.obs_get_source_by_name(source_name)
  if source:
    obs.obs_enter_graphics()

    source_width = obs.obs_source_get_base_width(source)
    source_height = obs.obs_source_get_base_height(source)

    global stage_surface, render_texture
    if stage_surface is None:

      render_texture = obs.gs_texrender_create(obs.GS_RGBA, obs.GS_ZS_NONE)
      stage_surface = obs.gs_stagesurface_create(source_width, source_height, obs.GS_RGBA)

      obs.gs_texrender_reset(render_texture)

      if obs.gs_texrender_begin(render_texture, source_width, source_height):

        clear_color = obs.vec4()
        obs.vec4_zero(clear_color)
        obs.gs_clear(obs.GS_CLEAR_COLOR, clear_color, 0, 0)

        obs.gs_ortho(0, source_width, 0, source_height, -100, 100)

        obs.gs_blend_state_push()
        obs.gs_blend_function(obs.GS_BLEND_ONE, obs.GS_BLEND_ZERO)

        obs.obs_source_inc_showing(source)
        obs.obs_source_video_render(source)
        obs.obs_source_dec_showing(source)

        obs.gs_blend_state_pop()

        obs.gs_texrender_end(render_texture)

        obs.gs_stage_texture(stage_surface, obs.gs_texrender_get_texture(render_texture))

    else:

      res,data,linesize = obs.gs_stagesurface_map(stage_surface)

      if res:

        bitmap = bytearray(source_width*source_height*4)
        for y in range(source_height):
          bitmap[y*source_width*4 : (y+1)*source_width*4] = data[y*linesize : y*linesize + source_width*4]

        obs.gs_stagesurface_unmap(stage_surface)
        
        image = Image.frombuffer("RGBA", (source_width,source_height), bitmap)
        cv_image = cv2.cvtColor(np.asarray(image), cv2.COLOR_RGB2GRAY)

        faces = detector(cv_image)

        for face in faces:
            x1 = face.left() # left point
            y1 = face.top() # top point
            x2 = face.right() # right point
            y2 = face.bottom() # bottom point
            # Draw a rectangle
            # cv2.rectangle(img=img, pt1=(x1, y1), pt2=(x2, y2), color=(0, 255, 0), thickness=4)

            landmarks = predictor(image=cv_image, box=face)
            for i in range(67):
              x = landmarks.part(i).x
              y = landmarks.part(i).y
              cv2.circle(img=cv_image, center=(x, y), radius=2, color=(0, 255, 0), thickness=-1)

        global counter
        counter = counter - 1
        if counter <= 0:
          counter = 100

          print("width:", obs.gs_stagesurface_get_width(stage_surface))
          print("height:", obs.gs_stagesurface_get_height(stage_surface))
          print("linesize:", linesize)
          print("data:", data)
          print("data.hex():", data.hex())
          #print("len(data):", len(data))
          print("type(data):", type(data))
          print("bitmap.hex():", bitmap.hex())
          print("cv_image:", cv_image)
          print("faces:", faces)
          cv2.imshow(winname="Face", mat=cv_image)

      obs.gs_stagesurface_destroy(stage_surface)
      stage_surface = None
      obs.gs_texrender_destroy(render_texture)
      render_texture = None

    obs.obs_leave_graphics()
    obs.obs_source_release(source)


]]




