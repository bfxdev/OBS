--------------------------------------------------------------------------------
--- Retrieves info on obslua module and other global variables - bfxdev 2020 ---
--------------------------------------------------------------------------------

-- Once the file is generated, the following line setups IntelliSense for auto-completion
-- if _G['obslua']==nil then dofile('obslua-globals.lua') end

--- Name of the file to be created
DESTINATION_FILENAME = "obslua-globals.lua"

--- Keeps a pointer to the settings created by OBS
script_settings = nil

--- Returns a description string (minimal required function for OBS to recognize a Lua file as a script)
function script_description()
  return [[<p>Creates a Lua file that can be used to reproduce the definition of the global variables available
           in the Lua scripting environment in OBS, including the functions of the <code>obslua</code> module.</p>
           <p>Follow the instructions at the beginning of the generated file to see how to use it.
           <a href="https://emmylua.github.io">EmmyLua-style</a> annotations are created in the Lua source, supported
           by e.g. <a href="https://marketplace.visualstudio.com/items?itemName=sumneko.lua">sumneko's Language
           Server extension</a> in Visual Studio or Visual Studio Code.</p></p>
           <p>Two parameters can be set:</p>
           <ul><li><p><strong>Destination folder</strong>: location where the Lua
           include file will be written.</p></li>
           <li><p><strong>OBS docs folder</strong>: location of <code>rst</code>
           files, typically at <code>obs-studio/docs/sphinx</code> where <code>obs-studio</code> is the
           root of the GitHub cloned repository.</p></li></ul>
           <p><bold>WARNING</bold>: This file is useful for auto-completion with e.g. IntelliSense, but it cannot
           be used otherwise, i.e. it cannot be included in an OBS script and provides no functionality if 
           included in a Lua script.</p>]]
end

