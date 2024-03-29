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

--              - Single-pixel outline based on Sobel filters or pixel-level rules, then optimized according to       --
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

--- Global default log level
log_level = LOG_LEVELS.WARNING

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

PROPERTY_TYPES = {UNDEFINED = 0,                             -- Undefined if no type provided
                  INT = 1, FLOAT = 2, BOOL = 3, STRING = 4,  -- Base types
                  VEC2 = 10,                                 -- Composite types encoded as {val1, val2, ...} tables
                  COLOR = 20, TEXTURE = 21, IMAGE_FILE = 22, -- Graphical types
                  GROUP = 30, PRESET = 31}                   -- Special types

--- @class Property
Property = {}

-- TODO: Copy input object template if nothing is given as argument

--- Property constructor - Do not use directly
--- @param type          integer  Data type among PROPERTY_TYPES
--- @param name          string   Base name used as OBS user setting and effect parameter, with suffix for composite types
--- @param default       any      Default value, encoded as {val1, val2, ...} table for composite types
--- @param is_persistent boolean  Value saved in data settings if true (default false)
--- @return Property property     Instance of the object
function Property:new(type, name, default, is_persistent)

  -- Defines object
  o = {}
  setmetatable(o, self)
  self.__index = self
  self.__tostring = as_string

  -- Stores given parameters
  o.type = type or PROPERTY_TYPES.UNDEFINED
  o.name = name or "UNDEFINED NAME"
  o.default = default or "UNDEFINED"
  o.is_persistent = is_persistent==nil and false or is_persistent

  -- Additional members
  o.is_editable = false
  o.param = nil
  o:set_value(default)

  return o
end

--- Defines a numeric user interface for the Property (INT, FLOAT, VEC2)
--- @param description      string               HTML description displayed on graphical user interface
--- @param long_description string               Long description displayed as tool tip
--- @param min              integer|number|table Minimum value
--- @param max              integer|number|table Maximum value
--- @param step             integer|number|table Default increment
--- @param is_slider        boolean              User interface displayed as a slider if true
--- @return Property        property             Instance of the object
function Property:define_user_interface_numeric(description, long_description, min, max, step, is_slider)
  self.is_editable = true
  self.description = description or "UNDEFINED DESCRIPTION"
  self.long_description = long_description
  self.min = min or -1
  self.max = max or -1
  self.step = step or -1
  self.is_slider = is_slider==nil and false or is_slider
  return self
end

--- Defines a list user interface for the Property (INT)
--- @param description      string   HTML description displayed on graphical user interface
--- @param long_description string   Long description displayed as tool tip
--- @param list             table    Array of entries {description, value} for selection as drop-down list (INT)
--- @return Property        property Instance of the object
function Property:define_user_interface_list(description, long_description, list)
  self.is_editable = true
  self.description = description or "UNDEFINED DESCRIPTION"
  self.long_description = long_description
  self.list = list or {}
  return self
end

--- Defines a checkbox user interface for the Property (BOOL)
--- @param description      string   HTML description displayed on graphical user interface
--- @param long_description string   Long description displayed as tool tip
--- @return Property        property Instance of the object
function Property:define_user_interface_checkbox(description, long_description)
  self.is_editable = true
  self.description = description or "UNDEFINED DESCRIPTION"
  self.long_description = long_description
  return self
end

--- Defines a text user interface for the Property (STRING)
--- @param description      string   HTML description displayed on graphical user interface
--- @param long_description string   Long description displayed as tool tip
--- @param is_multiline     boolean  User interface allowing multi-line edition if true (STRING)
--- @return Property        property Instance of the object
function Property:define_user_interface_text(description, long_description, is_multiline)
  self.is_editable = true
  self.description = description or "UNDEFINED DESCRIPTION"
  self.long_description = long_description
  self.is_multiline = is_multiline==nil and false or is_multiline
  return self
end

--- Defines a group user interface for the Property (GROUP)
--- @param description      string   HTML description displayed on graphical user interface
--- @param long_description string   Long description displayed as tool tip
--- @param is_checkable     boolean  Group displayed with check box and using user setting if true (GROUP)
--- @return Property        property Instance of the object
function Property:define_user_interface_group(description, long_description, is_checkable)
  self.is_editable = true
  self.description = description or "UNDEFINED DESCRIPTION"
  self.long_description = long_description
  self.is_checkable = is_checkable==nil and false or is_checkable
  self.properties_count = 0
  return self
end

