// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d

// Constants
#define GAMMA 1.0 //2.2
#define PI 3.141592653589793238

// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture

// Size of the source picture
uniform int width;
uniform int height;

// General properties
uniform float gamma_shift = 1.2;
uniform float amplitude = 0.2;
uniform float scale = 8.0;
uniform int number_of_color_levels = 4.0;

// Pattern texture
uniform Texture2D pattern_texture;
uniform float2 pattern_size = {-1.0, -1.0};

// Palette texture
uniform Texture2D palette_texture;
uniform float2 palette_size = {-1.0, -1.0};

// Interpolation method and wrap mode for sampling a texture
SamplerState linear_clamp
{
    Filter    = Linear;     // Anisotropy / Point / Linear
    AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    BorderColor = 00000000; // Used only with Border edges (optional)
};

SamplerState linear_wrap
{
    Filter    = Point; 
    AddressU  = Wrap;
    AddressV  = Wrap;
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

float3 decode_gamma(float3 color, float shift)
{
    return pow(color, GAMMA - shift);
}

float3 encode_gamma(float3 color)
{
    return pow(color, 1.0/GAMMA);
}


    /*float luminance = dot(linear_color, float3(0.299, 0.587, 0.114));
    float2 position = pixel.uv * float2(width, height);
    float perturbation = amplitude * sin(2.0*PI*position.x/scale) * sin(2.0*PI*position.y/scale);
    float3 result = (luminance + perturbation).xxx;*/



// Pixel shader used to compute an RGBA color at a given pixel position
float4 pixel_shader_halftone(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float3 linear_color = decode_gamma(source_sample.rgb, gamma_shift);
    float luminance = dot(linear_color, float3(0.299, 0.587, 0.114));
    float2 position = pixel.uv * float2(width, height);

    float3 perturbation;
    if (pattern_size.x>0)
    {
        float2 pattern_uv = position / pattern_size;
        float4 pattern_sample = pattern_texture.Sample(linear_wrap, pattern_uv / scale);
        //perturbation = amplitude*2.0*(decode_gamma(pattern_sample.rgb, 0.0) - float3(0.5, 0.5, 0.5));
        perturbation = amplitude*2.0*(pattern_sample.rgb - float3(0.5, 0.5, 0.5));
    }
    else
    {
        perturbation = amplitude * cos(PI*position.x/scale/4.0) * cos(PI*position.y/scale/4.0);
    }

    float3 result = (luminance + perturbation.x).xxx;
    //float3 result = linear_color + perturbation;
    result = round((number_of_color_levels-1)*result)/(number_of_color_levels-1);

    return float4(encode_gamma(result), source_sample.a);
}

/*
// Black-and-white pixel shader
float4 pixel_shader_luminance(shader_data cur) : TARGET
{
    float4 smp = image.Sample(linear_clamp, cur.uv);
    //float luminance = 0.299*smp.r + 0.587*smp.g + 0.114*smp.b;

    float2 tpos = cur.uv*float2(width, height)/float2(texture_width, texture_height)/texture_scale;
    //float2 tpos = fmod(cur.uv*float2(width, height), tsize)/(tsize*texture_scale);
    float3 level = (texture_data.Sample(linear_wrap, tpos).rgb-float3(intensity_level, intensity_level, intensity_level))*intensity_range;

    float3 res = step(0.5, pow( smp.rgb+level , float3(gamma, gamma, gamma)));

    return float4(res, smp.a);
}
*/

technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_halftone(vertex);
        pixel_shader  = pixel_shader_halftone(pixel);
    }
}


