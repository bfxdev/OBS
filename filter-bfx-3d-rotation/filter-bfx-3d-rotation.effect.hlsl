// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
// See https://obsproject.com/docs/graphics.html#rendering-graphics
#define SamplerState sampler_state
#define Texture2D texture2d
#define SV_Position POSITION
#define SV_Target TARGET

// Constants
#define PI 3.141592653589793238
#define EPSILON 0.00000001

// Mandatory - Set by OBS: View-projection matrix to adapt raw coordinates according to transform
uniform float4x4 ViewProj;

// Mandatory - Set by OBS: Texture with the source picture transformed by previous filters in chain
uniform Texture2D image;

// Pixel resolution of the source after scaling filter if any
uniform float2 target_resolution;

// Factor to increase perspective effect
uniform float  perspective_level    = 0.0;

// True if the perspective needs to be centered on the source (otherwise center of the viewport)
uniform bool   perspective_centered = true;

// Interpolation method and wrap mode for sampling a texture
// See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc
// See https://obsproject.com/docs/graphics.html#effect-sampler-states
SamplerState linear_clamp
{
  Filter    = Linear;     // Anisotropy / Point / Linear
  AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
  AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
};

// Sampler state with infinite repetition of the image if zoomed out
SamplerState anisotropy_clamp
{
  Filter    = Anisotropy;
  AddressU  = Clamp;
  AddressV  = Clamp;
};

// Common data structure used for vertices sent as input to the vertex shader
// /!\ This structure cannot be changed as vertex data is sent by OBS
// OBS renders sources as rectangles from (0,0,0,0) to (width,height,0,0)
struct VertexData
{
  float4 pos : POSITION;
  float2 uv  : TEXCOORD0;
};

// Data structure used to transmit data produced by the vertex shader to the pixel shader
// /!\ The member with "POSITION" semantics is mandatory, even if not used in the pixel shader
// An instance of the structure is produced for each vertex then the values are interpolated by
// the GPU, according to the interpolation semantics, to be used as input for each pixel
// See https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-semantics
// See https://obsproject.com/docs/graphics.html#effect-vertex-pixel-semantics
struct PixelData
{
  float4 screen_position : POSITION;
  float2 uv              : TEXCOORD0;
};

// Vertex shader implementing the 3D rotation
PixelData vertex_shader_perspective(VertexData input_vertex_data)
{
  PixelData result;

  // Computes the position of the current vertex on screen
  result.screen_position = mul(float4(input_vertex_data.pos.xyz, 1.0), ViewProj);

  // Adds to w, normally equal to 1.0, the Z value after rotation to introduce perspective
  // Before the vertex is given to the Pixel Shader, x and x coordinates will be divided by w
  result.screen_position.w += result.screen_position.z*perspective_level;

  // As OBS sets [-100,100] as zFar / zNear interval, the Z value must be adapted to avoid
  // clipping in the Z direction
  // See https://github.com/obsproject/obs-studio/blob/master/libobs/obs-source.c#L4430
  result.screen_position.z = 1e-1;

  // Determines the center of the source on screen (just use the projection matrix)
  float4 source_center = float4(target_resolution/2.0, 0.0, 1.0);
  source_center = mul(source_center, ViewProj);

  // Adjusts x and y such the it looks like the vanishing point is at the center of the source
  if (perspective_centered)
    result.screen_position.xy += (result.screen_position.w-1.0)*source_center;

  // Passes UV texture coordinates through
  result.uv = input_vertex_data.uv;

  return result;
}

// Pixel shader pass-through
float4 pixel_shader_standard(PixelData input_pixel_data) : TARGET
{
  float4 source_pixel = image.Sample(anisotropy_clamp, input_pixel_data.uv);
  return source_pixel;
}

technique Draw
{
  pass
  {
    vertex_shader = vertex_shader_perspective(input_vertex_data);
    pixel_shader  = pixel_shader_standard(input_pixel_data);
  }
}
