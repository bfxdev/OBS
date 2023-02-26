-------------------------------------------------=--------------------------------------------------
--                                                                                                --
--                           Lua script template for shader-based filters                         --
--                                                                                                --
--                                     v1.0 - bfxdev - 2023                                       --
--                                                                                                --
--  Recommendations:                                                                              --
--  - Setup the script in OBS to try it (the video effect is not supposed to be very useful)      --
--  - Look for TODO tags in the comments and "template" words, then adapt the code to your needs  --
--  - After any modification the best is to restart OBS. Some modifications may be taken into     --
--    account by the Refresh button in the Scripts window (not for changes in the effect file)    --
--  - Look at the current OBS log in case of misbehavior after a modification. Sadly, in some     --
--    cases the effect file cannot be compiled and no log line is generated, what makes obviously --
--    debugging difficult. The line numbers given for errors in the effect file are not reliable. --
--  - Check the reference OBS Documentation at https://obsproject.com/docs for Scripting, Effects --
--    Sources, Data Settings, Properties, etc                                                     --
--                                                                                                --
-------------------------------------------------=--------------------------------------------------

-- Module obslua renamed by convention for commonality with Python code
obs = obslua


--------------------------------- GENERAL INFORMATION ON THE FILTER --------------------------------

-- Returns the description to be displayed in the Scripts window
-- See https://obsproject.com/docs/scripting.html#script_description
function script_description()

  -- TODO: General script description as plain text or with Qt-powered HTML formatting
  -- See https://doc.qt.io/qt-5/richtext-html-subset.html
  local description = [[<center><h2> Lua Script Template for Shader-Based Filter </h2></center><br/>
                        <p>This example script adds a new filter named "Template Lua Filter" with
                        some example properties to be adapted to your needs</p>]]

  return description
end

-- Called on script startup
-- See https://obsproject.com/docs/scripting.html#script_load
function script_load(settings)
  obs.obs_register_source(source_info)
end

-- Definition of the global variable containing the source_info structure
-- See https://obsproject.com/docs/reference-sources.html
source_info = {}
source_info.id = 'filter-template'          -- TODO: Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- Either INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_name
source_info.get_name = function()
  return "Template Lua Filter"                  -- TODO: Display name of your filter
end


-------------------------- CREATE: SOURCE CREATION AND EFFECT COMPILATION --------------------------