--- Sets the default value of the property in OBS data settings
--- @param settings any Data settings object of type obs_data_t
function Property:write_default_values(settings)
  log_debug("Writing default values for", self.name)
  if     self.type == PROPERTY_TYPES.INT then
    obs.obs_data_set_default_int(settings, self.name, self.default)
  elseif self.type == PROPERTY_TYPES.FLOAT then
    obs.obs_data_set_default_double(settings, self.name, self.default)
  elseif self.type == PROPERTY_TYPES.BOOL or (self.type == PROPERTY_TYPES.GROUP and self.is_checkable) then
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

  -- No data settings for non-checkable groups
  if self.type == PROPERTY_TYPES.GROUP and not self.is_checkable then
    return

  -- Graphical properties TODO
  elseif self.type == PROPERTY_TYPES.TEXTURE then
    -- TODO

  -- General behavior, the parameter is nil if not found
  else
    self.param = obs.gs_effect_get_param_by_name(effect, self.name)
    -- assert(self.param, "Effect parameter " .. self.name .. " not found")
  end

end

--- Sets the effect parameters
function Property:write_effect_parameters()
  -- log_debug("Writing effect parameters for", self.name)
  if     self.type == PROPERTY_TYPES.INT then
    obs.gs_effect_set_int(self.param, self.value)
  elseif self.type == PROPERTY_TYPES.FLOAT then
    obs.gs_effect_set_float(self.param, self.value)
  elseif self.type == PROPERTY_TYPES.BOOL or (self.type == PROPERTY_TYPES.GROUP and self.is_checkable) then
    obs.gs_effect_set_bool(self.param, self.value)
  elseif self.type == PROPERTY_TYPES.VEC2 then
    obs.gs_effect_set_vec2(self.param, self.value)
  end

end

--- Retrieves the values of the data settings internally
--- @param settings userdata Data settings object of type obs_data_t
function Property:read_current_values(settings)
  log_debug("Reading current values for", self.name)
  if     self.type == PROPERTY_TYPES.INT then
    self.value = obs.obs_data_get_int(settings, self.name)
  elseif self.type == PROPERTY_TYPES.FLOAT then
    self.value = obs.obs_data_get_double(settings, self.name)
  elseif self.type == PROPERTY_TYPES.BOOL or (self.type == PROPERTY_TYPES.GROUP and self.is_checkable) then
    self.value = obs.obs_data_get_bool(settings, self.name)
  elseif self.type == PROPERTY_TYPES.STRING then
    self.value = obs.obs_data_get_string(settings, self.name)
  elseif self.type == PROPERTY_TYPES.VEC2 then
    local val1 = obs.obs_data_get_double(settings, self.name .. "_1")
    local val2 = obs.obs_data_get_double(settings, self.name .. "_2")
    self:set_value({val1, val2})
  end
end

--- Gets the internally stored values as a native type or table for composite values
--- @return any value
function Property:get_value()
  if self.type == PROPERTY_TYPES.VEC2 then
    return {self.value.x, self.value.y}
  else
    return self.value
  end
end

--- Sets the internally stored values given as a native type or table for composite values
--- @param value any
function Property:set_value(value)
  if self.type == PROPERTY_TYPES.VEC2 then
    self.value = obs.vec2()
    obs.vec2_set(self.value, value[1], value[2])
  else
    self.value = value
  end
end


--- Stores the current internal values in the data settings
--- @param settings userdata Data settings object of type obs_data_t
function Property:write_current_values(settings)
  log_debug("Writing current values for", self.name)
  if     self.type == PROPERTY_TYPES.INT then
    obs.obs_data_set_int(settings, self.name, self.value)
  elseif self.type == PROPERTY_TYPES.FLOAT then
    obs.obs_data_set_double(settings, self.name)
  elseif self.type == PROPERTY_TYPES.BOOL or (self.type == PROPERTY_TYPES.GROUP and self.is_checkable) then
    obs.obs_data_set_bool(settings, self.name, self.value)
  elseif self.type == PROPERTY_TYPES.STRING then
    obs.obs_data_set_string(settings, self.name, self.value)
  elseif self.type == PROPERTY_TYPES.VEC2 then
    obs.obs_data_set_double(settings, self.name .. "_1", self.value.x)
    obs.obs_data_set_double(settings, self.name .. "_2", self.value.y)
  end
end


