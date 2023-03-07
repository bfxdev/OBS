// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
// See https://obsproject.com/docs/graphics.html#rendering-graphics
#define SamplerState sampler_state
#define Texture2D texture2d
#define SV_Position POSITION
#define SV_Target TARGET

// Constants
#define PI 3.141592653589793238


// ----------------------------------- COMMON UNIFORM VARIABLES ------------------------------------

// Mandatory - Set by OBS: View-projection matrix to adapt raw coordinates according to transform
uniform float4x4 ViewProj;

// Mandatory - Set by OBS: Texture with the source picture transformed by previous filters in chain
uniform Texture2D image;

// Pixel resolution of the source after scaling filter if any (target resolution)
uniform float2 resolution;

// Pixel resolution of the original source before transform / scaling
uniform float2 source_resolution;

// Time counter in seconds for dynamic effects, set to 0 at OBS start
uniform float time;

// Single random value
uniform float random;

// ----------------------------------- CUSTOM UNIFORM VARIABLES ------------------------------------

// Strenght of the effect
uniform float level = 0.5;

// Synchronization bars for H-Sync and V-Sync
// Synchronization bars displayed or not
uniform bool sync_bars_displayed = false;
// Color of the vertical and horizontal synchronization bars (normally invisible)
uniform float4 sync_bars_color = {0.0, 0.0, 0.0, 1.0};
// Ratio of the size of the synchronization signal bars compared to the image
uniform float2 sync_bars_ratio = {0.08, 0.08};

// H-Sync specific variables
// Horizontal synchronization completely lost
uniform bool hsync_lost = true;
// Threshold between 0 and 1 on the local perturbation to start shifting
uniform float hsync_shift_threshold = 0.5;
// Scale of the horizontal shift when active
uniform float hsync_shift_scale = 1.0;
// Wave influence on the local perturbation, 0 for no influcence i.e. only intensity of last pixel
uniform float hsync_wave_level = 0.5;
// Vertical scale of the wave
uniform float hsync_wave_scale = 1.0;
// Speed of the wave
uniform float hsync_wave_speed = 1.0;


// ----------------------------------------- SAMPLER STATES ----------------------------------------

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
SamplerState linear_wrap
{
  Filter    = Linear;
  AddressU  = Wrap;
  AddressV  = Wrap;
};


// ------------------------------------- SHADER STRUCTURES -----------------------------------------

// Common data structure used for vertices sent as input to the vertex shader
struct VertexData
{
  float4 pos : POSITION;
  float2 uv  : TEXCOORD0;
};

// Data structure used to transmit data produced by the vertex shader to the pixel shader
// See https://learn.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-semantics
// See https://obsproject.com/docs/graphics.html#effect-vertex-pixel-semantics
struct PixelData
{
  float4 screen_position : POSITION;
  float2 uv              : TEXCOORD0;
};

// --------------------------------------- VERTEX SHADERS ------------------------------------------

// Vertex Shader with standard features (computes screen position of pixel and pass UV through)
PixelData vertex_shader_standard(VertexData input_vertex_data)
{
  PixelData result;
  result.screen_position = mul(float4(input_vertex_data.pos.xyz, 1.0), ViewProj);
  result.uv = input_vertex_data.uv;
  return result;
}

// ------------------------------------- GENERAL FUNCTIONS -----------------------------------------

// Returns a one-dimensional pseudo-random value between 0 and 1 from offset and seed
// Added seed to https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83
float hash(float2 n, float seed)
{ 
  return frac(sin(seed + dot(n, float2(12.9898, 4.1414))) * 43758.5453);
}

// Returns 3 pseudo-random value between 0 and 1 from offset and seed
float3 hash3(float2 n, float seed)
{
  return float3(hash(n, seed), hash(n, seed + hash(n, 0.0)), hash(n, seed + hash(n, 1.0)));
}

// Created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
float hash2(float n)
{
    return frac(sin(n)*43758.5453);
}