-- Creates the implementation data for the source, including shader compilation
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.create
source_info.create = function(settings, source)

  -- Initializes the custom data table
  local data = {}
  data.this_source = source   -- Keeps a reference to the present filter as a source object
  data.width = 1              -- Dummy width value during the initialization phase
  data.height = 1             -- Dummy height value during the initialization phase

  -- TODO: If new variables are defined in the custom `data` table, initialize them here with a
  --       default value. Such variables may be necessary to better manage the properties

  -- Compiles the effect from a .effect file in the same folder as the Lua script
  -- See https://obsproject.com/docs/graphics.html
  -- TODO: Change the name of the effect file according to your effect, store it in the same folder
  obs.obs_enter_graphics()
  data.effect_compilation_failed = false
  local effect_file_path = script_path() .. 'filter-template.effect.hlsl'
  data.effect = obs.gs_effect_create_from_file(effect_file_path, nil)

  -- TODO: Optional: To distribute a single Lua file once the shader is working, copy the
  --       content of the .effect file into a global string variable called EFFECT, then
  --       compiled using the following line (to be uncommented):
  -- data.effect = obs.gs_effect_create(EFFECT, 'lua_embedded_effect', nil)

  -- Replaces the effect with an annoying solid PINK color if the compilation failed
  -- This part should not be modified, it shows an example of an effect file embedded in Lua
  if data.effect == nil then
    data.effect_compilation_failed = true
    print("Effect compilation failed")     -- Logs the error in scripts log and OBS log
    local FALLBACK_EFFECT=[[uniform float4x4 ViewProj; uniform texture2d image;
      struct ShaderData { float4 pos : POSITION; float2 uv  : TEXCOORD0; };
      ShaderData vertex_shader(ShaderData vtx)
      { vtx.pos = mul(float4(vtx.pos.xyz, 1.0), ViewProj); return vtx; }
      float4 pixel_shader(ShaderData pix) : TARGET
      { return float4(1.0,0.0, 0.5, 1.0); }
      technique Draw {
        pass {
          vertex_shader = vertex_shader(vtx);
          pixel_shader  = pixel_shader(pix);
        }
      } ]]
    data.effect = obs.gs_effect_create(FALLBACK_EFFECT, 'fallback_effect', nil)

    -- Deactivates filter if the fallback cannot be compiled as well (should not happen)
    if data.effect == nil then
      print("Fallback effect compilation failed")
      source_info.destroy(data)
      return nil
    end
  end

  obs.obs_leave_graphics()

  -- Retrieves the shader uniform variables after successful shader compilation
  -- This must be done before the first rendering is performed
  if not data.effect_compilation_failed then
    data.params = {}
    data.params.target_resolution = obs.gs_effect_get_param_by_name(data.effect,"target_resolution")
    data.params.source_resolution = obs.gs_effect_get_param_by_name(data.effect,"source_resolution")
    data.params.time = obs.gs_effect_get_param_by_name(data.effect, "time")

    -- TODO: Remove the examples below and add your own uniform variables as defined in the effect
    data.params.template_bool    = obs.gs_effect_get_param_by_name(data.effect, "template_bool")
    data.params.template_int     = obs.gs_effect_get_param_by_name(data.effect, "template_int")
    data.params.template_float   = obs.gs_effect_get_param_by_name(data.effect, "template_float")
    data.params.template_color   = obs.gs_effect_get_param_by_name(data.effect, "template_color")
    data.params.template_vec4    = obs.gs_effect_get_param_by_name(data.effect, "template_vec4")
    data.params.template_matrix4 = obs.gs_effect_get_param_by_name(data.effect, "template_matrix4")
    data.params.template_texture = obs.gs_effect_get_param_by_name(data.effect, "template_texture")
    data.params.template_texture_size = obs.gs_effect_get_param_by_name(data.effect,
                                                                        "template_texture_size")
  end

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)

  return data
end

-- Destroys and releases resources linked to the custom data and the effect
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.destroy
source_info.destroy = function(data)
  if data.effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(data.effect)
    data.effect = nil
    obs.obs_leave_graphics()
  end
end


------------------------ GET_DEFAULTS: SET DEFAULTS VALUES OF DATA SETTINGS ------------------------

-- Sets the default settings for this source
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_defaults
-- Data settings are persistent values managed by OBS for general-purpose use in the OBS GUI, in
-- plugins or scripts (using HLSL effects or not). Data settings are then typically related to the
-- values of the uniform variables but do not need to be defined exactly in the same way. The data
-- types are anyway not well aligned between data settings and uniform variables.
-- By convention and to ease development, data settings (in Lua) and uniform variables (in the
-- effect) have often the same name or at least a similar name.
-- See https://obsproject.com/docs/reference-settings.html
-- Setting default values will create the data settings associated to this instance of the filter.
-- Values set as default in this function may or may not be related to the default values set on
-- the uniform variables in the effect.
source_info.get_defaults = function(settings)

  -- TODO: Remove the examples below and set reasonable default values for your own data settings

  -- Data types with no particular conversion
  obs.obs_data_set_default_bool(settings,   "template_bool", false)        -- bool   <-> bool
  obs.obs_data_set_default_int(settings,    "template_int", 1)            -- int    <-> int
  obs.obs_data_set_default_double(settings, "template_float", 1.0)        -- float  <-> double 

  -- Colors stored as 32-bits ints - /!\ Integer format is ABGR (reversed RBGA)
  obs.obs_data_set_default_int(settings,    "template_color", 0xffff0000) -- color  <-> int

  -- Vectors and matrices must be split over several variables (data settings arrays not used here)
  obs.obs_data_set_default_double(settings, "template_vec4_x", 1.0)       -- vec4.x <-> double
  obs.obs_data_set_default_double(settings, "template_vec4_y", 2.0)       -- vec4.y <-> double
  obs.obs_data_set_default_double(settings, "template_vec4_z", 0.5)       -- vec4.z <-> double
  obs.obs_data_set_default_double(settings, "template_vec4_w", 4.0)       -- vec4.w <-> double

  -- For a matrix4, defaults can be initialized from a list in a more compact way
  -- Reminder: in Lua, arrays start with index 1 when initialized from a simple list
  local default_values = {-0.5, 0.033, -0.367, 0.167, 0.3, -0.233, 0.433, -0.1,
                          -0.3, 0.233, -0.433, 0.1, 0.5, -0.033, 0.367, -0.167}
  for i=0,15 do
    obs.obs_data_set_default_double(settings, "template_matrix4_" .. i, default_values[i+1])
  end

  -- For user-selectable textures, the path of the file can be stored as a string (start empty)
  obs.obs_data_set_default_string(settings, "template_texture_path", "")

  -- Additional parameters to manage default activation of GUI property groups
  obs.obs_data_set_default_bool(settings, "vectors_group", false)
  obs.obs_data_set_default_bool(settings, "matrix_group", false)

