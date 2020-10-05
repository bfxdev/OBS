////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                Effect file for the OBS Pixel Art Plugin - By bfxdev - https://github.com/bfxdev - 2020             //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////  GLOBALS  //////////////////////////////////////////////////////

// Global definitions from Lua code
#define MAX_PALETTE_LENGTH 64
#define PALETTE_LIST 1
#define PALETTE_MODEL 2

// View-projection matrix, set by OBS
uniform float4x4 ViewProj;

// Texture containing the source picture, set by OBS
uniform texture2d image;

// General palette parameter
uniform int palette_type = PALETTE_LIST;

// Palette defined as lisz of colors
uniform int palette_length;
uniform texture2d palette_list;

// Palette defined as model
uniform int4 palette_range;
uniform float3 palette_min;
uniform float3 palette_max;

// Helper structure used as input/output of the vertex shader and as input of the pixel shader
struct shader_data
{
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

// Definition of the processing of the input texture
// See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc
sampler_state linear_clamp
{
	AddressU  = Clamp;
	AddressV  = Clamp;
	Filter    = Linear;
	//BorderColor = 00000000;
};

//////////////////////////////////////////////////  HELPER FUNCTIONS  //////////////////////////////////////////////////

// Transformation RGB -> HSV
float3 rgb2hsv(float3 c)
{
    float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
    float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// Transformation HSV -> RGB
float3 hsv2rgb(float3 c)
{
    float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    float3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
}

// Fit function (???)
float fit(float v, int factor)
{
    return round(v * factor) / factor;
}


///////////////////////////////////////////////////  VERTEX SHADERS  ///////////////////////////////////////////////////

// Default vertex shader used to adapt virtual triangle coordinates to location
// of output picture as set by OBS, and to pass the UV coordinates unchanged
shader_data vertex_shader_default(shader_data cur)
{
    shader_data res;
    res.pos = mul(float4(cur.pos.xyz, 1.0), ViewProj);
    res.uv  = cur.uv;
    return res;
}


///////////////////////////////////////////////////  PIXEL SHADERS  ////////////////////////////////////////////////////

// Outputs luminance of the input pixel
float4 pixel_shader_luminance(shader_data cur) : TARGET
{
    float4 smp = image.Sample(linear_clamp, cur.uv);
    float luminance = 0.299*smp.r + 0.587*smp.g + 0.114*smp.b;
    return float4(luminance, luminance, luminance, smp.a);
}

float4 pixel_shader_color_reduction(shader_data cur) : TARGET
{
    float4 smp = image.Sample(linear_clamp, cur.uv);



    float luminance = 0.299*smp.r + 0.587*smp.g + 0.114*smp.b;
    return float4(smp.g, smp.r, smp.b, smp.a);
}




////////////////////////////////////////////////////  TECHNIQUES  ////////////////////////////////////////////////////

technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_default(cur);
        pixel_shader  = pixel_shader_color_reduction(cur);
    }
}