--- Sets default global variables `destination` and `obsdoc`
function script_defaults(settings)
  obslua.obs_data_set_default_string(settings, "destination", script_path())
  obslua.obs_data_set_default_string(settings, "obsdoc", "")
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

  obslua.obs_properties_add_path(properties, "destination", "Destination folder",
                                 obslua.OBS_PATH_DIRECTORY, nil, obslua.obs_data_get_string(script_settings, "destination"))

  obslua.obs_properties_add_path(properties, "obsdoc", "OBS docs folder",
                                 obslua.OBS_PATH_DIRECTORY, nil, obslua.obs_data_get_string(script_settings, "obsdoc"))

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
  print("Starting generation of " .. DESTINATION_FILENAME)

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
      print("Skipping file " .. filename)
    else

      -- Reads functions/arguments and description from the doc file
      print("Parsing " .. filename)

      -- The format of a documented function is as following:
      --   <several empty lines>
      --   .. function :: <definition of one or two functions possibly on several lines>
      --   <at least one empty line>
      --   <description text over several line, empty lines for paragraph end>
      --   ---------------------
      -- A state machine is defined:
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

            -- Detects function definition and cleans up possible prefixes and spaces
            local fi, _, ft, fn, fa = string.find(func, "([^%s]* %*?%*?)([%w_]*)%((.*)%)")
            if ft and fn and fa then
              ft = string.gsub(ft, "^%s*const ", "")
              ft = string.gsub(ft, "^%s*enum ", "")
              ft = string.gsub(ft, "^%s*struct ", "")
              ft = string.gsub(ft, " ", "")
              fn = string.gsub(fn, " ", "")

              -- Parses args, i.e. splits with "," separator
              local arguments = {}
              for arg in string.gmatch(fa, "([^,]+)") do

                -- Cleans up possible prefixes and spaces
                arg = string.gsub(arg, "^%s*const ", "")
                arg = string.gsub(arg, "^%s*enum ", "")
                arg = string.gsub(arg, "^%s*struct ", "")

                -- Detects well-formed argument
                local ai, _, at, an = string.find(arg, "([%s%w_%*]+ %*?%*?)([^%s%*]+)")
                if ai then
                  at = string.gsub(at, " ", "")
                  table.insert(arguments, {name=an, data_type=at})
                end
              end

              -- Saves function data
              table.insert(names, fn)
              doc_functions[fn] = {data_type=ft, arguments=arguments, definition=func, description={}}
              --print(as_string(doc_functions[fn]))
              count = count + 1
            end
          end
          state = 3
        end
      end

      print("New functions found: " .. tostring(count))
    end
  end

  -- Creates file
  file = io.open(obslua.obs_data_get_string(script_settings, "destination") .. DESTINATION_FILENAME, "w")
  if not file then
    print("ERROR: cannot open file " .. obslua.obs_data_get_string(script_settings, "destination") .. DESTINATION_FILENAME)
    return
  end

  -- Header
  print("Writing header")
  file:write([[
-- Definition of globals to mimic the Lua scripting environment in OBS - bfxdev 2020

-- Use it for IntelliSense e.g. in Visual Studio or Visual Studio Code with sumneko's Lua Language
-- Server extension, see https://marketplace.visualstudio.com/items?itemName=sumneko.lua
-- It relies on EmmyLua-style annotations, see https://emmylua.github.io
-- Just store the file in the same folder as your source file.

--- Version number in OBS
_VERSION = "Lua 5.1"

--- Returns Kb of dynamic memory in use.
--- This function is deprecated in Lua 5.1. Use collectgarbage ("count") instead.
--- @return number
function gcinfo() end

--- Returns the current environment used by the nominated function f.
--- f can be a function or a number representing the stack level, where 1 is the currently running function, 2 is its parent and so on.
--- The environment is where "global" variables are stored.
function getfenv(f) end

--- Parses the string and returns the compiled chunk as a function. Does not execute it.
--- If the string cannot be parsed returns nil plus an error message.
--- The optional debugname is used in debug error messages.
function loadstring(str, debugname) end

--- Creates a module. This is intended for use with external "package" files, however it can be used internally as shown in the example below. The module effectively has its own global variable space (because module does a setfenv) so that any functions or variables used in the module are local to the module name (for example, foo.add in the example below).
--- If there is a table in package.loaded[name], this table is the module. Thus, if the module has already been requested (by a require statement) another new table is not created.
--- Otherwise, if there is a global table t with the given name, this table is the module.
--- Otherwise creates a new table t and sets it as the value of the global name and the value of package.loaded[name].
--- This function also initializes t._NAME with the given name, t._M with the module (t itself), and t._PACKAGE with the package name (the full module name minus last component).
--- Finally, module sets t as the new environment of the current function and the new value of package.loaded[name], so that require returns t.
--- The example below shows the creation of the module "foo". In practice you would probably put the contents of the "test" function into a separate file, and then: require "test"
--- The nice thing about this approach is that nothing inside the module will "pollute" the global namespace, excepting the module name itself (foo in this case). Internally inside the module functions can call each other without having to use the package name (eg. add could call subtract without using foo.subtract).
--- You can make a "private" function inside the "foo" package by simply putting "local" in front of the function name.
function module(name, ···) end


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

--- Sets the current environment to be used by f, which can be a function, userdata, thread or stack level. Level 1 is the current function. Level 0 is the global environment of the current thread. The "env" argument is a table, which effectively becomes the "root" for the environment.
--- The return value is the function whose environment was changed, unless the argument was 0.
function setfenv(f, env) end

--- SWIG function - Not documented
function swig_equals() end

--- SWIG function that returns as a string the type of object pointed to by the argument (assuming it was a SWIG wrapped object)
function swig_type(obj) end

--- Returns the elements from the given table. This function is equivalent to
---
--- return list[i], list[i+1], ···, list[j]
---
--- except that the above code can be written only for a fixed number of elements.
--- By default, i is 1 and j is the length of the list, as defined by the length operator.
function unpack (list, i, j) end

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
      file:write("--- " .. key .. " not documented\n")
      file:write("obslua." .. key .. " = " .. "function() end\n\n")

    -- Documented function
    else

      -- Parsable comments
      for _,s in ipairs(documentation.description) do
        file:write("--- " .. s .. "\n")
      end
      file:write("--- C definition: " .. documentation.definition .. "\n")
      for _,a in ipairs(documentation.arguments) do
        file:write("--- @param " .. a.name .. " " .. a.data_type .. "\n")
      end
      if documentation.data_type ~= "void" then
        file:write("--- @return " .. documentation.data_type .. "\n")
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




--[[ Pre-imported packages:
bit (unknown)
coroutine
debug
io
jit (unknown)
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
getfenv (unknown)
getmetatable
ipairs
load
loadstring (unknown)
module (unknown)
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
setfenv (unknown)
setmetatable
swig_equals (unknown)
swig_type (unknown)
tonumber
tostring
type
unpack (unknown)
xpcall
]]--
