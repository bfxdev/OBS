// OBS-compliant effect file to filter video source without transformation, used for tests
// See https://obsproject.com/docs/graphics.html

#define SamplerState sampler_state
#define Texture2D texture2d

// View-projection matrix set by OBS (required)
uniform float4x4 ViewProj;

// Texture containing source picture set by OBS (required)
uniform Texture2D image;

uniform int width;
uniform int height;

uniform Texture2D texture_data;
uniform int texture_width;
uniform int texture_height;
uniform float texture_scale = 0.1;

// Definition of the processing of the input texture
// See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc
// Filter: one of Anisotropy / Point / Linear
// AddressU, AddressV: one of Wrap / Clamp / Mirror / Border / MirrorOnce
// BorderColor: to be used with Border on edges, e.g. 00000000
SamplerState linear_clamp
{
    Filter    = Linear; 
    AddressU  = Clamp;
    AddressV  = Clamp;
};

SamplerState linear_wrap
{
    Filter    = Linear; 
    AddressU  = Wrap;
    AddressV  = Wrap;
};


// Helper structure used as input/output for vertex and fragment shaders
// For each call of a shader, pos contains the integer pixel position of the current pixel
// and uv the interpolated texture position in the image texture
struct shader_data
{
	float4 pos : POSITION;
	float2 uv  : TEXCOORD0;
};

// Default vertex shader used to position the rendered texture at its correct position
// on the display by multiplying with the view-projection matrix
shader_data vertex_shader_default(shader_data cur)
{
    // Prepares output structure
    shader_data res;

    // Applies the 3D transformation in homogeneous coordinates
    res.pos = mul(float4(cur.pos.xyz, 1.0), ViewProj);

    // Passes the UV coordinates through
    res.uv  = cur.uv;

    // Returns the result for processin by the graphics pipeline
    return res;
}

// Pass-through pixel shader
float4 pixel_shader_identity(shader_data cur) : TARGET
{
    return image.Sample(linear_clamp, cur.uv);
}

// Black-and-white pixel shader
float4 pixel_shader_luminance(shader_data cur) : TARGET
{
    float4 smp = image.Sample(linear_clamp, cur.uv);
    float luminance = 0.299*smp.r + 0.587*smp.g + 0.114*smp.b;

    float2 tsize = float2(texture_width, texture_height);
    float2 tpos = fmod(cur.uv*float2(width, height), tsize)/(tsize*texture_scale);
    float level = texture_data.Sample(linear_wrap, tpos).r;

    luminance = step((level+0.5)/2.0, luminance);

    return float4(luminance, luminance, luminance, smp.a);
}

technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_default(cur);
        pixel_shader  = pixel_shader_luminance(cur);
    }
}


