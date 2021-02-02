// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d

// Constants
#define GAMMA 2.2
#define PI 3.141592653589793238

// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture

// Size of the source picture
uniform int width;
uniform int height;

// General properties
uniform float gamma_correction = -1.2;
uniform float dithering_amplitude = 0.5;

/*
uniform float intensity_level = 0.5;
uniform float intensity_range = 1.0;

uniform Texture2D texture_data;
uniform int texture_width;
uniform int texture_height;
uniform float texture_scale = 0.1;
*/

// Interpolation method and wrap mode for sampling a texture
SamplerState linear_clamp
{
    Filter    = Linear;     // Anisotropy / Point / Linear
    AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    BorderColor = 00000000; // Used only with Border edges (optional)
};

/*

SamplerState linear_wrap
{
    Filter    = Point; 
    AddressU  = Wrap;
    AddressV  = Wrap;
};

*/

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

float3 decode_gamma(float3 color)
{
    return pow(color, GAMMA + gamma_correction);
}

float3 encode_gamma(float3 color)
{
    return pow(color, 1.0/GAMMA);
}

/*
float4 compute_linear_halftone(float4 linear_color, int x, int y)
{
    float luminance = 0.299*linear_color.r + 0.587*linear_color.g + 0.114*linear_color.b;
    float level = round(linear_color.r + linear_color.g + linear_color.b) / 3.0;
    //float level = round(luminance*3.0)/3.0;
    //float level = luminance;
    return float4(level, level, level, linear_color.a);
}
*/
/*
float4 compute_linear_halftone(float4 linear_color, float x, float y)
{
    float luminance = 0.299*linear_color.r + 0.587*linear_color.g + 0.114*linear_color.b;

    float perturbation = 0.5*cos(x*2.0*PI/6.0)*sin(y*2.0*PI/6.0);

    float level = round(3.0*(luminance+perturbation))/3.0;

    return float4(level, level, level, linear_color.a);
}
*/
    //int x = pixel.uv.x * width;
    //int y = pixel.uv.y * height;
    //float x = pixel.pos.x / pixel.pos.w;
    //float y = pixel.pos.y / pixel.pos.w;

// Pixel shader used to compute an RGBA color at a given pixel position
float4 pixel_shader_halftone(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float3 linear_color = decode_gamma(source_sample.rgb);

    float luminance = dot(linear_color, float3(0.299, 0.587, 0.114));
    float3 result = luminance.xxx;

    return float4(encode_gamma(result), source_sample.a);
    //return float4(encode_gamma(result), source_sample.a);
    //return float4(pixel.pos.x/500.0, pixel.pos.y/200.0, 1.0, 1.0);
}

/*{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float level = round(source_sample.r + source_sample.g + source_sample.b) / 3.0;
    return float4(level, level, level, source_sample.a);
}*/


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


