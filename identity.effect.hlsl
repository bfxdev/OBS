// OBS-compliant effect file to filter video source without transformation, used for tests
// See https://obsproject.com/docs/graphics.html

// View-projection matrix set by OBS (required)
uniform float4x4 ViewProj;

// Texture containing source picture set by OBS (required)
uniform texture2d image;

// Definition of the processing of the input texture
// See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc
// Filter: one of Anisotropy / Point / Linear
// AddressU, AddressV: one of Wrap / Clamp / Mirror / Border / MirrorOnce
// BorderColor: to be used with Border on edges, e.g. 00000000
sampler_state linear_clamp
{
    Filter    = Linear; 
    AddressU  = Clamp;
    AddressV  = Clamp;
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
    return float4(luminance, luminance, luminance, smp.a);
}

technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_default(cur);
        pixel_shader  = pixel_shader_identity(cur);
    }
}
