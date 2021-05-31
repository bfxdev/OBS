////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                    //
//                                 Pixel Art Filter for OBS - Development effect file                                 //
//                                                   bfxdev - 2021                                                    //
//                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Constants
#define PI 3.141592653589793238

// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d

// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture

// Size of the source picture
uniform int width;
uniform int height;

// Pixelation properties
int pixelation_algorithm = 1;
int pixelation_type = 1;
int2 pixelation_block_size = {2,2};
int2 pixelation_resolution = {320,200};


/*
// General properties
uniform float gamma = 1.0;
uniform float gamma_shift = 0.6;


// Pattern texture
uniform Texture2D pattern_texture;
uniform float2 pattern_size = {-1.0, -1.0};
uniform float pattern_gamma = 1.0;

// Palette texture
uniform Texture2D palette_texture;
uniform float2 palette_size = {-1.0, -1.0};
uniform float palette_gamma = 1.0;
*/

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
    Filter    = Linear; 
    AddressU  = Wrap;
    AddressV  = Wrap;
};

SamplerState point_clamp
{
    Filter    = Point; 
    AddressU  = Clamp;
    AddressV  = Clamp;
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
pixel_data vertex_shader_standard(vertex_data vertex)
{
    pixel_data pixel;
    pixel.pos = mul(float4(vertex.pos.xyz, 1.0), ViewProj);
    pixel.uv  = vertex.uv;
    return pixel;
}

/*
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
    if (pattern_size.x>0)
    {
        float2 pattern_uv = position / pattern_size;
        float4 pattern_sample = pattern_texture.Sample(linear_wrap, pattern_uv);
        float3 linear_color = decode_gamma(pattern_sample.rgb, pattern_gamma, 0.0);
        return float4(2.0*(linear_color-0.5), pattern_sample.a);
    }
    else
        return 0.5;
}

float4 get_closest_color(float3 input_color)
{
    float4 result;
    if (palette_size.x>0)
    {
        float min_distance = 1e10;
        float2 pixel_size = 1.0 / min(256, palette_size);
        for (float u=pixel_size.x/2.0; u<1.0; u+=pixel_size.x)
            for (float v=pixel_size.y/2.0; v<1.0; v+=pixel_size.y)
            {
                float4 palette_sample = palette_texture.Sample(point_clamp, float2(u, v));
                float3 linear_color = decode_gamma(palette_sample.rgb, palette_gamma, 0.0);

                float current_distance = distance(input_color, linear_color);
                if (current_distance < min_distance)
                {
                    result = float4(linear_color, palette_sample.a);
                    min_distance = current_distance;
                }
            }
    }
    else
        result = 1.0;

    return result;
}

float4 pixel_shader_halftone(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float3 linear_color = decode_gamma(source_sample.rgb, gamma, gamma_shift);

    float2 position = pixel.uv * float2(width, height);
    float4 perturbation = get_perturbation(position);

    float3 perturbed_color = linear_color + perturbation.rgb;

    float4 closest_color = get_closest_color(clamp(perturbed_color, 0.0, 1.0));

    float mix_alpha = perturbation.a * closest_color.a;
    float3 mixed_color = lerp(source_sample.rgb, closest_color.rgb, mix_alpha);

    return float4(encode_gamma(mixed_color, gamma), source_sample.a);
}
*/

float4 pixel_shader_passthrough(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);

    return source_sample;
}


technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_standard(vertex);
        pixel_shader  = pixel_shader_passthrough(pixel);
    }
}
