// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
// See https://obsproject.com/docs/graphics.html#rendering-graphics
#define SamplerState sampler_state
#define Texture2D texture2d
#define SV_Position POSITION
#define SV_Target TARGET

// Constants
#define PI 3.141592653589793238


// --------------------------------- PRE-DEFINED UNIFORM VARIABLES ---------------------------------

// Mandatory - Set by OBS: View-projection matrix to adapt raw coordinates according to transform
uniform float4x4 ViewProj;

// Mandatory - Set by OBS: Texture with the source picture transformed by previous filters in chain
uniform Texture2D image;

// Pre-defined for template: Pixel resolution of the source after scaling filter if any
uniform float2 target_resolution;

// Pre-defined for template: Pixel resolution of the original source before transform / scaling
uniform float2 source_resolution;

// Pre-defined for template: Time counter in seconds for dynamic effects, set to 0 at OBS start
uniform float time;


// ------------------------------------ CUSTOM UNIFORM VARIABLES -----------------------------------

// The names of the uniform variables need to be used in the Lua code to make the link between the
// script and the shaders. Default values can be set on some of the uniform variables as a first
// step during the development of the effect. The default values will be typically overwritten
// by the default values set in the data settings, see the get_defaults() and update() functions.

// TODO: Remove the examples below and define your own uniform variables
uniform bool      template_bool         = true;
uniform int       template_int          = 1;
uniform float     template_float        = 1.0;
uniform float4    template_color        = { 1.0, 0.0, 0.0, 1.0 }; // RGBA
uniform float4    template_vec4         = { 1.0, 2.0, 3.0, 4.0 };
uniform float4x4  template_matrix4      = { 1.0,  2.0,  3.0,  4.0,
                                            5.0,  6.0,  7.0,  8.0,
                                            9.0, 10.0, 11.0, 12.0,
                                           13.0, 14.0, 15.0, 16.0 };
uniform Texture2D template_texture;
uniform float2    template_texture_size = {-1.0, -1.0};

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


// --------------------------------------- STANDARD SHADERS ----------------------------------------

// Common data structure used for vertices sent as input to the vertex shader
// /!\ This structure cannot be changed as vertex data is sent by OBS
// OBS renders sources as rectangles from (0,0,0,0) to (width,height,0,0) where width and height
// are the values ?? TODO BF
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


// Vertex Shader with standard features (computes screen position of pixel and pass UV through)
PixelData vertex_shader_standard(VertexData input_vertex_data)
{
  PixelData result;
  result.screen_position = mul(float4(input_vertex_data.pos.xyz, 1.0), ViewProj);
  result.uv = input_vertex_data.uv;
  return result;
}

// Pixel shader pass-through
float4 pixel_shader_standard(PixelData input_pixel_data) : TARGET
{
  float4 source_pixel = image.Sample(linear_clamp, input_pixel_data.uv);
  return source_pixel;
}

// ------------------------------------ CUSTOM PIXEL SHADER ----------------------------------------

// Template pixel shader trying to demonstrate a few techniques using the template parameters
float4 pixel_shader_template(PixelData input_pixel_data) : TARGET
{
  // Retrieves the color at the current UV location from the OBS source
  float4 source_pixel = image.Sample(linear_clamp, input_pixel_data.uv);

  // Mixes it with the template_color
  float4 result = source_pixel*template_color;

  // Mixes result with template_texture if loaded with template_float zoom
  if (template_texture_size.x>0 && template_texture_size.y>0)
    result *= template_texture.Sample(linear_wrap, input_pixel_data.uv*template_float);

  // Reverses colors if template_bool is true
  if (template_bool)
    result = float4( (1.0).xxx - result.rgb, result.a);

  // Add moving color bands if template_int is set to 1
  if (template_int==1)
  {
    float wave = (1.0+sin(time*template_vec4.x + 30.0*input_pixel_data.uv.y*template_vec4.y))/3.0;
    result = float4(result.rgb+wave*template_color.rgb, result.a);
  }
  // Otherwise adds the matrix like for dithering
  else
  {
    int2 mat_pos = fmod(source_resolution*input_pixel_data.uv/template_vec4.w, 4.0);
    float level = (0.5+(template_matrix4[mat_pos.x][mat_pos.y]).xxx)*template_vec4.z;
    result = float4(level+result.rgb, result.a);
  }

  return result;
}


// ---------------- TECHNIQUES TO ASSOCIATE VARIOUS SHADERS IN THE SAME EFFECT FILE ----------------

technique DrawStandard
{
  pass
  {
    vertex_shader = vertex_shader_standard(input_vertex_data);
    pixel_shader  = pixel_shader_standard(input_pixel_data);
  }
}

technique Draw
{
  pass
  {
    vertex_shader = vertex_shader_standard(input_vertex_data);
    pixel_shader  = pixel_shader_template(input_pixel_data);
  }
}
