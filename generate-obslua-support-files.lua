-----------------------------------------------------------------------------------------------------------------------
---                    Retrieves info on obslua module and other global variables - bfxdev 2020                     ---
-----------------------------------------------------------------------------------------------------------------------

-- TODO Tables in obslua are templates for some objects see swig_type(obslua.gs_image_file) with hidden _set/_get "::"
-- TODO Manage properly pointers on simple types e.g. type "unsigned_int" and similar
-- TODO Re-check some types e.g. ref_void* in obs_obj_get_id (see MustGetPtr in C wrapper??)
-- TODO py:function::

--- Keeps a pointer to the settings created by OBS
script_settings = nil

--- Returns a description string (minimal required function for OBS to recognize a Lua file as a script)
function script_description()
  return [[<center><h2>Generate <code>obslua</code> support files</h2></center>
  
           <p>This script generates two files to support development of Lua scripts in OBS:
           <code>obslua.lua</code> is a Lua source file that reproduces the constants/functions/structures definition
           of the <code>obslua</code> module and <code>obslua.html</code> is the documentation of this definition.
           The scripts requires a copy of the OBS documentation (from GitHub) and one file generated during the 
           compilation of OBS.</p>
           
           <p>The purpose of the generated Lua file is to support IDE features such as auto-completion and contextual
           documentation in e.g. IntelliSense.
           <a href="https://emmylua.github.io">EmmyLua-style</a> annotations are created in the Lua source, supported
           by e.g. <a href="https://marketplace.visualstudio.com/items?itemName=sumneko.lua">sumneko's Language
           Server extension</a> in Visual Studio or Visual Studio Code.
           It should be usable as well with the
           <a href="https://plugins.jetbrains.com/plugin/9768-emmylua">EmmyLua plugin in the IntelliJ IDE</a>.</p>

           <p><bold>WARNING</bold>: This Lua file is useful for development but it cannot
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

  obslua.obs_property_set_long_description(p, "Destination folder for the generated support files")

  p = obslua.obs_properties_add_path(properties, "obsdoc", "OBS docs/sphinx folder",
      obslua.OBS_PATH_DIRECTORY, nil, obslua.obs_data_get_string(script_settings, "obsdoc"))

  obslua.obs_property_set_long_description(p, [[Location of the OBS source documentation folder with rst
  files, typically at obs-studio/docs/sphinx where obs-studio is the root of the repository cloned from GitHub]])

  p = obslua.obs_properties_add_path(properties, "wrapper", "OBS obsluaLUA_wrap.c",
      obslua.OBS_PATH_FILE, "Wrapper file (obsluaLUA_wrap.c)", obslua.obs_data_get_string(script_settings, "obsdoc"))

  obslua.obs_property_set_long_description(p, [[Location of the C file created by SWIG during OBS compilation,
  where a C wrapper function is defined for each function of the OBS API, typically located at
  obs-studio/build/deps/obs-scripting/obslua/CMakeFiles/obslua.dir/obsluaLUA_wrap.c where
  obs-studio/build is the compilation build folder]])

  obslua.obs_properties_add_button(properties, "generate", "Generate support files", generate)

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

  print("------------------- START PARSING OBS DOC -------------------")

  ----------------------------------------------------------- SPHINX DOC PARSING ----------------------------------------
  -- Gathers data from OBS docs/sphinx directory
  

  -- Lists files in doc directory
  local filenames = {}
  local dir = obslua.os_opendir(obslua.obs_data_get_string(script_settings, "obsdoc"))
  local entry
  repeat
    entry = obslua.os_readdir(dir)
    if entry and not entry.directory and obslua.os_get_path_extension(entry.d_name)==".rst" then
      table.insert(filenames, obslua.obs_data_get_string(script_settings, "obsdoc") .. "/" .. entry.d_name)
    end
  until not entry
  obslua.os_closedir(dir)

  -- Iterates on the file names
  local doc_functions = {}
  for _,filename in ipairs(filenames) do

    -- Opens file if possible
    local count = 0
    -- filename = obslua.obs_data_get_string(script_settings, "obsdoc") .. "/" .. filename
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
      local script_function = false
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
          script_function = false
          block = string.gsub(string.sub(line, 15), "^%s*", "")
        -- Py function definition start
        elseif string.find(line, "^.. py:function:: ") then
          state = 1
          block = string.gsub(string.sub(line, 18), "^%s*", "")
          script_function = true
          -- print("INFO: py:function found: >" .. block .. "<")
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
          local pattern = ""
          for func in string.gmatch(block, "([^%(]+%b())") do

            -- Parses script function
            if script_function then
              print("INFO: parsing script function " .. func)
              local fi, _, fn, fa= string.find(func, "([%w_]*)%s*(%b())")
              if fi and fn and fa then
  
                -- Cleans up parenthesis and spaces
                fn = string.gsub(fn, " ", "")
                fa = string.gsub(fa, "^%(", "")
                fa = string.gsub(fa, "%)$", "")
                fa = string.gsub(fa, " ", "")

                -- Parses arguments (no types in script function documentation)
                local arguments = {}
                for arg in string.gmatch(fa, "([^,]+)") do
                  arg = string.gsub(arg, " ", "")
                  table.insert(arguments, {name=arg, c_type="unknown", lua_type="unknown"})
                end

                -- Saves function data
                table.insert(names, fn)
                doc_functions[fn] = {c_type="unknown", lua_type="unknown", arguments=arguments, definition=nil, description={},
                                    filename=filename}
                count = count + 1
              end
              
            else
              -- Detects proper function definition
              local fi, _, ft, fn, fa = string.find(func, "([^%s]*%s*%*?%*?)([%w_]*)(%b())")
              if fi and ft and fn and fa then

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
                    --[[if string.find(arg, "%(") then
                      print("INFO: callback argument in function " .. fn .. " - " .. func)
                      print("  Argument arg=" .. arg .. " name=" .. an .. " type=" .. at)
                    end]]
      
                  end
                end

                -- Saves function data
                table.insert(names, fn)
                doc_functions[fn] = {c_type=ft, lua_type=ft, arguments=arguments, definition=func, description={},
                                     filename=filename}
                --print(as_string(doc_functions[fn]))
                count = count + 1
              else
                print("WARNING: function doc not recognized: " .. func)
              end
            end
          end

          -- Function block processed, goes to description
          state = 3
        end
      end

      print("INFO: found " .. tostring(count) .. " new functions in " .. filename)
    end
  end

----------------------------------------------------------- C WRAPPER -------------------------------------------------

  print("------------------- START PARSING C WRAPPER -------------------")
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
        -- Creates empty function entry if not already existing
        if not doc_functions[function_name] then
          doc_functions[function_name] = {c_type="void", lua_type="void", arguments={}, filename="obsluaLUA_wrap.c",
                                          definition=nil, description=nil}
        end
      end

      -- Parses argument check commands, examples:
      -- if(!lua_isnumber(L,1)) SWIG_fail_arg("obs_key_to_str",1,"obs_key_t");
      -- if(!SWIG_isptrtype(L,2)) SWIG_fail_arg("obs_key_to_str",2,"struct dstr *");
      pattern = '^  if%(!([%w_]+)%(L,(%d)%)%) SWIG_fail_arg%("([^"]+)",%d,"([^"]+)"%);'
      local res, _, convert_func, index, name, c_type = string.find(line, pattern) 
      if res and name and name==function_name and doc_functions[function_name] then

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

        -- Creates argument entry if not already existing
        if not doc_functions[function_name].arguments[index] then
          doc_functions[function_name].arguments[index] = {name="param" .. tostring(index), c_type=c_type, lua_type=lua_type}
        else
          -- Saves lua_type in already existing (documented) argument
          doc_functions[function_name].arguments[index].lua_type = lua_type
        end

        -- Detects C type mismatch between doc and SWIG
        if doc_functions[name].arguments[index].c_type ~= c_type then
          print("WARNING: type mismatch on function " .. name .. " for " .. doc_functions[name].arguments[index].name ..
            "(parameter #" .. tostring(index) .. ")")
          print(" Documentation:" .. doc_functions[name].arguments[index].c_type .. " C wrapper:" .. c_type)
        end
      elseif res and name and name ~= function_name and not string.find(name, "::") then
        print("WARNING name mismatch: " .. name .. " vs " .. function_name)
      end 

      -- Parses argument Lua type check commands, example:
      --     SWIG_fail_ptr("obs_display_add_draw_callback",1,SWIGTYPE_p_obs_display);
      pattern = 'SWIG_fail_ptr%("([%w_]+)",(%d),SWIGTYPE_p_([%w_]+)%);'
      local res, _, name, index, lua_type = string.find(line, pattern) 
      if res and name==function_name and doc_functions[function_name] and
         index and doc_functions[function_name].arguments[tonumber(index)] then
        -- print("----------------------------------Found: " .. name)
        -- Stores detected type if function already defined (always the case except for setters/getters)
        doc_functions[function_name].arguments[tonumber(index)].lua_type = lua_type
      elseif name and name ~= function_name and not string.find(name, "::") then
        print("WARNING name mismatch: " .. name .. " vs " .. function_name)
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




----------------------------------------------------------- SUPPORT FILES ---------------------------------------------
  print("------------------- START CREATING SUPPORT FILES -------------------")

  -- Creates destination files
  lua_file = io.open(obslua.obs_data_get_string(script_settings, "destination") .. "obslua.lua", "w")
  doc_file = io.open(obslua.obs_data_get_string(script_settings, "destination") .. "obslua.html", "w")
  if not lua_file or not doc_file then
    print("ERROR: cannot open file in " .. obslua.obs_data_get_string(script_settings, "destination"))
    return
  end

  -- Header Lua file
  lua_file:write([[
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
local obslua = {}

]])

  -- Header doc file
  doc_file:write([[
<html>
  <header>
    <title>Documentation obslua module</title>
  </header>
  <body>
    <h1 style="text-align:center">obslua module</h1>
]])


  -- Retrieves the table of names of constants/functions/tables and sorts them
  constants = {}
  tables = {}
  functions = {}
  for key, value in pairs(obslua) do
    if type(value) == "function" then
      table.insert(functions, key)
    elseif type(value) == "table" then
        table.insert(tables, key)
    else
      table.insert(constants, key)
    end
  end
  table.sort(constants)
  table.sort(tables)
  table.sort(functions)

  -- Writes one line per constant in file
  print("Writing constants")
  lua_file:write("-- Constants\n")
  doc_file:write("    <h2>Constants</h2>\n    <p>\n")
  for i, key in ipairs(constants) do
    local value = obslua[key]
    local res = as_string(value)
    lua_file:write("obslua." .. key .. " = " .. res .. "\n")
    doc_file:write("      " .. key .. " : " .. res .. "</br>\n")
  end
  doc_file:write("    </p>\n")

  -- Writes functions definition
  local undocumented_functions = {}
  local undefined_functions = {}
  print("Writing functions")
  lua_file:write("\n")
  doc_file:write("    <h2>Functions</h2>\n")
  for i, key in ipairs(functions) do
    local documentation = doc_functions[key]

    -- Non-documented function
    if not documentation then
      lua_file:write("--- " .. key .. " not found in OBS documentation nor C wrapper\n")
      lua_file:write("obslua." .. key .. " = " .. "function() end\n\n")
      table.insert(undefined_functions, key)

    -- Documented function
    else

      -- Arguments string
      local args = ""
      for _,a in ipairs(documentation.arguments) do
        if #args > 0 then args = args .. ", " end
        args = args .. a.name
      end

      -- Header doc file
      doc_file:write("    <hr/><h3>" .. key .. "(" .. args ..")</h3>\n")

      -- Description
      if documentation.description then
        doc_file:write("    <pre>\n")
        for _,s in ipairs(documentation.description) do
          lua_file:write("--- " .. s .. "\n")
          doc_file:write("    " .. s .. "\n")
        end
        doc_file:write("    </pre>\n")
      else
        lua_file:write("--- Not mentioned in OBS documentation\n---\n")
        doc_file:write("    <p>Not mentioned in OBS documentation</p>\n")
        table.insert(undocumented_functions, key)
      end

      -- C definition Lua file
      if documentation.definition then
        lua_file:write("--- C definition: `" .. documentation.definition .. "`\n")
      else
        lua_file:write("--- C definition: Not available\n")
      end

      -- Parameters
      for _,a in ipairs(documentation.arguments) do
        lua_file:write("--- @param " .. a.name .. " " .. a.lua_type .. "\n")
        doc_file:write("    <p>" .. a.name .. " : " .. a.lua_type .. "</p>\n")
      end

      -- Return type
      if documentation.c_type ~= "void" then
        lua_file:write("--- @return " .. documentation.lua_type .. "\n")
        doc_file:write("    <p>Return : " .. documentation.lua_type .. "</p>\n")
      end

      -- C definition doc file
      if documentation.definition then
        doc_file:write("    <p><pre>" .. documentation.definition .. "</pre></p>\n")
      end

      -- Function definition Lua file
      lua_file:write("function obslua." .. key .. "(" .. args ..") end\n\n")

    end
  end

  -- Closes files
  print("Closing files")
  lua_file:write("return obslua\n")
  lua_file:close()
  doc_file:write("  </body>\n</html>\n")
  doc_file:close()

  -- Statistics
  print("-------------------")
  print("Total number of functions in obslua module: " .. tostring(#functions))
  print("Undocumented functions: " .. tostring(#undocumented_functions) .. " - " .. as_string(undocumented_functions))
  print("Functions not in OBS doc and not in C wrapper: " .. tostring(#undefined_functions) .. " - " .. as_string(undefined_functions))
  print("-------------------")

end


--[[
print("---------type(obslua.gs_image_file): " .. type(obslua.gs_image_file))
print("---------swig_type(obslua.gs_image_file): " .. swig_type(obslua.gs_image_file))
print("---------type(obslua.gs_image_file()): " .. type(obslua.gs_image_file()))
print("---------swig_type(obslua.gs_image_file()): " .. swig_type(obslua.gs_image_file()))
print("---------swig_type(swig_type(obslua.obs_data_item_get_array)): " .. swig_type(obslua.obs_data_item_get_array))
print("---------type(swig_type(obslua.obs_data_item_get_array)): " .. type(obslua.obs_data_item_get_array))
]]

--[[local a = {}
function a.a() return nil end
print("---------a(): " .. tostring(a()))]]


  --[[ All globals as comment
  local keys = {}
  for key in pairs(_G) do table.insert(keys, key) end
  table.sort(keys)

  for i, key in ipairs(keys) do
    if key ~= "_G" and key ~= "package" and key ~= "obslua" and key ~= "script_path" then
      local value = _G[key]
      local res = as_string(value, 1)
      lua_file:write("-- Global: " .. key .. " = " .. res .. "\n")
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