// 3D Perlin noise created by inigo quilez - iq/2013
// License Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
float perlin_noise(float3 x)
{
    float3 p = floor(x);
    float3 f = frac(x);

    f       = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0 + 113.0*p.z;

    return lerp(lerp(lerp( hash2(n+0.0),   hash2(n+1.0),f.x),
                     lerp( hash2(n+57.0),  hash2(n+58.0),f.x),f.y),
                lerp(lerp( hash2(n+113.0), hash2(n+114.0),f.x),
                     lerp( hash2(n+170.0), hash2(n+171.0),f.x),f.y),f.z);
}

// ----------------------------------------- PIXEL SHADERS -----------------------------------------

// Pixel shader pass-through
float4 pixel_shader_standard(PixelData input_pixel_data) : TARGET
{
  float4 source_pixel = image.Sample(linear_clamp, input_pixel_data.uv);
  return source_pixel;
}

// Returns the shift on the X axis for the H-Sync effect
float hsync_shift(Texture2D tex, float y)
{
  // Gets perlin noise to simulate perturbation of the sync pulse by random noise
  float wave = perlin_noise(hsync_wave_scale*float3(y,
                            hsync_wave_speed*time, hsync_wave_speed*time*PI));

  // Skew the image to the right in case of full sync loss
  if (hsync_lost)
    return 2.5*time + 2.0*y + 0.3*wave;

  // Rectifies the wave to simulate sudden loss of sync, then come back to normal
  wave = 2.0*abs(wave-0.5);

  // Gets the pixel at the right on the same line
  float4 right_pixel = tex.Sample(linear_clamp, float2(1.0, y));

  // Gets the length of the right pixel to simulate a high signal intensity disturbing
  // the horizontal sync pulse on the next line (e.g. shifted voltage)
  float right_pixel_intensity = length(right_pixel.rgb) / sqrt(3.0);

  // Mixes both effects
  float perturbation = lerp(right_pixel_intensity, wave, hsync_wave_level);

  // Shift of the complete line depending on the perturbation, if exceeding threshold
  float res = 0.0;
  if (perturbation > hsync_shift_threshold)
    res = hsync_shift_scale*(perturbation-hsync_shift_threshold);

  return res;
}

// Returns the color of the pixel in a virtual image with sync bars
// The UV coordinates represent the level of horizontal and vertical desynchronization
float4 desync_pixel(Texture2D tex, float2 uv)
{
  // Classical wrapped sampling if sync bars are not displayed
  if (!sync_bars_displayed)
    return tex.Sample(linear_wrap, uv);

  // Color of synchronization bars
  float4 res = sync_bars_color;

  // Determines position as if in unity square
  float2 pos = frac(uv / (float2(1.0, 1.0) + sync_bars_ratio));
  if (pos.x <= 1.0 / (1.0 + sync_bars_ratio.x) && pos.y <= 1.0 / (1.0 + sync_bars_ratio.y))
    res = tex.Sample(linear_wrap, uv);

  return res;
}

// Pixel shader for the H-Sync filter
float4 pixel_shader_hsync(PixelData input_pixel_data) : TARGET
{
  // Retrieves the color at the shifted UV location
  float2 shift = float2(hsync_shift(image, input_pixel_data.uv.y), 0.0);
  return desync_pixel(image, input_pixel_data.uv - shift);
}

// Pixel shader for the Noise filter
float4 pixel_shader_noise(PixelData input_pixel_data) : TARGET
{
  float3 color_noise = hash3(input_pixel_data.uv, random);

  float4 pixel = image.Sample(linear_clamp, input_pixel_data.uv);
  return float4(lerp(pixel.rgb,color_noise,level.xxx), pixel.a);
}


// ---------------------------------------- TECHNIQUES ---------------------------------------------

technique Draw
{
  pass
  {
    vertex_shader = vertex_shader_standard(input_vertex_data);
    pixel_shader  = pixel_shader_standard(input_pixel_data);
  }
}

technique DrawHSync
{
  pass
  {
    vertex_shader = vertex_shader_standard(input_vertex_data);
    pixel_shader  = pixel_shader_hsync(input_pixel_data);
  }
}

technique DrawNoise
{
  pass
  {
    vertex_shader = vertex_shader_standard(input_vertex_data);
    pixel_shader  = pixel_shader_noise(input_pixel_data);
  }
}