--- Builds graphical user interface in OBS structure of type obs_properties_t
--- @param obs_properties userdata List of OBS properties to create GUI in
--- @return userdata|table obs_property  Created OBS structure of type obs_property_t
function Property:build_user_interface(obs_properties)

  -- Just in case
  if not self.is_editable then return nil end

  -- The return value is either directly a single OBS property object or a table of them
  log_debug("Building user interface for", self.name)
  local obs_property = {}

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
    obs_property[1] = obs.obs_properties_add_float_slider(obs_properties, self.name .. "_1", self.description[1],
                                                          self.min[1], self.max[1], self.step[1])
    obs_property[2] = obs.obs_properties_add_float_slider(obs_properties, self.name .. "_2", self.description[2],
                                                          self.min[2], self.max[2], self.step[2])
  elseif self.type == PROPERTY_TYPES.VEC2 then
    obs_property[1] = obs.obs_properties_add_float(obs_properties, self.name .. "_1", self.description[1],
                                                   self.min[1], self.max[1], self.step[1])
    obs_property[2] = obs.obs_properties_add_float(obs_properties, self.name .. "_2", self.description[2],
                                                   self.min[2], self.max[2], self.step[2])
  elseif self.type == PROPERTY_TYPES.GROUP then
    self.obs_properties = obs.obs_properties_create()
    local group_type = self.is_checkable and obs.OBS_GROUP_CHECKABLE or obs.OBS_GROUP_NORMAL
    obs_property = obs.obs_properties_add_group(obs_properties, self.name, self.description, group_type,
                                                self.obs_properties)
  end

  self.obs_property = obs_property
  return obs_property
end

---------------------------------------------- PROPERTY LIST HELPER CLASS ----------------------------------------------

--- @class PropertyList
--- @field properties table Array of Property objects
--- @field index      table Dictionary of Property objects indexed by Property names
--- @field groups     table Array of currently opened groups
--- @field visibility table Dictionary of array of arrays {NAME,OPERATOR,VALUE} indexed by Property name
PropertyList = {properties={}, index={}, groups={}, visibility={}}

--- PropertyList constructor
--- @param o table|nil Optional table of members used as template
--- @return PropertyList property_list Instance of the object
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
  o.visibility = {}
  return o
end

