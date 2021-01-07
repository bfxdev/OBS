
obs = obslua

-- Global variables holding the values of data settings / properties
source_name = "Spaceship"  -- Name of the source to shake
frequency = 2              -- Frequency of oscillations in Hertz
amplitude = 10             -- Angular amplitude of oscillations in degrees
is_active = true           -- True if the shake effect is currently active

-- Global variables for temporary data
shaken_sceneitem = nil     -- Reference to the modified scene item
shaken_sceneitem_angle = 0 -- Initial rotation angle, used as well for oscillations

-- Rotates the scene item corresponding to source_name in the current scene
function shake_source()

  -- Tries to find the scene item corresponding to source_name
  local sceneitem = nil
  local current_scene_as_source = obs.obs_frontend_get_current_scene()
  if current_scene_as_source then
    local current_scene = obs.obs_scene_from_source(current_scene_as_source)
    sceneitem = obs.obs_scene_find_source_recursive(current_scene, source_name)
    obs.obs_source_release(current_scene_as_source)
  end

  if sceneitem then
    if sceneitem ~= shaken_sceneitem then
      print("not the same")
      reset_source_after_shake()
      shaken_sceneitem = sceneitem
      shaken_sceneitem_angle = obs.obs_sceneitem_get_rot(sceneitem)
    end

    local angle = shaken_sceneitem_angle + amplitude*math.sin(os.clock()*frequency*2*math.pi)
    obs.obs_sceneitem_set_rot(sceneitem, angle)

  else
    reset_source_after_shake()
  end

end

-- Restores the original rotation angle on the scene item after shake
function reset_source_after_shake()
  print("in reset")
  if shaken_sceneitem then
    obs.obs_sceneitem_set_rot(shaken_sceneitem, shaken_sceneitem_angle)
    shaken_sceneitem = nil
  end
end

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
  obs.obs_data_set_default_string(settings, "source_name", "")
  obs.obs_data_set_default_double(settings, "frequency", 2)
  obs.obs_data_set_default_int(settings, "amplitude", 10)
  obs.obs_data_set_default_bool(settings, "is_active", true)
end

-- Called to display the properties GUI
function script_properties()
  props = obs.obs_properties_create()

  local sources = obs.obs_enum_sources()
  local p = obs.obs_properties_add_list(props, "source_name", "Source name",
              obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_STRING)
  obs.obs_property_list_add_string(p, "", "")
  for _,source in pairs(sources) do
    local name = obs.obs_source_get_name(source)
    obs.obs_property_list_add_string(p, name, name)
  end
  obs.source_list_release(sources)

  -- obs.obs_properties_add_text(props, "source_name", "Source name", obs.OBS_TEXT_DEFAULT)
  obs.obs_properties_add_float_slider(props, "frequency", "Shake frequency", 0.1, 20, 0.1)
  obs.obs_properties_add_int_slider(props, "amplitude", "Shake amplitude", 0, 90, 1)
  obs.obs_properties_add_bool(props, "is_active", "Activate effect")

  return props
end

-- Called after change of settings including once after script load
function script_update(settings)
  reset_source_after_shake()
  source_name = obs.obs_data_get_string(settings, "source_name")
  frequency = obs.obs_data_get_double(settings, "frequency")
  amplitude = obs.obs_data_get_int(settings, "amplitude")
  is_active = obs.obs_data_get_bool(settings, "is_active")
end

-- Called every frame
function script_tick(seconds)
  if is_active then
    shake_source()
  else
    reset_source_after_shake()
  end
end

-- Called before data settings are saved
function script_save(settings)
  reset_source_after_shake()
  obs.obs_save_sources()
end

-- Called at script unload
function script_unload()
  reset_source_after_shake()
end
