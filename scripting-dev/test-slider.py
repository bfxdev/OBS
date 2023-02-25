import obspython
obs = obspython

def script_description():
  return "Simple slider test with modified callback"

def property_modified_callback(obs_properties, obs_property, settings):
  print("In modified callback")
  return True

def script_properties():
  props = obspython.obs_properties_create()
  p = obs.obs_properties_add_float_slider(props, "example", "Example slider", 0.1, 20, 0.1)
  obs.obs_property_set_modified_callback(p, property_modified_callback)
  return props