--- Adds a property to the list
--- @param property      Property Property to add
--- @return Property property The property given as argument
function PropertyList:add(property)
  log_debug("Adding property", property)
  table.insert(self.properties, property)
  self.index[property.name] = property
  if #self.groups > 0 then

    -- Count property in current group
    local group = self.groups[#self.groups]
    log_debug("Adding", property.name, "to group", group.name)
    group.properties_count = group.properties_count + 1

    -- Set visibility of added property to follow group check
    if group.is_checkable then
      self:add_visibility_condition(property.name, group.name, "==", true)
    end
  end
  return property
end

--- Adds a property with an optional numeric user interface of type INT
--- @param name             string  Name of the property in the data settings
--- @param default          integer Default value (default 0)
--- @param description      string  Description to be displayed on properties dialog (not editable if nil)
--- @param min              integer Minimum value (default -100)
--- @param max              integer Maximum value (default  100)
--- @param step             integer Increment (default 1)
--- @param is_slider        boolean Property displayed as slider (default true)
--- @param long_description string  Long description displayed as tool tip
--- @param is_persistent    boolean Data save in settings if true (default true if editable, false otherwise)
--- @return Property property       The property given as argument
function PropertyList:add_int(name, default, description, min, max, step, is_slider, long_description, is_persistent)
  is_persistent = is_persistent~=nil and is_persistent or description~=nil
  local property = Property:new(PROPERTY_TYPES.INT, name, default or 0, is_persistent)
  if description then
    property:define_user_interface_numeric(description, long_description, min or -100, max or 100, step or 1,
                                           is_slider==nil and true or is_slider)
  end
  return self:add(property)
end

--- Adds a property with an optional numeric user interface of type FLOAT
--- @param name             string  Name of the property in the data settings
--- @param default          number  Default value (default 0.0)
--- @param description      string  Description to be displayed on properties dialog (not editable if nil)
--- @param min              number  Minimum value (default -1.0)
--- @param max              number  Maximum value (default  1.0)
--- @param step             number  Increment (default 0.01)
--- @param is_slider        boolean Property displayed as slider (default true)
--- @param long_description string  Long description displayed as tool tip
--- @param is_persistent    boolean Data save in settings if true (default true if editable, false otherwise)
--- @return Property property       The property given as argument
function PropertyList:add_float(name, default, description, min, max, step, is_slider, long_description, is_persistent)
  is_persistent = is_persistent~=nil and is_persistent or description~=nil
  local property = Property:new(PROPERTY_TYPES.FLOAT, name, default or 0.0, is_persistent)
  if description then
    property:define_user_interface_numeric(description, long_description, min or -1.0, max or 1.0, step or 0.01,
                                           is_slider==nil and true or is_slider)
  end
  return self:add(property)
end

--- Adds a property with an optional numeric user interface of type VEC2
--- @param name             string       Name of the property in the data settings
--- @param default          table|number Default value (default {0.0,0.0})
--- @param description      table|string Description to be displayed on properties dialog (not editable if nil)
--- @param min              table|number Minimum value (default {-1.0,-1.0})
--- @param max              table|number Maximum value (default { 1.0, 1.0})
--- @param step             table|number Increment (default {0.01,0.01})
--- @param is_slider        boolean      Property displayed as slider (default true)
--- @param long_description table|string Long description displayed as tool tip
--- @param is_persistent    boolean      Data save in settings if true (default true if editable, false otherwise)
--- @return Property property            The property given as argument
function PropertyList:add_vec2(name, default, description, min, max, step, is_slider, long_description, is_persistent)
  is_persistent = is_persistent~=nil and is_persistent or description~=nil
  default = default and (type(default)=="table" and default or {default, default}) or {0.0,0.0}
  local property = Property:new(PROPERTY_TYPES.VEC2, name, default or {0.0,0.0}, is_persistent)
  if description then
    description = type(description)=="table" and description or {description, description}
    min = min and (type(min)=="table" and min or {min, min}) or {-1.0,-1.0}
    max = max and (type(max)=="table" and max or {max, max}) or { 1.0, 1.0}
    step = step and (type(step)=="table" and step or {step, step}) or { 0.01, 0.01}
    long_description = long_description and (type(long_description)=="table" and long_description or
                                            {long_description, long_description}) or nil
    property:define_user_interface_numeric(description, long_description, min, max, step,
                                           is_slider==nil and true or is_slider)
  end
  return self:add(property)
end

--- Adds a property with a list user interface of type INT
--- @param name             string  Name of the property in the data settings
--- @param default          integer Default value (default 0)
--- @param description      string  Description to be displayed on properties dialog (assumed non-nil)
--- @param list             table   Table of ordered {DESCRIPTION,VALUE} entries or indexed list of DESCRIPTION strings
--- @param is_indexed       boolean If true the passed list is dictionary of value-indexed DESCRIPTIONs
--- @param long_description string  Long description displayed as tool tip
--- @param is_persistent    boolean Data save in settings if true (default true if editable, false otherwise)
--- @return Property property       The property given as argument
function PropertyList:add_int_list(name, default, description, list, is_indexed, long_description, is_persistent)
  is_persistent = is_persistent~=nil and is_persistent or description~=nil
  local property = Property:new(PROPERTY_TYPES.INT, name, default or 0, is_persistent)
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
  property:define_user_interface_list(description, long_description, list or {{"DEFAULT", default or 0}})
  return self:add(property)
end

--- Adds a property with an optional checkbox user interface of type BOOL
--- @param name             string  Name of the property in the data settings
--- @param default          boolean Default value (default false)
--- @param description      string  Description to be displayed on properties dialog
--- @param long_description string  Long description displayed as tool tip
--- @param is_persistent    boolean Data save in settings if true (default true if editable, false otherwise)
--- @return Property property       The property given as argument
function PropertyList:add_bool(name, default, description, long_description, is_persistent)
  is_persistent = is_persistent~=nil and is_persistent or description~=nil
  local property = Property:new(PROPERTY_TYPES.BOOL, name, default or false, is_persistent)
  if description then
    property:define_user_interface_checkbox(description, long_description)
  end
  return self:add(property)
end

--- Adds a property with an optional text user interface of type STRING
--- @param name             string  Name of the property in the data settings
--- @param default          string  Default value (default empty)
--- @param description      string  Description to be displayed on properties dialog
--- @param is_multiline     boolean True if the string can contain new lines
--- @param long_description string  Long description displayed as tool tip
--- @param is_persistent    boolean Data save in settings if true (default true if editable, false otherwise)
--- @return Property property       The property given as argument
function PropertyList:add_bool(name, default, description, is_multiline, long_description, is_persistent)
  is_persistent = is_persistent~=nil and is_persistent or description~=nil
  local property = Property:new(PROPERTY_TYPES.STRING, name, default or "", is_persistent)
  if description then
    property:define_user_interface_text(description, long_description, is_multiline or false)
  end
  return self:add(property)
end

--- Begins group optionally checkable
--- @param description      string  Displayed description
--- @param name             string  Property name (group not checkable if nil)
--- @param default          boolean Default value of the checkable flag
--- @param long_description string  Long description displayed as tool tip
--- @param is_persistent    boolean Data save in settings if true (default true if editable, false otherwise)
--- @return Property   group        The group just added
function PropertyList:begin_group(description, name, default, long_description, is_persistent)
  is_persistent = is_persistent~=nil and is_persistent or name~=nil
  local group = Property:new(PROPERTY_TYPES.GROUP, name or ("name-"..tostring(math.random(1e10))), default or false,
                             is_persistent)
  group:define_user_interface_group(description, long_description, name~=nil)
  self:add(group)
  table.insert(self.groups, group)
  return group
end

--- Ends group
--- @return Property group The group just removed
function PropertyList:end_group()
  return table.remove(self.groups)
end


-- Properties "modified callback" to set visible flags of the displayed properties
function PropertyList:property_modified_callback(obs_properties, obs_property, settings, name)
  log_debug("Entering PropertyList:property_modified_callback for", name)

  -- Retrieves value that just changed
  self.index[name]:read_current_values(settings)

  -- Sets visible flags on OBS properties
  self:evaluate_visibility()

  --self:write_current_values(settings)
  log_debug("Leaving PropertyList:property_modified_callback for", name)

  -- Returns true to refresh GUI
  if not self.index[name].is_slider then
    return true
  end
end

--- Builds graphical user interface in OBS structure of type obs_properties_t
--- @param obs_properties userdata    Optional obs_properties_t object (created if not given)
--- @param start          nil|integer Optional start index in list of properties (used only for recursion)
--- @param count          nil|integer Optional number of properties to handle (used only for recursion)
--- @return userdata obs_properties   OBS structure of type obs_properties_t (passed or created)
function PropertyList:build_user_interface(obs_properties, start, count)

  -- Prepares data from direct call or during recursion
  obs_properties = obs_properties or obs.obs_properties_create()
  start = start or 1
  count = count or #self.properties

  -- Main loop to process flat list of properties and groups
  local index = start
  while index < start+count do
    local property = self.properties[index]

    -- Creates the editable OBS property GUI
    if property.is_editable then
      local obs_property = property:build_user_interface(obs_properties)

      -- Sets the modified callback (obs_property may be a table e.g. for vec2) for visibility
      for _,p in ipairs(type(obs_property)=="table" and obs_property or {obs_property}) do
        obs.obs_property_set_modified_callback(p, function(props, prop, settings)
          return self:property_modified_callback(props, prop, settings, property.name) end)
      end
    end

    -- Creates the OBS properties of a group recursively for the next values of index
    if property.type == PROPERTY_TYPES.GROUP then
      self:build_user_interface(property.obs_properties, index+1, property.properties_count)
      index = index + property.properties_count
    end

    index = index + 1
  end

  return obs_properties
end

--- Sets the default values of the properties in OBS data settings
--- @param settings any Data settings object of type obs_data_t
function PropertyList:write_default_values(settings)
  for _,property in ipairs(self.properties) do
    if property.is_persistent then
      property:write_default_values(settings)
    end
  end
end

--- Retrieves the effect params internally
--- @param effect any Compiled effect
function PropertyList:read_effect_parameters(effect)
  for _,property in ipairs(self.properties) do
    property:read_effect_parameters(effect)
  end
end

--- Sets the effect parameters
--- @param property_names nil|string|table Array of Property names to be set/skipped (all properties set if nil)
--- @param is_blacklist   nil|boolean      All properties set except the ones given in the array if true
function PropertyList:write_effect_parameters(property_names, is_blacklist)

  -- Prepares flat array of Property objects
  property_names = type(property_names)=="string" and {property_names} or property_names
  local properties = {}
  if property_names and not is_blacklist then
    for _,name in ipairs(property_names) do table.insert(properties, self.index[name]) end
  elseif property_names and is_blacklist then
    -- TODO optimize, first create set, then create list
    local blacklist_set = {}
    for _,name in ipairs(property_names) do blacklist_set[name] = true end
    for _,property in ipairs(self.properties) do
      if not blacklist_set[name] then table.insert(properties, property) end
    end
  else
    properties = self.properties
  end

  -- Iterates over determined set of properties
  for _,property in ipairs(properties) do
    if property.param then
      property:write_effect_parameters()
    end
  end
end


--- Retrieves the values of the data settings internally
--- @param settings userdata Data settings object of type obs_data_t
function PropertyList:read_current_values(settings)
  for _,property in ipairs(self.properties) do
    if property.is_persistent then
      property:read_current_values(settings)
    end
  end
end

--- Returns the value of the property with given name (to be called after read_current_values)
--- @param name string Property name
--- @return any value
function PropertyList:get_value(name)
  assert(self.index[name], "Cannot find property " .. name .. " for get_value()")
  return self.index[name]:get_value()
end

--- Stores the current internal values in the data settings
--- @param settings userdata Data settings object of type obs_data_t
function PropertyList:write_current_values(settings)
  for _,property in ipairs(self.properties) do
    if property.is_persistent then
      property:write_current_values(settings)
    end
  end
end

--- Sets the value of the property with given name (to be called before write_current_values)
--- @param name  string Property name
--- @param value any    Value to set
function PropertyList:set_value(name, value)
  assert(self.index[name], "Cannot find property " .. name .. " for set_value()")
  self.index[name]:set_value(value)
end

--- Adds a condition for visibility
--- @param property_names          string|table Name(s) of the properties on which the conditional visibility applies
--- @param condition_property_name string       Name of the property to get the value to compare
--- @param operator                string       One of "=", "==", "!=", ">", ">=", "<", "<="
function PropertyList:add_visibility_condition(property_names, condition_property_name, operator, value)

  -- Argument property_names may be a table or a string
  for _,name in ipairs(type(property_names)=="table" and property_names or {property_names}) do

    -- Creates an empty list of conditions if not already existing
    if not self.visibility[name] then
      self.visibility[name] = {}
    end

    -- Inserts condition as a simple array
    table.insert(self.visibility[name], {condition_property_name, operator, value})

  end

end

function PropertyList:evaluate_visibility()
  for _,property in ipairs(self.properties) do
    if property.obs_property and self.visibility[property.name] then

      local conditions = self.visibility[property.name]

      local is_visible = true
      for _,condition in ipairs(conditions) do

        -- Retrieve condition parameters
        local current_value = self:get_value(condition[1])
        local operator = condition[2]
        local compare_value = condition[3]

        -- Evaluates visibility of this condition
        if operator == "=" or operator == "==" then
          is_visible = (current_value == compare_value)
        elseif operator == "!=" or operator == "<>" or operator == "~=" then
          is_visible = (current_value ~= compare_value)
        elseif operator == "<" then
          is_visible = (current_value < compare_value)
        elseif operator == "<=" then
          is_visible = (current_value <= compare_value)
        elseif operator == ">" then
          is_visible = (current_value > compare_value)
        elseif operator == ">=" then
          is_visible = (current_value >= compare_value)
        end

        -- Stops as soon as one condition is not fulfilled
        if not is_visible then break end
      end

      -- Sets resulting visibility on obs_property (possibly a table for e.g. vec2)
      for _,p in ipairs(type(property.obs_property)=="table" and property.obs_property or {property.obs_property}) do
        obs.obs_property_set_visible(p, is_visible)
      end

    end
  end

end

------------------------------------------------ PROPERTIES DEFINITION -------------------------------------------------

USAGE_MODES =           {BASIC=1,       [1]="Basic",
                         ADVANCED=2,    [2]="Advanced",
                         EXPERT=3,      [3]="Expert"}

PIXELATION_ALGORITHMS = {SUBSAMPLING=1, [1]="Nearest neighbor",        -- No interpolation
                         BILINEAR=2,    [2]="Bilinear"}                -- Bilinear interpolation

PIXELATION_TYPES =      {BLOCK=1,       [1]="Pixel blocks dimensions", -- Specify width and height of pixel blocks
                         BLOCK_RATIO=2, [2]="Pixel blocks ratio/size", -- Specify width and ratio of pixel blocks
                         RESOLUTION=3,  [3]="Raw target resolution",   -- Raw target resolution, ratio unspecific
                         HOMOGENEOUS=4, [4]="Homogeneous scale"}       -- Scale with kept aspect ratio and border


MAIN_PRESETS = {{"Custom", 0}, {"CPC Mode 0",1}, {"CPC Mode 1",1}}  -- TODO now for GUI only, transform to clean enum

-- Global script properties (log_level see above)
default_main_preset = 0   -- TODO redefine
default_usage_mode = USAGE_MODES.BASIC

-- Builds the global PropertyList for the script
function build_script_property_list()
  local list = PropertyList:new()

  list:begin_group("Global settings")

  list:add_int_list("default_usage_mode", default_usage_mode, "Default usage mode", USAGE_MODES, true)

  list:add_int_list("default_main_preset", default_main_preset, "Default main preset", MAIN_PRESETS, false)

  list:add_int_list("log_level", log_level, "Log level", LOG_LEVELS, true)

  list:end_group()

  log_debug("Returned by build_script_property_list:", tostring(list))
  return list
end

-- Builds the global PropertyList for the source info
function build_source_property_list()
  local list = PropertyList:new()

  -- Global group
  list:begin_group("Global")

  list:add_int_list("usage_mode", default_usage_mode, "Usage mode", USAGE_MODES, true)
  list:add_int_list("main_preset", default_main_preset, "Main preset", MAIN_PRESETS, false)

  list:end_group()

  -- Pixelation group
  list:begin_group("Pixelation", "pixelation_active", true)
  list:add_int_list("pixelation_algorithm", PIXELATION_ALGORITHMS.SUBSAMPLING, "Interpolation algorithm",
                    PIXELATION_ALGORITHMS, true)
  list:add_int_list("pixelation_type", PIXELATION_TYPES.BLOCK, "Pixelation type", PIXELATION_TYPES, true)

  -- Block given by dimensions
  list:add_vec2("pixelation_block_size", 2, {"Pixel blocks width","Pixel blocks height"}, 1, 20, 1, true)
  list:add_visibility_condition("pixelation_block_size", "pixelation_type", "=", PIXELATION_TYPES.BLOCK)

  -- Block given by ratio and size
  list:add_float("pixelation_block_ratio", 1.5, "Pixel blocks aspect ratio", 0.1, 10, 0.01, true)
  list:add_float("pixelation_block_diagonal", 2.0, "Pixel blocks diagonal size", 1.0, 100, 0.1, true)
  list:add_visibility_condition({"pixelation_block_ratio", "pixelation_block_diagonal"},
                                "pixelation_type", "=", PIXELATION_TYPES.BLOCK_RATIO)

  list:add_vec2("pixelation_resolution", {320,200}, {"Resolution width","Resolution height"}, 1, 1000, 1, true)
  list:add_visibility_condition("pixelation_resolution", "pixelation_type", "=", PIXELATION_TYPES.RESOLUTION)

  -- Pixelation result
  list:add_vec2("pixelation_image_size", {320,200})

  list:end_group()

  log_debug("Returned by build_source_property_list:", tostring(list))
  return list
end

----------------------------------------------- GLOBAL SCRIPT FUNCTIONS ------------------------------------------------

-- List of properties as PropertyList for the main script functions (not source_info part)
properties = build_script_property_list()

-- Returns the description to be displayed in the Scripts window
function script_description()
  log_debug("Entering script_description")

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

  log_debug("Leaving script_description")
  return description
end

--- Initializes default values if necessary - Called by OBS
function script_defaults(settings)
  log_debug("Entering script_defaults")

  -- Setups default values and calls update to set global settings once
  properties:write_default_values(settings)
  script_update(settings)

  log_debug("Leaving script_defaults")
end

--- Registers the source_info structure - Called by OBS
function script_load(settings)
  log_debug("Entering script_load")

  -- Registers the source_info data structure defined below
  obs.obs_register_source(source_info)

  log_debug("Leaving script_load")
end

--- Reads the current values from the settings - Called by OBS
function script_update(settings)
  log_debug("Entering script_update")

  -- Reads from settings, then sets global variables for logging and source creation
  properties:read_current_values(settings)
  log_level = properties:get_value("log_level")
  default_usage_mode = properties:get_value("default_usage_mode")
  default_main_preset = properties:get_value("default_main_preset")

  log_debug("Leaving script_update")
end

--- Builds the properties GUI - Called by OBS
function script_properties()
  log_debug("Entering script_properties")

  -- Builds the GUI visible in the Scripts window
  local props = properties:build_user_interface()

  log_debug("Leaving script_properties")
  return props
end

---------------------------------------------- SOURCE INFO DEFINITION --------------------------------------------------

-- Instance of the list of properties for the source, used only to set defaults
static_source_properties = build_source_property_list()

-- Definition of the global variable containing the source_info structure
source_info = {}
source_info.id = 'filter-pixel-art'             -- Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
source_info.get_name = function()
  log_debug("Entering source_info.get_name")
  local name = "Pixel Art"
  log_debug("Leaving source_info.get_name")
  return name
end

-- Sets the default settings for this source
source_info.get_defaults = function(settings)
  log_debug("Entering source_info.get_defaults")

  -- Populate default values
  static_source_properties:write_default_values(settings)

  log_debug("Leaving source_info.get_defaults")
end

-- Gets the property information of this source
source_info.get_properties = function(data)
  log_debug("Entering source_info.get_properties")

  -- Main properties object
  local props = data.properties:build_user_interface()

  log_debug("Leaving source_info.get_properties")
  return props
end

-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)
  log_debug("Entering source_info.update")

  -- Keeps a reference on the settings
  data.settings = settings

  -- Updates the mirrored values from what the user just changed or was read from the persistent user settings
  data.properties:read_current_values(settings)

  log_debug("Leaving source_info.update")
