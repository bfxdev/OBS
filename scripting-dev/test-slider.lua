function script_description()
  return [[Simple slider test with modified callback]]
end

function property_modified_callback(obs_properties, obs_property, settings)
  print("In modified callback")
  return true
end

function script_properties()
  props = obslua.obs_properties_create()
  local p = obslua.obs_properties_add_float_slider(props, "example", "Example slider", 0.1, 20, 0.1)
  obslua.obs_property_set_modified_callback(p, property_modified_callback)
  return props
end