end


---------------------- GET_PROPERTIES: GUI WIDGETS DISPLAYED ON FILTERS WINDOW ---------------------

-- Callback to set the visibility of matrix properties
-- See https://obsproject.com/docs/reference-properties.html#c.obs_property_set_modified_callback
function set_matrix_visibility(props, property, settings)

  local checked = obs.obs_data_get_bool(settings, "matrix_group")

  for i=0,15 do
    local prop = obs.obs_properties_get(props, "template_matrix4_" .. i)
    obs.obs_property_set_visible(prop, checked)
  end

  -- Returns true to trigger a refresh of the properties window
  return true
end

-- Creates a set of properties to be displayed in the filter GUI
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_properties
-- For each property, the name of the related data setting has to be provided and will be modified
-- automatically when changed by the user. OBS supports many widgets to set values.
-- See https://obsproject.com/docs/reference-properties.html
source_info.get_properties = function(data)

  -- Creates the data structure to be returned
  local props = obs.obs_properties_create()

  -- TODO: Remove the examples below and define your own properties for your data settings

  -- Some non-editable HTML text to make the user comfortable (no data setting needed hence "dummy")
  local description = [[<center><h3>GUI generated in <code>get_properties</code></h3></center>
  The aim of this <i>template script</i> is to showcase the features of <b>Lua scripting</b> to
  write shader-based filters, as well as to provide a basis script to start with. There is no
  particular logic for the properties below, it just demonstrates OBS graphical features.<br><br>
  Make a copy of the script and effect files, look for the <code>TODO</code> tags in the code to
  know which parts can be customized to your own needs.]]
  obs.obs_properties_add_text(props, "dummy", description, obs.OBS_TEXT_INFO)

  -- Classical widgets for booleans (check box) and integer (drop down list)
  obs.obs_properties_add_bool(props, "template_bool", "Template Boolean")
  lprop = obs.obs_properties_add_list(props, "template_int", "Template Integer",
                                      obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_INT)
  obs.obs_property_list_add_int(lprop, "First option (data setting set to 1)", 1)
  obs.obs_property_list_add_int(lprop, "Second option (data setting set to 2)", 2)

  -- Texture file path
  obs.obs_properties_add_path(props, "template_texture_path", "Template Texture", obs.OBS_PATH_FILE,
                              "Bitmap picture (*.jpg *.png)", nil)

  -- As there are often numerous properties, they can be grouped by topic to ease understanding
  local group1 = obs.obs_properties_create()
  obs.obs_properties_add_group(props, "first_group", "Example Non-Checkable Group",
                               obs.OBS_GROUP_NORMAL, group1)

  -- Classical widgets for float (slider) and color (color picker) in a group
  obs.obs_properties_add_float_slider(group1, "template_float", "Template Float", 0.1, 10.0, 0.1)
  obs.obs_properties_add_color_alpha(group1, "template_color", "Template Color ABGR")

  -- Vectors/matrices must be splitted into their single components (here with sliders)
  -- Groups are particularly helpful for vector components.
  -- The group is CHECKABLE, i.e. edition can be deactivated.
  local group2 = obs.obs_properties_create()
  obs.obs_properties_add_group(props, "vectors_group", "Vectors Checkable Group",
                               obs.OBS_GROUP_CHECKABLE, group2)
  obs.obs_properties_add_float_slider(group2, "template_vec4_x", "Template Vec4 X", 0.0, 5.0, 0.1)
  obs.obs_properties_add_float_slider(group2, "template_vec4_y", "Template Vec4 Y", 0.0, 6.0, 2.0)
  obs.obs_properties_add_float_slider(group2, "template_vec4_z", "Template Vec4 Z", 0.1, 0.5, 0.01)
  obs.obs_properties_add_float_slider(group2, "template_vec4_w", "Template Vec4 W", 0.0, 9.0, 1.0)

  -- Matrix values (text area with arrows) in a foldable group, i.e.  visibility set via callback
  -- See https://obsproject.com/docs/reference-properties.html#c.obs_property_set_modified_callback
  local group3 = obs.obs_properties_create()
  local gprop = obs.obs_properties_add_group(props, "matrix_group", "Matrix Foldable Group",
                                             obs.OBS_GROUP_CHECKABLE, group3)
  for i=0,15 do
    obs.obs_properties_add_float(group3, "template_matrix4_" .. i, "Template Matrix #" .. i,
                                 -1.0, 1.0, 0.1)
  end
  obs.obs_property_set_modified_callback(gprop, set_matrix_visibility)

  return props
