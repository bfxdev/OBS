import obspython as obs
import math, time

# Description displayed in the Scripts dialog window
def script_description():
  return """<center><h2>Source Shake!!</h2></center>
            <p>Shake a source in the current scene when a hotkey is pressed. Go to <em>Settings
            </em> then <em>Hotkeys</em> to select the key combination.</p><p>Check the <a href=
            "https://github.com/obsproject/obs-studio/wiki/Scripting-Tutorial-Source-Shake.md">
            Source Shake Scripting Tutorial</a> on the OBS Wiki for more information.</p>"""

# Global variables to restore the scene item after shake
shaken_sceneitem = None     # Reference to the modified scene item
shaken_sceneitem_angle = 0  # Initial rotation angle, used as well for oscillations
shaken_scene_handler = None # Signal handler of the scene kept to restore

# Callback for item_remove signal
def on_shaken_sceneitem_removed(calldata):
  print("in on_shaken_sceneitem_removed")
  restore_sceneitem_after_shake()

# Saves the original rotation angle of the given sceneitem and connects item_remove signal
def save_sceneitem_for_shake(sceneitem):
  global shaken_sceneitem, shaken_sceneitem_angle, shaken_scene_handler
  shaken_sceneitem = sceneitem
  shaken_sceneitem_angle = obs.obs_sceneitem_get_rot(sceneitem)

  # Handles scene item deletion
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
source_name = "Spaceship"  # Name of the source to shake
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

# Called every frame
def script_tick(seconds):
  #if is_active:
    shake_source()
  #else:
  #  restore_sceneitem_after_shake()

# Called at script unload
def script_unload():
  restore_sceneitem_after_shake()

# Called before data settings are saved
def script_save(settings):
  restore_sceneitem_after_shake()
  obs.obs_save_sources()

# Called to set default values of data settings
def script_defaults(settings):
  obs.obs_data_set_default_string(settings, "source_name", "")
  obs.obs_data_set_default_double(settings, "frequency", 2)
  obs.obs_data_set_default_int(settings, "amplitude", 10)

# Called to display the properties GUI
def script_properties():
  props = obs.obs_properties_create()
  obs.obs_properties_add_text(props, "source_name", "Source name", obs.OBS_TEXT_DEFAULT)
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
