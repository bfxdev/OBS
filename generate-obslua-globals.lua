--------------------------------------------------------------------------------
--- Retrieves info on obslua module and other global variables - bfxdev 2020 ---
--------------------------------------------------------------------------------

-- Once the file is generated, the following line setups IntelliSense for auto-completion
if _G['obslua']==nil then require('obslua-globals') end

--- Name of the file to be created
DESTINATION_FILENAME = "obslua-globals.lua"

--- Keeps a pointer to the settings created by OBS
script_settings = nil

--- Returns a description string (minimal required function for OBS to recognize a Lua file as a script)
function script_description()
  return [[<center><h2>obslua globals</h2></center>
  
           <p>Generates a Lua definition source file with the definition of global variables of the Lua scripting
           environment in OBS. The generated file includes the functions and constants of the <code>obslua</code> module,
           plus some LuaJIT/SWIG/OBS global functions. If given, OBS documentation and compilation files are parsed
           to extract the official description of the functions and the exact types expected in Lua.</p>
           
           <p>The purpose of the generated file is to support IDE features such as auto-completion and contextual
           documentation in e.g. IntelliSense.
           <a href="https://emmylua.github.io">EmmyLua-style</a> annotations are created in the Lua source, supported
           by e.g. <a href="https://marketplace.visualstudio.com/items?itemName=sumneko.lua">sumneko's Language
           Server extension</a> in Visual Studio or Visual Studio Code.
           It should be usable as well with the
           <a href="https://plugins.jetbrains.com/plugin/9768-emmylua">EmmyLua plugin in the IntelliJ IDE</a>.</p>

           <p><bold>WARNING</bold>: This file is useful for development but it cannot
           be used otherwise, i.e. it cannot be included in an OBS script and would provide no functionality if 
           included in a Lua script.</p>]]
end

--- Sets default global variables `destination` and `obsdoc`
function script_defaults(settings)
  obslua.obs_data_set_default_string(settings, "destination", script_path())
  obslua.obs_data_set_default_string(settings, "obsdoc", "")
  obslua.obs_data_set_default_string(settings, "wrapper", "")
  script_settings = settings
end

--- Called when some settings changed
function script_update(settings)
  script_settings = settings
end

--- Displays global properties window
function script_properties()

  -- print("script_settings:" .. tostring(script_settings))

  local properties = obslua.obs_properties_create()
  local p

  p = obslua.obs_properties_add_path(properties, "destination", "Destination folder",
      obslua.OBS_PATH_DIRECTORY, nil, obslua.obs_data_get_string(script_settings, "destination"))

  obslua.obs_property_set_long_description(p, "Destination folder for the generated file " .. DESTINATION_FILENAME)

  p = obslua.obs_properties_add_path(properties, "obsdoc", "OBS docs/sphinx folder",
      obslua.OBS_PATH_DIRECTORY, nil, obslua.obs_data_get_string(script_settings, "obsdoc"))

  obslua.obs_property_set_long_description(p, [[Location of the OBS source documentation folder with rst files, typically at
obs-studio/docs/sphinx where obs-studio is the root of the repository cloned from GitHub]])

  p = obslua.obs_properties_add_path(properties, "wrapper", "C/Lua wrapper file",
      obslua.OBS_PATH_FILE, "Wrapper file (obsluaLUA_wrap.c)", obslua.obs_data_get_string(script_settings, "obsdoc"))

  obslua.obs_property_set_long_description(p, [[Location of the C file created by SWIG during OBS compilation, where a C wrapper function
is defined for each function of the OBS API, typically located at
obs-studio/build/deps/obs-scripting/obslua/CMakeFiles/obslua.dir/obsluaLUA_wrap.c where
obs-studio/build is the compilation build folder]])

  obslua.obs_properties_add_button(properties, "generate", "Generate " .. DESTINATION_FILENAME, generate)

  return properties
end

--- Recursive transformation of any object to string (max depth 10)
local function as_string(content, depth)

  -- Case if depth not given
  if depth == nil then depth=0 end

  -- Result of the function
  local res

    -- Lists all elements of a table
	if type(content) == "table" then
    res = "{"
    for k,v in pairs(content) do
        if string.len(res) > 1 then res = res .. "," end
        res = res .. k .. "="
        if depth < 10 then
            res = res  .. as_string(v, depth+1)
        else
            res = res  .. tostring(v)
        end
    end
    res = res .. "}"

	-- Describes minimal function
	elseif type(content) == "function" then
    res = "function() end"

  -- Type string
  elseif type(content) == "string" then

    -- Escapes backslash characters, carriage returns and adds quotes
    res = string.gsub(content, "\\", "\\\\")
    res = string.gsub(res, "\n", "\\n")
    res = "\"" .. res .. "\""

  -- Everything else
  else
      res =  tostring(content)
  end

	return res
