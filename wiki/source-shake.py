import  obspython as obs
import math, time

# Description displayed in the Scripts dialog window
def script_description():
  return """<center><h2>Source Shake!!</h2></center>
            <p>Shake a source in the current scene when a hotkey is pressed. Go to <em>Settings
            </em> then <em>Hotkeys</em> to select the key combination.</p><p>Check the <a href=
            "https://github.com/obsproject/obs-studio/wiki/Scripting-Tutorial-Source-Shake">
            Source Shake Scripting Tutorial</a> on the OBS Wiki for more information.</p>"""

# Global variables to restore the scene item after shake
shaken_sceneitem = None     # Reference to the modified scene item
shaken_sceneitem_angle = 0  # Initial rotation angle, used as well for oscillations
shaken_scene_handler = None # Signal handler of the scene kept to restore

# Callback for item_remove signal
def on_shaken_sceneitem_removed(calldata):
  restore_sceneitem_after_shake()

# Saves the original rotation angle of the given sceneitem and connects item_remove signal
def save_sceneitem_for_shake(sceneitem):
  global shaken_sceneitem, shaken_sceneitem_angle
  shaken_sceneitem = sceneitem
  shaken_sceneitem_angle = obs.obs_sceneitem_get_rot(sceneitem)

  # Handles scene item deletion
  global shaken_scene_handler
  scene_as_source = obs.obs_scene_get_source(obs.obs_sceneitem_get_scene(sceneitem))
  shaken_scene_handler = obs.obs_source_get_signal_handler(scene_as_source)
  obs.signal_handler_connect(shaken_scene_handler, "item_remove", on_shaken_sceneitem_removed)

# Restores the original rotation angle on the scene item and disconnects item_remove signal
def restore_sceneitem_after_shake():
  global shaken_sceneitem, shaken_sceneitem_angle
  if shaken_sceneitem:
    obs.obs_sceneitem_set_rot(shaken_sceneitem, shaken_sceneitem_angle)

    obs.signal_handler_disconnect(shaken_scene_handler, "item_remove", on_shaken_sceneitem_removed)

    shaken_sceneitem = None

# Retrieves the scene item of the given source name in the current scene or None if not found
def get_sceneitem_from_source_name_in_current_scene(name):
  result_sceneitem = None
  current_scene_as_source = obs.obs_frontend_get_current_scene()
  if current_scene_as_source:
    current_scene = obs.obs_scene_from_source(current_scene_as_source)
    result_sceneitem = obs.obs_scene_find_source_recursive(current_scene, name)
    obs.obs_source_release(current_scene_as_source)
  return result_sceneitem

# Global variables holding the values of data settings / properties
source_name = ""           # Name of the source to shake
frequency = 2              # Frequency of oscillations in Hertz
amplitude = 10             # Angular amplitude of oscillations in degrees

# Animates the scene item corresponding to source_name in the current scene
def shake_source():
  sceneitem = get_sceneitem_from_source_name_in_current_scene(source_name)
  if sceneitem:
    id = obs.obs_sceneitem_get_id(sceneitem)
    if shaken_sceneitem and obs.obs_sceneitem_get_id(shaken_sceneitem) != id:
      restore_sceneitem_after_shake()
    if not shaken_sceneitem:
      save_sceneitem_for_shake(sceneitem)
    angle = shaken_sceneitem_angle + amplitude*math.sin(time.time()*frequency*2*math.pi)
    obs.obs_sceneitem_set_rot(sceneitem, angle)
  else:
    restore_sceneitem_after_shake()

# Called at script unload
def script_unload():
  restore_sceneitem_after_shake()

# Called to set default values of data settings
def script_defaults(settings):
  obs.obs_data_set_default_string(settings, "source_name", "")
  obs.obs_data_set_default_double(settings, "frequency", 2)
  obs.obs_data_set_default_int(settings, "amplitude", 10)

# Fills the given list property object with the names of all sources plus an empty one
def populate_list_property_with_source_names(list_property):
  sources = obs.obs_enum_sources()
  obs.obs_property_list_clear(list_property)
  obs.obs_property_list_add_string(list_property, "", "")
  for source in sources:
    name = obs.obs_source_get_name(source)
    obs.obs_property_list_add_string(list_property, name, name)
  obs.source_list_release(sources)

# Called to display the properties GUI
def script_properties():
  props = obs.obs_properties_create()

  # Drop-down list of sources
  list_property = obs.obs_properties_add_list(props, "source_name", "Source name",
                    obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_STRING)
  populate_list_property_with_source_names(list_property)
  # obs.obs_properties_add_text(props, "source_name", "Source name", obs.OBS_TEXT_DEFAULT)

  # Button to refresh the drop-down list
  obs.obs_properties_add_button(props, "button", "Refresh list of sources",
    lambda props,prop: True if populate_list_property_with_source_names(list_property) else True)

  obs.obs_properties_add_float_slider(props, "frequency", "Shake frequency", 0.1, 20, 0.1)
  obs.obs_properties_add_int_slider(props, "amplitude", "Shake amplitude", 0, 90, 1)
  return props

# Called after change of settings including once after script load
def script_update(settings):
  global source_name, frequency, amplitude
  restore_sceneitem_after_shake()
  source_name = obs.obs_data_get_string(settings, "source_name")
  frequency = obs.obs_data_get_double(settings, "frequency")
  amplitude = obs.obs_data_get_int(settings, "amplitude")

# Global animation activity flag
is_active = False

# Called every frame
def script_tick(seconds):
  if is_active:
    shake_source()
  else:
    restore_sceneitem_after_shake()

# Callback for the hotkey
def on_shake_hotkey(pressed):
  global is_active
  is_active = pressed

# Identifier of the hotkey set by OBS
hotkey_id = obs.OBS_INVALID_HOTKEY_ID

# Called at script load
def script_load(settings):
  global hotkey_id
  hotkey_id = obs.obs_hotkey_register_frontend(script_path(), "Source Shake", on_shake_hotkey)
  hotkey_save_array = obs.obs_data_get_array(settings, "shake_hotkey")
  obs.obs_hotkey_load(hotkey_id, hotkey_save_array)
  obs.obs_data_array_release(hotkey_save_array)

# Called before data settings are saved
def script_save(settings):
  restore_sceneitem_after_shake()
  obs.obs_save_sources()

  # Hotkey save
  hotkey_save_array = obs.obs_hotkey_save(hotkey_id)
  obs.obs_data_set_array(settings, "shake_hotkey", hotkey_save_array)
  obs.obs_data_array_release(hotkey_save_array)
