
obs = obslua

-- Global variables holding the values of data settings / properties
source_name = "Spaceship"  -- Name of the source to shake
frequency = 2              -- Frequency of oscillations in Hertz
amplitude = 10             -- Angular amplitude of oscillations in degrees

-- Global variables to restore the scene item after shake
shaken_sceneitem = nil     -- Reference to the modified scene item
shaken_sceneitem_angle = 0 -- Initial rotation angle, used as well for oscillations
shaken_scene_handler = nil -- Signal handler of the scene kept to restore

-- Callback for item_remove signal
function on_shaken_sceneitem_removed(calldata)
  restore_sceneitem_after_shake()
end

-- Saves the original rotation angle of the given sceneitem and connects item_remove signal
function save_sceneitem_for_shake(sceneitem)
  shaken_sceneitem = sceneitem
  shaken_sceneitem_angle = obs.obs_sceneitem_get_rot(sceneitem)

  -- Handles scene item deletion
  local scene_as_source = obs.obs_scene_get_source(obs.obs_sceneitem_get_scene(sceneitem))
  shaken_scene_handler = obs.obs_source_get_signal_handler(scene_as_source)
  obs.signal_handler_connect(shaken_scene_handler, "item_remove", on_shaken_sceneitem_removed)
end

-- Restores the original rotation angle on the scene item and disconnects item_remove signal
function restore_sceneitem_after_shake()
  if shaken_sceneitem then
    --print("Restoring scene item with ID=" .. tostring(obs.obs_sceneitem_get_id(shaken_sceneitem)))
    obs.obs_sceneitem_set_rot(shaken_sceneitem, shaken_sceneitem_angle)

    obs.signal_handler_disconnect(shaken_scene_handler, "item_remove", shaken_sceneitem_remove_callback)

    shaken_sceneitem = nil
  end
end

-- Retrieves the scene item of the given source name in the current scene or nil if not found
function get_sceneitem_from_source_name_in_current_scene(name)
  local result_sceneitem = nil
  local current_scene_as_source = obs.obs_frontend_get_current_scene()
  if current_scene_as_source then
    local current_scene = obs.obs_scene_from_source(current_scene_as_source)
    result_sceneitem = obs.obs_scene_find_source_recursive(current_scene, name)
    obs.obs_source_release(current_scene_as_source)
  end
  return result_sceneitem
end

-- Animates the scene item corresponding to source_name in the current scene
function shake_source()
  local sceneitem = get_sceneitem_from_source_name_in_current_scene(source_name)
  if sceneitem then
    local id = obs.obs_sceneitem_get_id(sceneitem)
    if shaken_sceneitem and obs.obs_sceneitem_get_id(shaken_sceneitem) ~= id then
      restore_sceneitem_after_shake()
    end
    if not shaken_sceneitem then
      save_sceneitem_for_shake(sceneitem)
    end
    local angle = shaken_sceneitem_angle + amplitude*math.sin(os.clock()*frequency*2*math.pi)
    obs.obs_sceneitem_set_rot(sceneitem, angle)
  else
    restore_sceneitem_after_shake()
  end
end

-- Description displayed in the Scripts dialog window
function script_description()
  print("in script_description")
  return [[<center><h2>Source Shake!!</h2></center>
           <p>Shake a source in the current scene when a hotkey is pressed. Go to <em>Settings
           </em> then <em>Hotkeys</em> to select the key combination.</p><p>Check the <a href=
           "https://github.com/obsproject/obs-studio/wiki/Scripting-Tutorial-Source-Shake.md">
           Source Shake Scripting Tutorial</a> on the OBS Wiki for more information.</p>]]
end

-- Called to set default values of data settings
function script_defaults(settings)
  obs.obs_data_set_default_string(settings, "source_name", "")
  obs.obs_data_set_default_double(settings, "frequency", 2)
  obs.obs_data_set_default_int(settings, "amplitude", 10)
end

-- Fills the given property object with the names of all sources plus an empty one
function populate_property_list_with_source_names(list_property)
  local sources = obs.obs_enum_sources()
  obs.obs_property_list_clear(list_property)
  obs.obs_property_list_add_string(list_property, "", "")
  for _,source in pairs(sources) do
    local name = obs.obs_source_get_name(source)
    obs.obs_property_list_add_string(list_property, name, name)
  end
  obs.source_list_release(sources)
end

-- Called to display the properties GUI
function script_properties()
  print("in script_properties")
  props = obs.obs_properties_create()

  local p = obs.obs_properties_add_list(props, "source_name", "Source name",
              obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_STRING)
  populate_property_list_with_source_names(p)

  obs.obs_properties_add_button(props, "button", "Refresh list of sources",
    function() populate_property_list_with_source_names(p) return true end)

  -- obs.obs_properties_add_text(props, "source_name", "Source name", obs.OBS_TEXT_DEFAULT)
  obs.obs_properties_add_float_slider(props, "frequency", "Shake frequency", 0.1, 20, 0.1)
  obs.obs_properties_add_int_slider(props, "amplitude", "Shake amplitude", 0, 90, 1)

  return props
end

-- Called after change of settings including once after script load
function script_update(settings)
  restore_sceneitem_after_shake()
  source_name = obs.obs_data_get_string(settings, "source_name")
  frequency = obs.obs_data_get_double(settings, "frequency")
  amplitude = obs.obs_data_get_int(settings, "amplitude")
end

-- Called every frame
function script_tick(seconds)
  if is_active then
    shake_source()
  else
    restore_sceneitem_after_shake()
  end
end

-- Global variables for the hotkey
is_active = false                      -- True if the shake effect is currently active
hotkey_id = obs.OBS_INVALID_HOTKEY_ID  -- Identifier of the hotkey set by OBS

-- Callback for the hotkey
function on_shake_hotkey(pressed)
  is_active = pressed
end

-- Called before data settings are saved
function script_save(settings)
  restore_sceneitem_after_shake()
  obs.obs_save_sources()

  local hotkey_save_array = obs.obs_hotkey_save(hotkey_id)
	obs.obs_data_set_array(settings, "shake_hotkey", hotkey_save_array)
	obs.obs_data_array_release(hotkey_save_array)
end

-- Called at script load
function script_load(settings)
	hotkey_id = obs.obs_hotkey_register_frontend("OBS_KEY_SHAKE", "Source Shake", on_shake_hotkey)
	local hotkey_save_array = obs.obs_data_get_array(settings, "shake_hotkey")
	obs.obs_hotkey_load(hotkey_id, hotkey_save_array)
  obs.obs_data_array_release(hotkey_save_array)
end

-- Called at script unload
function script_unload()
  restore_sceneitem_after_shake()
  -- obs.obs_hotkey_unregister(shake_on_hotkey)
end