end


-------------- UPDATE: RETRIEVAL OF DATA SETTINGS VALUES UPON MODIFICATION BY THE USER -------------

-- Updates the internal data for this source upon settings change
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.update
-- This function retrieves the values from the data settings, as modified by the GUI properties, in
-- order to prepare data for the rendering (this update is done upon property change, not for each
-- frame for performance reasons). Updated values are stored in the `data` structure in
-- variables with same or similar names.
-- Note that the function may be called very often if a slider is used, hence it is necessary to
-- pay attention to the performance of updating the parameters, e.g. if file access is needed, as it
-- can slow down the GUI in a noticeable way. Potentially long update operations should be
-- done only if the related data settings was changed, not for every call of the update function.
source_info.update = function(data, settings)

  -- TODO: Remove the examples below and write code to retrieve data settings values into `data`

  -- Data types with no particular conversion
  data.template_bool = obs.obs_data_get_bool(settings, "template_bool")
  data.template_int = obs.obs_data_get_int(settings, "template_int")
  data.template_float = obs.obs_data_get_double(settings, "template_float")

  -- Color picker conversion from integer ABGR to vec4 RGBA (use gs_effect_set_color alternatively)
  local c = obs.obs_data_get_int(settings, "template_color")
  data.template_color = obs.vec4()
  obs.vec4_set(data.template_color, (c%256)/255, (math.floor(c/256)%256)/255,
                                    (math.floor(c/256^2)%256)/255, (math.floor(c/256^3)%256)/255)

  -- Vector (similar code for vec2 and vec3)
  data.template_vec4 = obs.vec4()
  obs.vec4_set(data.template_vec4, obs.obs_data_get_double(settings, "template_vec4_x"),
                                   obs.obs_data_get_double(settings, "template_vec4_y"),
                                   obs.obs_data_get_double(settings, "template_vec4_z"),
                                   obs.obs_data_get_double(settings, "template_vec4_w"))

  -- Matrix conversion using 4 vector components (no simpler way identified so far in Lua)
  -- First retrieve the values in an array (we can use index 0 as the array was not initialized)
  local values = {}
  for i=0,15 do
    values[i] = obs.obs_data_get_double(settings, "template_matrix4_" .. i)
  end
  -- Then set the matrix through 4 vec4 /!\ 3rd component is "t" not "w" (wrongly documented)
  -- See https://obsproject.com/docs/reference-libobs-graphics-matrix4.html#c.matrix4
  data.template_matrix4 = obs.matrix4()
  local component = obs.vec4()
  obs.vec4_set(component, values[0],  values[1],  values[2],  values[3])
  obs.vec4_copy(data.template_matrix4.x, component)
  obs.vec4_set(component, values[4],  values[5],  values[6],  values[7])
  obs.vec4_copy(data.template_matrix4.y, component)
  obs.vec4_set(component, values[8],  values[9],  values[10], values[11])
  obs.vec4_copy(data.template_matrix4.z, component)
  obs.vec4_set(component, values[12], values[13], values[14], values[15])
  obs.vec4_copy(data.template_matrix4.t, component)

  -- Many steps are necessary to read a picture file, partly to be done in the graphics thread
  -- See https://obsproject.com/docs/reference-libobs-graphics-image-file.html
  -- First checks if the file needs to be read, i.e. if the file path has changed
  local path = obs.obs_data_get_string(settings, "template_texture_path")
  if data.template_texture_path ~= path then
    data.template_texture_path = path
    -- Checks if another image was previously loaded to free it
    if data.template_texture ~= nil then
      obs.gs_image_file_free(data.template_texture)
    end
    -- Reads the new picture from storage and initializes the texture in the GPU
    local image_file = obs.gs_image_file()
    obs.gs_image_file_init(image_file, path)
    if image_file.loaded then
      obs.obs_enter_graphics()
      obs.gs_image_file_init_texture(image_file)
      obs.obs_leave_graphics()
      data.template_texture = image_file
    else
      -- Logs the error if the file cannot be read, except if it was the default value (empty)
      if string.len(path) > 4 then
        print("ERROR: Cannot load image file " .. path)
      end
      obs.gs_image_file_free(image_file)
      data.template_texture = nil
    end
  end
  -- Finally retrieves the size of the image if properly loaded, otherwise set size to (-1,-1)
  data.template_texture_size = obs.vec2()
  if data.template_texture ~= nil then
    obs.vec2_set(data.template_texture_size, data.template_texture.cx, data.template_texture.cy)
  else
    obs.vec2_set(data.template_texture_size, -1.0, -1.0)
  end

