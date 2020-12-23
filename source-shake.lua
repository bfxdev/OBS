
obs = obslua

-- Name of the source to shake
source_name = "Spaceship"

-- Kept reference to scene item
sceneitem = nil

-- Initial rotation angle
initial_angle = 0

-- Frequency of oscillations in Hertz
frequency = 2

-- Angular amplitude of oscillations in degrees
amplitude = 10

-- Retrieves the scene item corresponding to source_name in the current scene and stores it in sceneitem,
-- then stores its initial rotation angle in initial_angle. If the source cannot be found then sceneitem
-- is set to nil. If any sceneitem was previously initialized then restores its initial rotation angle.
function init_sceneitem_for_shake()
  if sceneitem then
    restore_sceneitem_after_shake()
  end
  local current_scene = obs.obs_scene_from_source(obs.obs_frontend_get_current_scene())
  sceneitem = obs.obs_scene_find_source_recursive(current_scene, source_name)
  if sceneitem then
    initial_angle = obs.obs_sceneitem_get_rot(sceneitem)
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


-- Description displayed in the Scripts dialog window
function script_description()
  return [[<center><h2>Source Shake!!</h2></center>
           <p>Shakes the given source according to the given frequency and amplitude.</p><p>See the
           <a href="https://github.com/obsproject/obs-studio/wiki/Getting-Started-With-OBS-Scripting">
           Scripting Wiki page</a> for details on the Lua code.</p>]]
end

-- Called after change of settings including once after script load
function script_update(settings)
  init_sceneitem_for_shake()
end

-- Called every frame
function script_tick(seconds)
  shake_sceneitem()
end

-- Called at script unload
function script_unload()
  restore_sceneitem_after_shake()
end


