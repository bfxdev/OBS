--------------------------------------------------------------------------------
--- Retrieves info on obslua module and other global variables - bfxdev 2020 ---
--------------------------------------------------------------------------------

-- Once the file is generated, the following line setups IntelliSense for auto-completion
if _G['obslua']==nil then dofile('obslua-globals.lua') end

--- Name of the file to be created
DESTINATION_FILENAME = "obslua-globals.lua"

--- Keeps a pointer to the settings created by OBS
script_settings = nil

--- Returns a description string (minimal required function for OBS to recognize a Lua file as a script)
function script_description()
  return [[<p>Creates a Lua file that can be included to reproduce the
           global variables available in the Lua scripting environment in OBS, including the functions of the
           <code>obslua</code> module.</p>
           <p><bold>WARNING</bold>: This file is useful for auto-completion with e.g. IntelliSense, but it cannot
           be used otherwise, i.e. it cannot be included in an OBS script and provides no functionality if 
           included in a Lua script.</p>
           <p>Follow the instructions at the beginning of the generated file to see how to include it</p>
           <p>Parameters:
           <ul>
             <li><strong>Destination folder</strong>: where to store the Lua include file</li>
             <li><strong>OBS docs folder</strong>: where to find <code>rst</code> files, typically at
                 <code>obs-studio/docs/sphinx</code></li> where obs-studio is the root of the GitHub cloned repository
             <li><strong>C wrapper</strong>: file created during the compilation of obs-studio, typically at
                 <code>obs-studio/build/deps/obs-scripting/obslua/CMakeFiles/obslua.dir/obsluaLUA_wrap.c</code></li>
           </ul></p>]]
end

--- Sets default global variables `destination`, `obsluawrap` and `obsdoc`
function script_defaults(settings)
  obslua.obs_data_set_default_string(settings, "destination", script_path())
  obslua.obs_data_set_default_string(settings, "obsluawrap", "")
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

  obslua.obs_properties_add_path(properties, "obsluawrap", "C wrapper",
                                 obslua.OBS_PATH_FILE, "C wrapper file (obsluaLUA_wrap.c)", nil)

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
  local filenames = {"backend-design.rst", "frontends.rst", "graphics.rst", "index.rst", "plugins.rst",
                     "reference-core-objects.rst", "reference-core.rst", "reference-encoders.rst",
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

      -- Reads functions and arguments from the doc file
      print("Parsing " .. filename)
      local name ="dummy"
      for line in file:lines() do

        -- Detects function definition
        local fi, _, ft, fn, fa = string.find(line, "^.. function:: ([^ ]* %*?)(.*)%((.*)%)")
        if fi then

          -- Cleans up possible prefixes ans spaces
          ft = string.gsub(ft, "^%s*const ", "")
          ft = string.gsub(ft, "^%s*struct ", "")
          ft = string.gsub(ft, " ", "")
          fn = string.gsub(fn, " ", "")

          -- Saves function name for later use
          name = fn

          -- Parses args, i.e. splits with "," separator
          local arguments = {}
          for arg in string.gmatch(fa, "([^,]+)") do

              -- Cleans up possible prefixes ans spaces
            arg = string.gsub(arg, "^%s*const ", "")
            arg = string.gsub(arg, "^%s*struct ", "")

            -- Detects well-formed argument
            local ai, _, at, an = string.find(arg, "^([^ ]* %*?)(.*)")
            if ai then
              at = string.gsub(at, " ", "")
              table.insert(arguments, {name=an, data_type=at})
            end

          end

          -- Saves function data
          doc_functions[name] = {data_type=ft, arguments=arguments, line=line, description={}}
          count = count + 1
        else

          -- Adds line to the description
          if doc_functions[name] and not string.find(line, "^%s$") then
            table.insert(doc_functions[name].description, line)
          end
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
  file:write("-- Definition of globals to reproduce the Lua scripting environment in OBS - bfxdev 2020\n\n")
  file:write("-- Use it for IntelliSense with this line at the beginning of your script (without comment):\n")
  file:write("--    if _G['obslua']==nil then dofile('obslua-globals.lua') end\n\n")
  file:write("-- Main obslua module\nobslua = {}\n\n")

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
  file:write("-- Constants\n")
  for i, key in ipairs(constants) do
    local value = obslua[key]
    local res = as_string(value)
    file:write("obslua." .. key .. " = " .. res .. "\n")
  end

  -- Writes functions definition
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
      for _,a in ipairs(documentation.arguments) do
        file:write("--- @param " .. a.name .. " " .. a.data_type .. "\n")
      end
      file:write("--- @return " .. documentation.data_type .. "\n")

      -- Function definition
      file:write("obslua." .. key .. " = " .. "function() end \n\n")

    end
  end

  -- Closes file
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