end


------------------------------ VIDEO_RENDER: FILTER OUTPUT RENDERING -------------------------------

-- Called when rendering the source with the graphics subsystem
-- /!\ Do not log or print from this function as it is called at every frame
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.video_render
source_info.video_render = function(data)

  -- Determines the target source resolution, taking potential re-scaling into account in the filter
  -- chain. Values of width and height need to be kept to be returned by get_width and get_height.
  local target = obs.obs_filter_get_target(data.this_source)
  data.width = obs.obs_source_get_base_width(target)
  data.height = obs.obs_source_get_base_height(target)

  -- Begins the rendering
  local technique = "Draw"
  obs.obs_source_process_filter_begin(data.this_source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)

  -- Sets shader data for the draw if the shader compilation was successful
  if not data.effect_compilation_failed then

    -- Sets pre-defined uniform variables in the shader
    local target_resolution = obs.vec2()
    obs.vec2_set(target_resolution, data.width, data.height)
    obs.gs_effect_set_vec2(data.params.target_resolution, target_resolution)
    local parent = obs.obs_filter_get_parent(data.this_source)
    local source_resolution = obs.vec2()
    obs.vec2_set(source_resolution, obs.obs_source_get_base_width(parent),
                                    obs.obs_source_get_base_height(parent))
    obs.gs_effect_set_vec2(data.params.source_resolution, source_resolution)
    obs.gs_effect_set_float(data.params.time, os.clock())
                      
    -- TODO: Remove the examples below and set your own uniform variables inside the effect
    -- This is straightforward as data conversion is performed in the `update` function
    obs.gs_effect_set_bool(data.params.template_bool, data.template_bool)
    obs.gs_effect_set_int(data.params.template_int, data.template_int)
    obs.gs_effect_set_float(data.params.template_float, data.template_float)
    obs.gs_effect_set_vec4(data.params.template_color, data.template_color)
    obs.gs_effect_set_vec4(data.params.template_vec4, data.template_vec4)
    obs.gs_effect_set_matrix4(data.params.template_matrix4, data.template_matrix4)
    if data.template_texture ~= nil then
      obs.gs_effect_set_texture(data.params.template_texture, data.template_texture.texture)
    end
    obs.gs_effect_set_vec2(data.params.template_texture_size, data.template_texture_size)

  end

  -- Completes the filter processing i.e. starts the draw through the effect shaders
  obs.obs_source_process_filter_tech_end(data.this_source, data.effect,
                                         data.width, data.height, technique)
end

-- Returns the width of the source
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_width
source_info.get_width = function(data)
  return data.width
end

-- Returns the height of the source
-- See https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_height
source_info.get_height = function(data)
  return data.height
end
