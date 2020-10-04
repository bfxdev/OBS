-- Lua code to demonstrate that pointer-pointer variables cannot be returned in the current implementation
-- of Lua using SWIG in OBS v26 and previous versions, see https://github.com/obsproject/obs-studio/issues/3462

-- Minimal OBS script required function
function script_description()
  return "Attempt to retrieve error_string showing errors in compiled effect"
end


-- Effect code with extra error, visible in OBS logs
EFFECT = [[
  uniform float4x4 ViewProj;
  uniform texture2d image;
  sampler_state linear_clamp { Filter = Linear; AddressU = Clamp; AddressV = Clamp; };
  struct shader_data { float4 pos : POSITION; float2 uv : TEXCOORD0; };

  shader_data vertex_shader_default(shader_data cur)
  {
      shader_data res;
      res.pos = mul(float4(cur.pos.xyz, 1.0), ViewProj);
      res.uv  = cur.uv;
      return res;
  }
  
  float4 pixel_shader_identity(shader_data cur) : TARGET
  {
      my_undeclared_identifier(); // ERROR on purpose to demonstrate failed compilation
      return image.Sample(linear_clamp, cur.uv);
  }
  
  technique Draw
  {
      pass
      {
          vertex_shader = vertex_shader_default(cur);
          pixel_shader  = pixel_shader_identity(cur);
      }
  }
]]

function script_defaults(settings)

  print("Attempt to call gs_effect_create with empty local variable as error_string")

  obslua.obs_enter_graphics()
  local result
  local effect
  effect = obslua.gs_effect_create(EFFECT, "dummy", result)

  print("effect=" .. tostring(effect) .. " result=" ..  tostring(result))
  obslua.obs_leave_graphics()

end

function script_load(settings)

  print("Attempt to call gs_effect_create with expected second returned parameter")

  obslua.obs_enter_graphics()
  local result
  local effect
  effect, result = obslua.gs_effect_create(EFFECT, "dummy", nil)
  print("effect=" .. tostring(effect) .. " result=" ..  tostring(result))
  obslua.obs_leave_graphics()

end

function script_update(settings)

  print("Attempt to call gs_effect_create with empty local string as error_string")

  obslua.obs_enter_graphics()
  local result = ""
  local effect
  effect = obslua.gs_effect_create(EFFECT, "dummy", result)

  print("effect=" .. tostring(effect) .. " result=" ..  tostring(result))
  obslua.obs_leave_graphics()


end