end

-- Creates the implementation data for the source
source_info.create = function(settings, source)
  log_debug("Entering source_info.create")

  -- Initializes the custom data table
  local data = {}
  data.source = source -- Keeps a reference to this filter as a source object
  data.width = 1       -- Dummy value during initialization
  data.height = 1      -- Dummy value during initialization

  -- Creates the list of properties
  data.properties = build_source_property_list()

  -- Adds the non-persistent, non-editable properties used for the system
  data.properties:add_vec2("image_size", {1,1})

  -- Enters the graphics context
  obs.obs_enter_graphics()

  -- Compiles the effect
  local effect_file_path = script_path() .. 'filter-pixel-art.effect.hlsl'
  data.effect = obs.gs_effect_create_from_file(effect_file_path, nil)
  -- data.effect = obs.gs_effect_create(EFFECT, "halftone_effect_code", nil)

  -- Destroys the creates structures if the effect was not compiled properly and prevent filter use
  if data.effect == nil then
    log_error("Effect compilation failed")
    source_info.destroy(data)
    return nil
  end

  -- Retrieves the effect uniform variables related to the properties
  data.properties:read_effect_parameters(data.effect)

  data.pixelation_param = obs.gs_effect_get_param_by_name(data.effect, "pixelation_image")
  data.image_param = obs.gs_effect_get_param_by_name(data.effect, "image")
  data.pixelation_texture = obs.gs_texrender_create(obs.GS_RGBA, obs.GS_ZS_NONE)
  data.picture = obs.gs_image_file()
  obs.gs_image_file_init(data.picture, script_path() .. "../media/Peach.png")
  if data.picture.loaded then
    obs.gs_image_file_init_texture(data.picture)
    print("cx=" .. tostring(data.picture.cx) .. " cy=" .. tostring(data.picture.cy))
  end

  obs.obs_leave_graphics()

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  log_debug("Leaving source_info.create")
  return data
