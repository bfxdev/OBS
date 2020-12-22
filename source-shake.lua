
local obs = obslua

-- Name of the source to shake
local source_name = "Spaceship"

-- Frequency of oscillations in Hertz
local frequency = 2

-- Amplitude ratio of oscillations
local amplitude = 0.1

-- Kept reference to scene item
local scene_item = nil

-- Original rotation angle to be able to restore it
local original_angle

-- Gets the scene_item in the current scene corresponding to the given source name
function init_source_shake(name)
  assert(scene_item == nil, "Re-definition of scene_item")
  local current_scene = obs.obs_scene_from_source(obs.obs_frontend_get_current_scene())
  scene_item = obs.obs_scene_find_source_recursive(current_scene, source_name)
  if scene_item then
    original_angle = obs.obs_sceneitem_get_rot(scene_item)
    return true
  else
    return false
  end
end

-- Updates with new time-dependent rotation angle
function update_source_shake()
  if(scene_item) then
    local new_angle = original_angle + 90*amplitude*math.sin(os.clock()*frequency*2*math.pi)
    obs.obs_sceneitem_set_rot(scene_item, new_angle)
  end
end

-- Restore the source to its initial angle
function restore_source_shake(name)
  if scene_item then
    obs.obs_sceneitem_set_rot(scene_item, original_angle)
    scene_item = nil
  end
end

-- Description displayed in the Scripts dialog window
function script_description()
  return [[<center><h2>Source Shake!!</h2></center>
           <p>Shake the given source according to the given frequency and amplitude</p><p>See the
           <a href="https://github.com/obsproject/obs-studio/wiki/Getting-Started-With-OBS-Scripting">
           Scripting Wiki page</a> for details on the Lua code</p>]]
end

function script_update(settings)
  init_source_shake(source_name)
end

-- Called at each rendered frame
function script_tick(seconds)
  update_source_shake()
end



