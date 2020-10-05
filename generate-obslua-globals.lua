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
             <li><strong>C wrapper</strong>: file created during the compilation, typically at
                 <code>obs-studio/build/deps/obs-scripting/obslua/CMakeFiles/obslua.dir/obsluaLUA_wrap.c</code></li>
             <li><strong>OBS docs folder</strong>: where to find `rst`files, typically at
                 <code>obs-studio/docs/sphinx</code></li>
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

  print("script_settings:" .. tostring(script_settings))

  local properties = obslua.obs_properties_create()

  obslua.obs_properties_add_path(properties, "destination", "Destination folder",
                                 obslua.OBS_PATH_DIRECTORY, nil, nil)

  obslua.obs_properties_add_path(properties, "obsluawrap", "C wrapper",
                                 obslua.OBS_PATH_FILE, "C wrapper file (obsluaLUA_wrap.c)", nil)

  obslua.obs_properties_add_path(properties, "obsdoc", "OBS docs folder",
                                 obslua.OBS_PATH_DIRECTORY, nil, nil)

  obslua.obs_properties_add_button(properties, "generate", "Generate " .. DESTINATION_FILENAME, generate)

  return properties
end


-- Recursive transformation of any object to string (with max depth)
local MAX_PARSE_DEPTH = 10
local function as_string(content, depth)

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
    res = "function() end -- " .. as_string(debug.getinfo(content), MAX_PARSE_DEPTH) -- removed not useful

  -- Type string
  elseif type(content) == "string" then

    -- Escapes backslash characters and adds quotes
    res = string.gsub(content, "\\", "\\\\")
    if depth > 0 then res = "\"" .. res .. "\"" end

  -- Everything else
  else
      res =  tostring(content)
  end

	return res
end

--- Main function of the script: generate the Lua file
function generate()

  -- Creates file and empties it
  local file = io.open(script_path() .. "obslua-globals.lua", "w")

  -- Header
  file:write("-- Definition of globals to reproduce the Lua scripting environment in OBS - bfxdev 2020\n\n")
  file:write("-- Use it for IntelliSense with this line at the beginning of your script (without comment):\n")
  file:write("--    if _G['obslua']==nil then dofile('obslua-globals.lua') end\n\n")
  file:write("-- Main obslua module\nobslua = {}\n\n")

  -- All globals as comment
  local keys = {}
  for key in pairs(_G) do table.insert(keys, key) end
  table.sort(keys)

  for i, key in ipairs(keys) do
    if key ~= "_G" and key ~= "package" and key ~= "obslua" and key ~= "script_path" then
      local value = _G[key]
      local res = as_string(value, 1)
      file:write("-- Global: " .. key .. " = " .. res .. "\n")
    end
  end

  -- Retrieves the table of names of variables/functions/etc and sorts them
  keys = {}
  for key in pairs(obslua) do
    table.insert(keys, key)
  end
  table.sort(keys)

  -- Iterates on all obslua members
  for i, key in ipairs(keys) do
    local value = obslua[key]
    local res = as_string(value, 1)
    file:write("obslua." .. key .. " = " .. res .. "\n")
  end

  -- Closes
  file:close(file)

end

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
