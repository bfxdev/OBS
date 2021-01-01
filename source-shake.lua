
obs = obslua

-- Global variables holding the values of data settings / properties
source_name = "Spaceship"  -- Name of the source to shake
frequency = 2              -- Frequency of oscillations in Hertz
amplitude = 10             -- Angular amplitude of oscillations in degrees
is_active = true           -- True if the shake effect is currently active

-- Global variables for temporary data
sceneitem = nil            -- Reference to the scene item of the source in the current scene
initial_angle = nil        -- Initial rotation angle, used as well for oscillations


-- Rotates the scene item corresponding to "source_name" in the current scene, if it can be found.
-- Stores a reference to it in "sceneitem", and stores in "initial_angle" its original rotation
-- angle, when found for the first time. Nothing happens if the source cannot be found.
function shake_source()
  --print("in shake_source")
  -- Tries to retrieve sceneitem and initial_angle if not already done
  if not sceneitem then
    local current_scene_as_source = obs.obs_frontend_get_current_scene()
    if current_scene_as_source then
      local current_scene = obs.obs_scene_from_source(current_scene_as_source)
      sceneitem = obs.obs_scene_find_source_recursive(current_scene, source_name)
      if sceneitem then
        initial_angle = obs.obs_sceneitem_get_rot(sceneitem)
        --print("initial_angle=" .. tostring(initial_angle))
      end
      obs.obs_source_release(current_scene_as_source)
    end
  end
  -- Oscillates the scene item around its initial rotation angle
  if sceneitem then
    local new_angle = initial_angle + amplitude*math.sin(os.clock()*frequency*2*math.pi)
    obs.obs_sceneitem_set_rot(sceneitem, new_angle)
    --print("new_angle=" .. tostring(new_angle))
  end
end

-- Restores the original rotation angle on the source after shake, and sets sceneitem to nil
function reset_source_after_shake()
  --print("in reset_source_after_shake initial_angle=" .. tostring(initial_angle))
  if sceneitem then
    obs.obs_sceneitem_set_rot(sceneitem, initial_angle)
    sceneitem = nil
  end
end

--[[
-- Retrieves the scene item corresponding to source_name in the current scene and stores it in sceneitem,
-- then stores its initial rotation angle in initial_angle. If the source cannot be found then sceneitem
-- is set to nil. If any sceneitem was previously initialized then restores its initial rotation angle.
function init_sceneitem_for_shake()
  if sceneitem then
    restore_sceneitem_after_shake()
  end
  local current_scene = obs.obs_frontend_get_current_scene()
  if current_scene then
    sceneitem = obs.obs_scene_find_source_recursive(obs.obs_scene_from_source(current_scene), source_name)
    if sceneitem then
      initial_angle = obs.obs_sceneitem_get_rot(sceneitem)
    end
    obs.obs_source_release(current_scene)
  end
end

-- Sets the rotation angle of sceneitem, if previously initialized, to a time-dependent oscillation
function shake_sceneitem()
  if sceneitem then
    local new_angle = initial_angle + amplitude*math.sin(os.clock()*frequency*2*math.pi)
    obs.obs_sceneitem_set_rot(sceneitem, new_angle)
  end
end

-- Restores the initial angle of sceneitem, if previously initialized, then sets sceneitem to nil
function restore_sceneitem_after_shake()
  if sceneitem then
    obs.obs_sceneitem_set_rot(sceneitem, initial_angle)
    sceneitem = nil
  end
end
]]

-- Description displayed in the Scripts dialog window
function script_description()
  print("in script_description")
  return [[<center><h2>Source Shake!!</h2></center>
           <p>Shakes the given source according to the given frequency and amplitude.</p><p>See the
           <a href="https://github.com/obsproject/obs-studio/wiki/Getting-Started-With-OBS-Scripting">
           Scripting Wiki page</a> for details on the Lua code.</p>]]
end

-- Called to set default values of data settings
function script_defaults(settings)
  print("in script_defaults")
  print("source_name=" .. tostring(obs.obs_data_get_string(settings, "source_name")))
  obs.obs_data_set_default_string(settings, "source_name", "")
  obs.obs_data_set_default_double(settings, "frequency", 2)
  obs.obs_data_set_default_int(settings, "amplitude", 10)
  obs.obs_data_set_default_bool(settings, "is_active", true)
end

-- Called to display the properties GUI
props = nil
function script_properties()
  print("in script_properties")
  props = obs.obs_properties_create()

  local sources = obs.obs_enum_sources()
  local p = obs.obs_properties_add_list(props, "source_name", "Source name",
              obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_STRING)
  for _,source in pairs(sources) do
    local name = obs.obs_source_get_name(source)
    obs.obs_property_list_add_string(p, name, name)
  end
  obs.source_list_release(sources)
  obs.obs_property_set_modified_callback(p, modified_callback_source_name)

  -- obs.obs_properties_add_text(props, "source_name", "Source name", obs.OBS_TEXT_DEFAULT)
  obs.obs_properties_add_float_slider(props, "frequency", "Shake frequency", 0.1, 20, 0.1)
  obs.obs_properties_add_int_slider(props, "amplitude", "Shake amplitude", 0, 90, 1)
  p = obs.obs_properties_add_bool(props, "is_active", "Activate effect")
  obs.obs_property_set_modified_callback(p, modified_callback_is_active)

  -- obs.obs_properties_set_flags(props, obs.OBS_PROPERTIES_DEFER_UPDATE)
  return props
end

function modified_callback_source_name()
  print("in modified_callback_source_name")
  return true
end

function modified_callback_is_active()
  print("in modified_callback_is_active")
  return true
end

-- Called after change of settings including once after script load
function script_update(settings)
  print("in script_update")
  print("source_name=" .. tostring(obs.obs_data_get_string(settings, "source_name")))
  reset_source_after_shake()
  source_name = obs.obs_data_get_string(settings, "source_name")
  frequency = obs.obs_data_get_double(settings, "frequency")
  amplitude = obs.obs_data_get_int(settings, "amplitude")
  is_active = obs.obs_data_get_bool(settings, "is_active")
  obs.obs_data_set_bool(settings, "is_active", false)

  -- if props then obs.obs_properties_apply_settings(props, settings) end
end

-- Called every frame
function script_tick(seconds)
  --print("in script_tick")
  if is_active then
    shake_source()
  else
    reset_source_after_shake()
  end
end


-- Called at 
function script_save(settings)
  print("in script_save")
  is_active = false
  obs.obs_data_set_bool(settings, "is_active", false)
  reset_source_after_shake()


  -- obs.obs_save_sources()
  --obs.obs_frontend_save()
end

function script_load(settings)
  print("in script_load")
  print("source_name=" .. tostring(obs.obs_data_get_string(settings, "source_name")))
  obs.obs_frontend_add_event_callback(on_frontend_event)
  obs.obs_frontend_add_save_callback(on_frontend_save)
end

function on_frontend_event(event)
  print("in on_frontend_event event=" .. tostring(event))
  if event == obs.OBS_FRONTEND_EVENT_EXIT then
    is_active = false
  end
  reset_source_after_shake()
end

function on_frontend_save()
  print("in on_frontend_save")
  local current_is_active = is_active
  is_active = false
  reset_source_after_shake()
  obs.obs_save_sources()
  --obs.obs_frontend_save()
  is_active = current_is_active
end

function script_unload()
  print("in script_unload")
  is_active = false
  reset_source_after_shake()
  --obs.obs_save_sources()
  --obs.obs_frontend_save()
end

print("in first execution")
