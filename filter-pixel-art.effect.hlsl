////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                Effect file for the OBS Pixel Art Plugin - By bfxdev - https://github.com/bfxdev - 2020             //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////  GLOBALS  //////////////////////////////////////////////////////

// Maximum number of color in a palette by list of colors, same value used in the Lua code
#define MAX_PALETTE_LENGTH 64

// View-projection matrix, set by OBS
uniform float4x4 ViewProj;

// Texture containing the source picture, set by OBS
uniform texture2d image;

uniform int palette_type;
uniform int palette_length;


// Definition of the palette variables
uniform float4 palette_color_1;  uniform float4 palette_color_2;  uniform float4 palette_color_3;
uniform float4 palette_color_4;  uniform float4 palette_color_5;  uniform float4 palette_color_6;
uniform float4 palette_color_7;  uniform float4 palette_color_8;  uniform float4 palette_color_9;
uniform float4 palette_color_10; uniform float4 palette_color_11; uniform float4 palette_color_12;
uniform float4 palette_color_13; uniform float4 palette_color_14; uniform float4 palette_color_15;
uniform float4 palette_color_16; uniform float4 palette_color_17; uniform float4 palette_color_18;
uniform float4 palette_color_19; uniform float4 palette_color_20; uniform float4 palette_color_21;
uniform float4 palette_color_22; uniform float4 palette_color_23; uniform float4 palette_color_24;
uniform float4 palette_color_25; uniform float4 palette_color_26; uniform float4 palette_color_27;
uniform float4 palette_color_28; uniform float4 palette_color_29; uniform float4 palette_color_30;
uniform float4 palette_color_31; uniform float4 palette_color_32; uniform float4 palette_color_33;
uniform float4 palette_color_34; uniform float4 palette_color_35; uniform float4 palette_color_36;
uniform float4 palette_color_37; uniform float4 palette_color_38; uniform float4 palette_color_39;
uniform float4 palette_color_40; uniform float4 palette_color_41; uniform float4 palette_color_42;
uniform float4 palette_color_43; uniform float4 palette_color_44; uniform float4 palette_color_45;
uniform float4 palette_color_46; uniform float4 palette_color_47; uniform float4 palette_color_48;
uniform float4 palette_color_49; uniform float4 palette_color_50; uniform float4 palette_color_51;
uniform float4 palette_color_52; uniform float4 palette_color_53; uniform float4 palette_color_54;
uniform float4 palette_color_55; uniform float4 palette_color_56; uniform float4 palette_color_57;
uniform float4 palette_color_58; uniform float4 palette_color_59; uniform float4 palette_color_60;
uniform float4 palette_color_61; uniform float4 palette_color_62; uniform float4 palette_color_63;
uniform float4 palette_color_64;

uniform int4 palette_range;
uniform float3 palette_min;
uniform float3 palette_max;

uniform texture2d palette;






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

float4 pixel_shader_luminance(shader_data cur) : TARGET
{
    float4 smp = image.Sample(linear_clamp, cur.uv);
    float luminance = 0.299*smp.r + 0.587*smp.g + 0.114*smp.b;
    return float4(luminance, luminance, smp.r, smp.a);
}


////////////////////////////////////////////////////  TECHNIQUES  ////////////////////////////////////////////////////

technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_default(cur);
        pixel_shader  = pixel_shader_luminance(cur);
    }
}
