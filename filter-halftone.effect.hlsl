
// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d

// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture

/*

uniform int width;
uniform int height;

uniform float gamma = 1.0;
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

// Helper structure used as input/output argument for vertex and fragment shaders
struct shader_data
{
    float4 pos : POSITION;  // Homogeneous coordinates XYZW
    float2 uv  : TEXCOORD0; // UV coordinates in a texture
};

// Default vertex shader used to compute position of rendered pixels and pass UV
shader_data vertex_shader_default(shader_data cur)
{
    shader_data res;
    res.pos = mul(float4(cur.pos.xyz, 1.0), ViewProj);
    res.uv  = cur.uv;
    return res;
}

// Specific pixel shader for the halftone effect
float4 pixel_shader_halftone(shader_data cur) : TARGET
{
    float4 smp = image.Sample(linear_clamp, cur.uv);
    float level = round(smp.r + smp.g + smp.b) / 3.0;
    return float4(level, level, level, smp.a);
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
        vertex_shader = vertex_shader_default(cur);
        pixel_shader  = pixel_shader_halftone(cur);
    }
}