end

-- Destroys and release resources linked to the custom data
source_info.destroy = function(data)

  if data.pixelation_texture then
    obs.gs_texrender_destroy(data.pixelation_texture)
  end

  if data.effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(data.effect)
    data.effect = nil
    obs.obs_leave_graphics()
  end
end


------------------------------------------------- SOURCE INFO RENDER ---------------------------------------------------

-- Called each frame
source_info.get_width = function(data) return data.width end
source_info.get_height = function(data) return data.height end
source_info.video_tick = function(data, seconds) data.nanoseconds = seconds*1e9 end

-- Called when rendering the source with the graphics subsystem
source_info.video_render = function(data)

  -- Retrieves the size of the original source
  local target = obs.obs_filter_get_target(data.source)
  local parent = obs.obs_filter_get_parent(data.source)
  data.width = obs.obs_source_get_base_width(parent)
  data.height = obs.obs_source_get_base_height(parent)
  data.properties:set_value("image_size", {data.width, data.height})

  ------------------------------------------- PIXELATION -------------------------------------------

  -- Adapts resolution from user settings
  local resolution = data.properties:get_value("pixelation_resolution")
  local pixelation_type = data.properties:get_value("pixelation_type")
  if pixelation_type == PIXELATION_TYPES.BLOCK then
    local block_size = data.properties:get_value("pixelation_block_size")
    resolution[1] = math.floor(data.width/block_size[1])
    resolution[2] = math.floor(data.height/block_size[2])
  elseif pixelation_type == PIXELATION_TYPES.BLOCK_RATIO then
    local ratio = data.properties:get_value("pixelation_block_ratio")
    local diagonal = data.properties:get_value("pixelation_block_diagonal")
    local block_size_y = math.sqrt(diagonal*diagonal / (1 + ratio*ratio))
    local block_size_x = ratio*block_size_y
    resolution[1] = math.floor(data.width/block_size_x)
    resolution[2] = math.floor(data.height/block_size_y)
  end
  data.properties:set_value("pixelation_image_size", resolution)

  -- Chooses down-scale pixelation effect
  local effect = data.effect
  local technique_name = "Draw"
  local pixelation_algorithm = data.properties:get_value("pixelation_algorithm")
  if pixelation_algorithm == PIXELATION_ALGORITHMS.SUBSAMPLING then
    effect = obs.obs_get_base_effect(obs.OBS_EFFECT_DEFAULT)
  elseif pixelation_algorithm == PIXELATION_ALGORITHMS.BILINEAR then
    effect = obs.obs_get_base_effect(obs.OBS_EFFECT_BILINEAR_LOWRES)
  end

  -- Renders texture
  obs.gs_texrender_reset(data.pixelation_texture)

  if obs.gs_texrender_begin(data.pixelation_texture, resolution[1], resolution[2]) then

    --- Pass-through projection and blending parameters
    obs.gs_blend_state_push()
    obs.gs_blend_function(obs.GS_BLEND_ONE, obs.GS_BLEND_ZERO)
    obs.gs_projection_push()
    obs.gs_ortho(0.0, data.width, 0.0, data.height, -100, 100)

    -- Initializes specific effect technique and perform passes
    while obs.gs_effect_loop(effect, technique_name) do
      data.properties:write_effect_parameters()
      obs.obs_source_video_render(target)
    end

    -- Restores old states of the shader
    obs.gs_projection_pop()
    obs.gs_blend_state_pop()

    obs.gs_texrender_end(data.pixelation_texture)
  end

  -- Begins the rendering of the source
  obs.obs_source_process_filter_begin(data.source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)

  -- Sets the user defined properties into the shader
  data.properties:write_effect_parameters()

  local tex = obs.gs_texrender_get_texture(data.pixelation_texture)
  obs.gs_effect_set_texture(data.pixelation_param, tex)

  obs.obs_source_process_filter_tech_end(data.source, data.effect, data.width, data.height, "Render")
end



--[[

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


]]


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




--[[

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


  --[[
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
  ]]


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



]]




