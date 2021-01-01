import obspython as obs
import math, time

# Name of the source to shake
source_name = "Spaceship"

# Kept reference to scene item
sceneitem = None

# Initial rotation angle
initial_angle = 0

# Frequency of oscillations in Hertz
frequency = 2

# Angular amplitude of oscillations in degrees
amplitude = 10

# Retrieves the scene item corresponding to source_name in the current scene and stores it in sceneitem,
# then stores its initial rotation angle in initial_angle. If the source cannot be found then sceneitem
# is set to None. If any sceneitem was previously initialized then restores its initial rotation angle.
def init_sceneitem_for_shake():
  global sceneitem, initial_angle
  if sceneitem:
    restore_sceneitem_after_shake()
  current_scene = obs.obs_scene_from_source(obs.obs_frontend_get_current_scene())
  sceneitem = obs.obs_scene_find_source_recursive(current_scene, source_name)
  if sceneitem:
    initial_angle = obs.obs_sceneitem_get_rot(sceneitem)

# Sets the rotation angle of sceneitem, if previously initialized, to a time-dependent oscillation
def shake_sceneitem():
  if sceneitem:
    new_angle = initial_angle + amplitude*math.sin(time.time()*frequency*2*math.pi)
    obs.obs_sceneitem_set_rot(sceneitem, new_angle)

# Restores the initial angle of sceneitem, if previously initialized, then sets sceneitem to None
def restore_sceneitem_after_shake():
  global sceneitem, initial_angle
  if sceneitem:
    obs.obs_sceneitem_set_rot(sceneitem, initial_angle)
    sceneitem = None

# Description displayed in the Scripts dialog window
def script_description():
  print("in script_description")
  return """<center><h2>Source Shake!!</h2></center>
            <p>Shakes the given source according to the given frequency and amplitude.</p><p>See the
            <a href="https://github.com/obsproject/obs-studio/wiki/Getting-Started-With-OBS-Scripting">
            Scripting Wiki page</a> for details on the Python code.</p>"""

# Called to set default values of data settings
def script_defaults(settings):
  print("in script_defaults")
  obs.obs_data_set_default_string(settings, "source_name", "")
  obs.obs_data_set_default_double(settings, "frequency", 2)
  obs.obs_data_set_default_int(settings, "amplitude", 10)

# Called to display the properties GUI
def script_properties():
  print("in script_properties")
  props = obs.obs_properties_create()

  sources = obs.obs_enum_sources()
  p = obs.obs_properties_add_list(props, "source_name", "Source name",
              obs.OBS_COMBO_TYPE_LIST, obs.OBS_COMBO_FORMAT_STRING)
  for source in sources:
    name = obs.obs_source_get_name(source)
    obs.obs_property_list_add_string(p, name, name)
  obs.source_list_release(sources)

  #obs.obs_properties_add_text(props, "source_name", "Source name", obs.OBS_TEXT_DEFAULT)
  obs.obs_properties_add_float_slider(props, "frequency", "Shake frequency", 0.1, 20, 0.1)
  obs.obs_properties_add_int_slider(props, "amplitude", "Shake amplitude", 0, 90, 1)
  return props

# Called after change of settings including once after script load
def script_update(settings):
  print("in script_update")
  global source_name, frequency, amplitude
  source_name = obs.obs_data_get_string(settings, "source_name")
  frequency = obs.obs_data_get_double(settings, "frequency")
  amplitude = obs.obs_data_get_int(settings, "amplitude")
  init_sceneitem_for_shake()

# Called every frame
def script_tick(seconds):
  shake_sceneitem()

# Called at script unload
def script_unload():
  print("in script_unload")
  restore_sceneitem_after_shake()

def script_load(settings):
  print("in script_load")

def script_save(settings):
  print("in script_save")
