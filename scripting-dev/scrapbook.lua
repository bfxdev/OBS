
-- Many trials and errors - Some code snippets to be conserved, nothing functional

-- Logging of View-Projection matrix and various source states
if LogCurrentState > 0 then
  LogCurrentState = LogCurrentState - 1
  local mat = obs.matrix4()
  obs.gs_matrix_get(mat)
  if mat ~= nil then
    print("--")
    print("----------- ViewProj Matrix -----------")
    print(string.format("[ %+4.4f %+4.4f %+4.4f %+4.4f ]", mat.x.x, mat.y.x, mat.z.x, mat.t.x))
    print(string.format("[ %+4.4f %+4.4f %+4.4f %+4.4f ]", mat.x.y, mat.y.y, mat.z.y, mat.t.y))
    print(string.format("[ %+4.4f %+4.4f %+4.4f %+4.4f ]", mat.x.z, mat.y.z, mat.z.z, mat.t.z))
    print(string.format("[ %+4.4f %+4.4f %+4.4f %+4.4f ]", mat.x.w, mat.y.w, mat.z.w, mat.t.w))
    print("----------- Other states -----------")
    local vp = obs.gs_rect()
    obs.gs_get_viewport(vp)
    print("View Port: x=" .. vp.x .. " y=" .. vp.x .. " cx=" .. vp.cx .. " cy=" .. vp.cy)
    local parent = obs.obs_filter_get_parent(data.this_source)
    local parent_name = obs.obs_source_get_name(parent)
    print("Parent name: " .. parent_name)
    local target = obs.obs_filter_get_target(data.this_source)
    local target_name = obs.obs_source_get_name(target)
    print("Target name: " .. target_name)
    mat = transformed_coordinates
    print("Source center in viewport: x=" .. source_center.x .. " y=" .. source_center.y)
    print("obs_source_showing: " .. tostring(obs.obs_source_showing(data.this_source)))
    print("obs_source_active: " .. tostring(obs.obs_source_active(data.this_source)))
    print("Source ID: " .. obs.obs_source_get_id(data.this_source))
  end
end

-- The perspective_center follows the center of the source if not set manually
local perspective_center = obs.vec2()
if data.perspective_centered then
  obs.vec2_set(perspective_center, data.perspective_center_x, data.perspective_center_y)
else
  obs.vec2_set(perspective_center, 2.0*(source_center.x-viewport.x)/viewport.cx - 1.0,
                                   1.0-2.0*(source_center.y-viewport.y)/viewport.cy)
end
obs.gs_effect_set_vec2(data.params.perspective_center, perspective_center)

-- Examples of use of gs_perspective:
-- https://github.com/stream-labs/facemask-plugin/blob/master/smll/OBSRenderer.cpp
-- https://github.com/LiuKeHua/MyObsStudio/blob/master/plugins/MyPlugins/obs-stream-effects/source/filter-transform.cpp
-- https://github.com/Xaymar/obs-StreamFX/blob/root/source/filters/filter-transform.cpp
-- See https://github.com/obsproject/obs-studio/blob/master/libobs/graphics/graphics.c#L1205
local fov = math.max(1e-5, data.perspective*90)
obs.gs_perspective(fov, data.width/data.height, 1e-6, 1e6)
obs.gs_matrix_translate3f(-viewport.cx/2, -viewport.cy/2, 0.0)
-- Fixes camera pointing at -Z instead of +Z.
obs.gs_matrix_scale3f(1.0, 1.0, -1.0)
-- Moves camera backwards (i.e. push vertices to the back)
obs.gs_matrix_translate3f(0.0, 0.0, -data.width/(2*math.tan(math.pi*fov/360)))

-- Orthographic projection with very far clipping planes
-- See https://obsproject.com/docs/reference-libobs-graphics-graphics.html#c.gs_ortho
obs.gs_ortho(viewport.x, viewport.x + viewport.cx,
             viewport.y, viewport.y + viewport.cy, -1e3, 1e3)
--obs.gs_ortho(0.0, viewport.cx, 0.0, viewport.cy, -1e6, 1e6)

-- Frustum projection
-- See https://obsproject.com/docs/reference-libobs-graphics-graphics.html#c.gs_frustum
local max = math.max(data.width, data.height)
local distance = 10000.0
obs.gs_frustum(viewport.x - viewport.cx/2, viewport.x + viewport.cx/2,
               viewport.y - viewport.cy/2, viewport.y + viewport.cy/2,
               distance - max, distance + max)
obs.gs_matrix_translate3f(0.0, 0.0, -distance)


-- Centers viewport
viewport.x = viewport.x - source_center.x
viewport.y = viewport.y - source_center.y
obs.gs_set_viewport(source_center.x - viewport.cx/2, viewport.y - viewport.cy/2,
                    viewport.cx, viewport.cy)

-- On the OpenGL matrix projection:
-- https://stackoverflow.com/questions/25584667/why-do-i-divide-z-by-w-in-a-perspective-projection-in-opengl
-- https://www.scratchapixel.com/lessons/3d-basic-rendering/perspective-and-orthographic-projection-matrix/projection-matrix-GPU-rendering-pipeline-clipping.html
-- https://carmencincotti.com/2022-11-28/from-clip-space-to-ndc-space/
-- http://www.songho.ca/opengl/gl_transform.html
-- https://blogoben.wordpress.com/2011/06/05/webgl-basics-5-full-transformation-matrix/

-- Adapts current matrix directly to introduce perspective
local current_matrix = obs.matrix4()
obs.gs_matrix_get(current_matrix)
current_matrix.z.w = data.perspective/1e3
obs.gs_matrix_set(current_matrix)

-- Sets the Z factor to a lower value to reduce the depth of the transformed 3D object, as
-- OBS sets arbitrarily the znear clipping plane to to -100 and zfar to 100 in
-- obs_source_process_filter_begin: gs_ortho(0.0f, (float)cx, 0.0f, (float)cy, -100.0f, 100.0f);
-- See https://github.com/obsproject/obs-studio/blob/master/libobs/obs-source.c#L4384
obs.gs_matrix_scale3f(1.0, 1.0, 1e-3)
-- Gets information on the source transform from the current view-projection matrix
local view_projection_matrix = obs.matrix4()
obs.gs_matrix_get(view_projection_matrix)

-- Coordinates contain vectors to be transformed like in the vertex shader
local coordinates = obs.matrix4()
obs.vec4_set(coordinates.x, 1.0, 0.0, 0.0, 0.0)                        -- x: X pixel vector
obs.vec4_set(coordinates.y, 0.0, 1.0, 0.0, 0.0)                        -- y: Y pixel vector
obs.vec4_set(coordinates.z, 0.0, 0.0, 0.0, 1.0)                        -- z: source point (0,0)
obs.vec4_set(coordinates.t, data.width/2.0, data.height/2.0, 0.0, 1.0) -- t: source center
local transformed_coordinates = obs.matrix4()
obs.matrix4_mul(transformed_coordinates, coordinates, view_projection_matrix)

local source_center = obs.vec2()
obs.vec2_set(source_center, transformed_coordinates.t.x, transformed_coordinates.t.y)