end

--- Main function of the script: generate the Lua file
function generate()

  print("-------------------")
  print("INFO: starting generation of " .. DESTINATION_FILENAME)

  -- Gathers data from OBS docs/sphinx directory
  -- File names listed here to avoid OS-dependent call to `dir` or `ls`
  local filenames = {"reference-libobs-graphics-math.rst", "reference-core-objects.rst", "reference-core.rst", "reference-encoders.rst",
                     "reference-frontend-api.rst", "reference-libobs-callback.rst",
                     "reference-libobs-graphics-axisang.rst", "reference-libobs-graphics-effects.rst",
                     "reference-libobs-graphics-graphics.rst", "reference-libobs-graphics-image-file.rst",
                     "reference-libobs-graphics-math.rst", "reference-libobs-graphics-matrix4.rst",
                     "reference-libobs-graphics-quat.rst", "reference-libobs-graphics-vec2.rst",
                     "reference-libobs-graphics-vec3.rst", "reference-libobs-graphics-vec4.rst",
                     "reference-libobs-graphics.rst", "reference-libobs-media-io.rst",
                     "reference-libobs-util-base.rst", "reference-libobs-util-bmem.rst",
                     "reference-libobs-util-circlebuf.rst", "reference-libobs-util-config-file.rst",
                     "reference-libobs-util-darray.rst", "reference-libobs-util-dstr.rst",
                     "reference-libobs-util-platform.rst", "reference-libobs-util-profiler.rst",
                     "reference-libobs-util-serializers.rst", "reference-libobs-util-text-lookup.rst",
                     "reference-libobs-util-threading.rst", "reference-libobs-util.rst", "reference-modules.rst",
                     "reference-outputs.rst", "reference-properties.rst", "reference-scenes.rst", "reference-services.rst",
                     "reference-settings.rst", "reference-sources.rst", "scripting.rst"}

  -- Iterates on the file names
  local doc_functions = {}
  for _,filename in ipairs(filenames) do

    -- Opens file if possible
    local count = 0
    filename = obslua.obs_data_get_string(script_settings, "obsdoc") .. "/" .. filename
    local file = io.open(filename, "r")
    if not file then
      print("WARNING: skipping file " .. filename)
    else

      -- Reads functions/arguments and description from the doc file
      print("INFO: parsing " .. filename)

      -- The format of a documented function is as following:
      --   <several empty lines>
      --   .. function :: <definition of one or two functions possibly on several lines>
      --   <at least one empty line>
      --   <description text over several line, empty lines for paragraph end>
      --   ---------------------
      -- State machine:
      --  0 - waiting for function definition
      --  1 - in function definition
      --  2 - finished function definition
      --  3 - waiting for description
      --  4 - in description
      --  5 - in description following an empty line
      local names = {}
      local block = ""
      local state = 0
      local count = 0
      for line in file:lines() do

        -- Empty line
        if string.find(line, "^%s*$") then
          -- End of function definition
          if state == 1 then
            state = 2
          -- Stores empty line in description and keeps memory of empty line
          elseif state == 4 then
            for _,name in pairs(names) do table.insert(doc_functions[name].description, "") end
            state = 5
          end
        -- Description end, comes back to begin
        elseif string.find(line, "^---------------------") then
          state = 0
        -- Function definition start
        elseif string.find(line, "^.. function:: ") then
          state = 1
          block = string.gsub(string.sub(line, 15), "^%s*", "")
        -- Non-empty line with no specific marker
        else
          if state == 1 then
            block = block .. string.gsub(line, "^%s*", "")
          elseif state == 3 or state == 4 or state == 5 then
            line = string.gsub(line, "^%s%s%s", "")
            for _,name in pairs(names) do table.insert(doc_functions[name].description, line) end
            state = 4
          end
        end

        -- Processes function definition block
        if state == 2 then

          -- Separates functions if several functions are listed with the same description
          names = {}
          for func in string.gmatch(block, "([^(]+%b())") do
            --print(func)

            -- Detects proper function definition
            local fi, _, ft, fn, fa = string.find(func, "([^%s]* %*?%*?)([%w_]*)(%b())")
            if ft and fn and fa then

              -- Cleans up possible prefixes and spaces
              ft = string.gsub(ft, "%s*const ", "")
              ft = string.gsub(ft, "%s*enum ", "")
              ft = string.gsub(ft, "%s*struct ", "")
              ft = string.gsub(ft, " ", "")
              fn = string.gsub(fn, " ", "")
              fa = string.gsub(fa, "^%(", "")
              fa = string.gsub(fa, "%)$", "")

              -- Replaces parenthesis-enclosed ',' with '#' to simplify parsing of callback types
              fa = string.gsub(fa, "%(([^%),]+),([^%)]*)%)", "%(%1#%2%)")
              fa = string.gsub(fa, "%(([^%),]+),([^%)]*)%)", "%(%1#%2%)")
              fa = string.gsub(fa, "%(([^%),]+),([^%)]*)%)", "%(%1#%2%)")
              fa = string.gsub(fa, "%(([^%),]+),([^%)]*)%)", "%(%1#%2%)")
              fa = string.gsub(fa, "%(([^%),]+),([^%)]*)%)", "%(%1#%2%)")

              -- Parses args, i.e. splits with "," separator
              local arguments = {}
              for arg in string.gmatch(fa, "([^,]+)") do

                -- Cleans up possible prefixes (keeps spaces here to differentiate type and name) and
                -- restores commas
                arg = string.gsub(arg, "%s*const ", "")
                arg = string.gsub(arg, "%s*enum ", "")
                arg = string.gsub(arg, "%s*struct ", "")
                arg = string.gsub(arg, "#", ",")

                -- Detects well-formed argument, differentiates between classical arguments and callbacks
                local pattern
                if string.find(arg, "%(") then
                  -- Callback type
                  pattern = "([%s%w_%*]+ %*?%*?)%(%s*%*%s*([%w_]+)%s*%)%s*(%b())"
                else
                  -- Simple type
                  pattern = "([%s%w_%*]+ %*?%*?)([^%s%*]+)"
                end
                local ai, _, at, an, at2 = string.find(arg, pattern)
                if ai then

                  -- Removes extra spaces in prefix type
                  at = string.gsub(at, " ", "")

                  -- Re-create type for callbacks (removes argument names)
                  if at2 then
                    at2 = string.gsub(at2, "%s*[%w_]+%s*,", ",")
                    at2 = string.gsub(at2, "%s*[%w_]+%s*%)", "%)")
                    at2 = string.gsub(at2, " ", "")
                    at = at .. "(*)" .. at2
                  end

                  table.insert(arguments, {name=an, c_type=at, lua_type=at})
                  if string.find(arg, "%(") then
                    print("INFO: callback argument in function " .. fn .. " - " .. func)
                    print("  Argument arg=" .. arg .. " name=" .. an .. " type=" .. at)
                  end
    
                end
              end

              -- Saves function data
              table.insert(names, fn)
              doc_functions[fn] = {c_type=ft, lua_type=ft, arguments=arguments, definition=func, description={}}
              --print(as_string(doc_functions[fn]))
              count = count + 1
            end
          end
          state = 3
        end
      end

      print("INFO: found " .. tostring(count) .. " new functions in " .. filename)
    end
  end

  -- Wrapper file
  local filename = obslua.obs_data_get_string(script_settings, "wrapper")
  local file = io.open(filename, "r")
  if not file then
    print("WARNING: skipping C/Lua wrapper file " .. filename)
  else

    -- Reads type data from the C file
    print("INFO: parsing " .. filename)
    function_name = "unknown"
    for line in file:lines() do

      -- Parses wrapper function definition, example:
      -- static int _wrap_obs_display_add_draw_callback(lua_State* L) {
      pattern = "^static int _wrap_([%w_]+)%(lua_State%* L%) {"
      local res, _, name = string.find(line, pattern)
      if res and name then
        function_name = name
      end

      -- Parses argument check commands, examples:
      -- if(!lua_isnumber(L,1)) SWIG_fail_arg("obs_key_to_str",1,"obs_key_t");
      -- if(!SWIG_isptrtype(L,2)) SWIG_fail_arg("obs_key_to_str",2,"struct dstr *");
      pattern = '^  if%(!([%w_]+)%(L,(%d)%)%) SWIG_fail_arg%("([^"]+)",%d,"([^"]+)"%);'
      local res, _, convert_func, index, name, c_type = string.find(line, pattern) 
      if res then

        -- Cleans up parsed C type to make it comparable to type determined from doc
        c_type = string.gsub(c_type, "%s*const ", "")
        c_type = string.gsub(c_type, "%s*enum ", "")
        c_type = string.gsub(c_type, "%s*struct ", "")
        c_type = string.gsub(c_type, " ", "")

        -- Converts from acquired string to number
        index = tonumber(index)

        -- Determines Lua type
        local lua_type = c_type
        if convert_func == "SWIG_isptrtype" then
          lua_type = "ref_" .. c_type
        elseif convert_func == "lua_isuserdata" then
          lua_type = "userdata_" .. c_type
        elseif convert_func == "SWIG_lua_isnilstring" then
          lua_type = "string"
        elseif convert_func == "lua_isnumber" then
          lua_type = "number"
        elseif convert_func == "lua_isboolean" then
          lua_type = "boolean"
        end

        -- Creates function entry if not already existing
        if not doc_functions[name] then
          doc_functions[name] = {c_type="void", lua_type="void", arguments={}, definition=nil,
                                 description={"Not mentioned in OBS documentation",""}}
        end

        -- Creates argument entry if not already existing
        if not doc_functions[name].arguments[index] then
          doc_functions[name].arguments[index] = {name="param" .. tostring(index), c_type=c_type, lua_type=lua_type}
        else
          -- Saves lua_type
          doc_functions[name].arguments[index].lua_type = lua_type
        end

        -- Detects C type mismatch between doc and SWIG
        if doc_functions[name].arguments[index].c_type ~= c_type then
          print("WARNING: type mismatch on function " .. name .. " for " .. doc_functions[name].arguments[index].name ..
            "(parameter #" .. tostring(index) .. ")")
          print(" Documentation:" .. doc_functions[name].arguments[index].c_type .. " C wrapper:" .. c_type)
        end
        if name ~= function_name then
          print("WARNING name mismatch: " .. name .. " vs " .. function_name)
        end
      end

      -- Parses argument Lua type check commands, example:
      --     SWIG_fail_ptr("obs_display_add_draw_callback",1,SWIGTYPE_p_obs_display);
      pattern = 'SWIG_fail_ptr%("([%w_]+)",(%d),SWIGTYPE_p_([%w_]+)%);'
      local res, _, name, index, lua_type = string.find(line, pattern) 
      if res and doc_functions[name] then
        -- print("----------------------------------Found: " .. name)
        -- Stores detected type if function already defined (always the case except for setters/getters)
        index = tonumber(index)
        doc_functions[name].arguments[index].lua_type = lua_type
        if name ~= function_name then
          print("WARNING name mismatch: " .. name .. " vs " .. function_name)
        end
      end

      -- Parses return Lua type commands, examples:
      --   lua_pushnumber(L, (lua_Number) result); SWIG_arg++;
      --   SWIG_NewPointerObj(L,result,SWIGTYPE_p_gs_tvertarray,0); SWIG_arg++;
      if string.find(line, "SWIG_NewPointerObj") then
        pattern = 'SWIG_NewPointerObj%(.*SWIGTYPE_p_([%w_]+).*SWIG_arg%+%+;'
      else
        pattern = 'lua_push([%w_]+).*SWIG_arg%+%+;'
      end
      local res, _, lua_type = string.find(line, pattern)
      if res and lua_type and doc_functions[function_name] then
        doc_functions[function_name].lua_type = lua_type
      end
    end
  end






  -- Creates destination file
  file = io.open(obslua.obs_data_get_string(script_settings, "destination") .. DESTINATION_FILENAME, "w")
  if not file then
    print("ERROR: cannot open file " .. obslua.obs_data_get_string(script_settings, "destination") .. DESTINATION_FILENAME)
    return
  end

  -- Header
  print("Writing header")
  file:write([[
-- Definition of globals to reproduce the Lua scripting environment in OBS - bfxdev 2020

-- Use this file to support development in Lua for OBS. It is designed to work in Visual Studio Code with
-- sumneko's Lua Language Server extension, see https://marketplace.visualstudio.com/items?itemName=sumneko.lua
-- With this extension (currently v0.21.2), it is necessary to adapt some settings:
--  - Increase the "Preload File Size" ("Lua.workspace.preloadFileSize") to a size larger than the
--    actual size of this file (e.g. increase to 10000). Otherwise the extension will just ignore the file.
--  - Select "LuaJIT" as "Runtime Version" ("Lua.runtime.version") for support of specific functions and modules
--  - Add the file path (or containing folder path) in the "Workspace Library" ("Lua.workspace.library"). This
--    setting is not even necessary if this file is in the same folder as the source file, or if the file is open
--    in Visual Studio Code.
-- Code documentation follows the syntax of EmmyLua-style annotations, see https://emmylua.github.io
-- Consequently the file should be usable in other environments such as Visual Studio or IntelliJ IDE.

--- Returns Kb of dynamic memory in use.
--- This function is deprecated in Lua 5.1. Use collectgarbage ("count") instead.
--- @param param string
--- @return number
function gcinfo(param) end

--- Unsupported and undocumented function in the Lua base library.
--- From Lua code, the setmetatable function may only be used on objects of table type.
--- The newproxy function circumvents that limitation by creating a zero-size userdata and setting
--- either a new, empty metatable on it or using the metatable of another newproxy instance. We are
--- then free to modify the metatable from Lua. This is the only way to create a proxy object from
--- Lua which honors certain metamethods, such as __len.
--- @param param bool
function newproxy(param) end

--- OBS function that returns the path of the folder of the current script
--- @return string
function script_path()

--- SWIG function - Not documented
function swig_equals() end

--- SWIG function that returns as a string the type of object pointed to by the argument (assuming it was a SWIG wrapped object)
function swig_type(obj) end

--- Main obslua module
obslua = {}

]])


-- Retrieves the table of names of constants/functions and sorts them
  constants = {}
  functions = {}
  for key, value in pairs(obslua) do
    if type(value) == "function" then
      table.insert(functions, key)
    else
      table.insert(constants, key)
    end
  end
  table.sort(constants)
  table.sort(functions)

  -- Writes one line per constant
  print("Writing constants")
  file:write("-- Constants\n")
  for i, key in ipairs(constants) do
    local value = obslua[key]
    local res = as_string(value)
    file:write("obslua." .. key .. " = " .. res .. "\n")
  end

  -- Writes functions definition
  print("Writing functions")
  file:write("\n")
  for i, key in ipairs(functions) do
    local documentation = doc_functions[key]

    -- Non-documented function
    if not documentation then
      file:write("--- " .. key .. " not found in OBS documentation nor C wrapper\n")
      file:write("obslua." .. key .. " = " .. "function() end\n\n")

    -- Documented function
    else

      -- Parsable comments
      for _,s in ipairs(documentation.description) do
        file:write("--- " .. s .. "\n")
      end
      if documentation.definition then
        file:write("--- C definition: `" .. documentation.definition .. "`\n")
      else
        file:write("--- C definition: Not available in OBS documentation\n")
      end
      for _,a in ipairs(documentation.arguments) do
        file:write("--- @param " .. a.name .. " " .. a.lua_type .. "\n")
      end
      if documentation.c_type ~= "void" then
        file:write("--- @return " .. documentation.lua_type .. "\n")
      end

      -- Function definition
      local args = ""
      for _,a in ipairs(documentation.arguments) do
        if #args > 0 then args = args .. ", " end
        args = args .. a.name
      end
      file:write("function obslua." .. key .. "(" .. args ..") end\n\n")

    end
  end

  -- Closes file
  print("Closing file")
  file:write("return obslua\n")
  file:close(file)
end

  --[[ All globals as comment
  local keys = {}
  for key in pairs(_G) do table.insert(keys, key) end
  table.sort(keys)

  for i, key in ipairs(keys) do
    if key ~= "_G" and key ~= "package" and key ~= "obslua" and key ~= "script_path" then
      local value = _G[key]
      local res = as_string(value, 1)
      file:write("-- Global: " .. key .. " = " .. res .. "\n")
    end
  end ]]


--[[ Pre-imported packages, known in sumneko extension with LuaJIT selected:
bit (no detailed documentation)
coroutine
debug
io
jit (no detailed documentation)
math
os
string
table
]]--

--[[ Global functions and strings
_VERSION = "Lua 5.1"
assert
collectgarbage
dofile
error
gcinfo (unknown)
getfenv
getmetatable
ipairs
load
loadstring
module
newproxy (unknown)
next
pairs
pcall
print
rawequal
rawget
rawset
require
script_path (unknown)
select
setfenv
setmetatable
swig_equals (unknown)
swig_type (unknown)
tonumber
tostring
type
unpack
xpcall
]]--
