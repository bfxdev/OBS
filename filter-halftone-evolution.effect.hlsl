// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d

// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture

// General properties
uniform float gamma = 1.0;
uniform float gamma_shift = 0.6;
uniform int number_of_color_levels = 4.0;

// Size of the source picture
uniform int width;
uniform int height;

// Constants
#define PI 3.141592653589793238

// General properties
uniform float amplitude = 0.2;
uniform float scale = 1.0;
uniform float offset = 0.5;

// Pattern texture
uniform Texture2D pattern_texture;
uniform float2 pattern_size = {-1.0, -1.0};
uniform float pattern_gamma = 1.0;

// Palette texture
uniform Texture2D palette_texture;
uniform float2 palette_size = {-1.0, -1.0};
uniform float palette_gamma = 1.0;

// Interpolation method and wrap mode for sampling a texture
SamplerState linear_clamp
{
    Filter    = Linear;     // Anisotropy / Point / Linear
    AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    BorderColor = 00000000; // Used only with Border edges (optional)
};

// Data type of the input of the vertex shader
struct vertex_data
{
    float4 pos : POSITION;  // Homogeneous space coordinates XYZW
    float2 uv  : TEXCOORD0; // UV coordinates in the source picture
};

// Data type of the output returned by the vertex shader, and used as input 
// for the pixel shader after interpolation for each pixel
struct pixel_data
{
    float4 pos : POSITION;  // Homogeneous screen coordinates XYZW
    float2 uv  : TEXCOORD0; // UV coordinates in the source picture
};

// Vertex shader used to compute position of rendered pixels and pass UV
pixel_data vertex_shader_halftone(vertex_data vertex)
{
    pixel_data pixel;
    pixel.pos = mul(float4(vertex.pos.xyz, 1.0), ViewProj);
    pixel.uv  = vertex.uv;
    return pixel;
}

float3 decode_gamma(float3 color, float exponent, float shift)
{
    return pow(clamp(color, 0.0, 1.0), exponent - shift);
}

float3 encode_gamma(float3 color, float exponent)
{
    return pow(clamp(color, 0.0, 1.0), 1.0/exponent);
}

float4 get_perturbation(float2 position)
{
    float4 result;
    result = float4((cos(PI*position.x/scale/4.0) * cos(PI*position.y/scale/4.0)).xxx, 1.0);
    return result;
}

float4 get_closest_color(float3 input_color)
{
    float4 result;
    result = float4(round((number_of_color_levels-1)*input_color)/(number_of_color_levels-1), 1.0);
    return result;
}

float4 pixel_shader_halftone(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float3 linear_color = decode_gamma(source_sample.rgb, gamma, gamma_shift);

    float2 position = pixel.uv * float2(width, height);
    float4 perturbation = get_perturbation(position);

    float3 perturbed_color = linear_color + offset + amplitude*perturbation.rgb;

    float4 closest_color = get_closest_color(clamp(perturbed_color, 0.0, 1.0));

    return float4(encode_gamma(closest_color.rgb, gamma), source_sample.a);
}


technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_halftone(vertex);
        pixel_shader  = pixel_shader_halftone(pixel);
    }
}











