// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d

// Constants
#define PI 3.141592653589793238

// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture

// Size of the source picture
uniform int width;
uniform int height;

// General properties
uniform float gamma = 1.0;
uniform float gamma_shift = 0.6;
uniform float amplitude = 0.2;
uniform float scale = 8.0;
uniform int number_of_color_levels = 4.0;

// Color space mode: 0:luminance, 1:RGB, 2:CMYK, 3:CMY
//uniform int color_mode = 1;

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
pixel_data vertex_shader_halftone(vertex_data vertex)
{
    pixel_data pixel;
    pixel.pos = mul(float4(vertex.pos.xyz, 1.0), ViewProj);
    pixel.uv  = vertex.uv;
    return pixel;
}

float3 decode_gamma(float3 color, float exponent, float shift)
{
    return pow(color, exponent - shift);
}

float3 encode_gamma(float3 color, float exponent)
{
    return pow(color, 1.0/exponent);
}

/*
float4 rgb_to_cmyk(float3 color)
{
	float k = 1.0 - max(max(color.r, color.g), color.b);
    float3 k3 = (1.0 - k).xxx;
	return float4((k3-color.rgb)/(1-k), k);
}

float3 cmyk_to_rgb(float4 color)
{
    float3 k3 = (1.0 - color.a).xxx;
	return ((1.0).xxx - color.rgb) * k3;
}

float4 rgb2cmyki(float3 c)
{
	float k = max(max(c.r, c.g), c.b);
	return min(float4(c.rgb / k, k), 1.0);
}

float3 cmyki2rgb(float4 c)
{
	return c.rgb * c.a;
}

float4 convert_to_processing_space(float3 color)
{
    if (color_mode==0)
        return float4(dot(color, float3(0.299, 0.587, 0.114)).xxx, 0.0);
    else if (color_mode==2)
        return rgb_to_cmyk(color);
        //return rgb2cmyki(color);
    else if (color_mode==3)
        return float4((1.0).xxx - color, 0.0);

    return float4(color, 0.0);
}

float3 convert_from_processing_space(float4 color)
{
    if (color_mode==0 || color_mode==1)
        return color.rgb;
    else if (color_mode==2)
        return cmyk_to_rgb(color);
        //return cmyki2rgb(color);
    else if (color_mode==3)
        return float4((1.0).xxx - color.rgb, 0.0);

    return color.rgb;
}
*/

float3 linear_perturbation(float2 position)
{
    if (pattern_size.x>0)
    {
        float2 pattern_uv = position / pattern_size;
        float4 pattern_sample = pattern_texture.Sample(linear_wrap, pattern_uv / scale);
        return 2.0*(decode_gamma(pattern_sample.rgb, pattern_gamma, 0.0) - (0.5).xxx);
    }
    else
        return cos(PI*position.x/scale/4.0) * cos(PI*position.y/scale/4.0);
}

/*
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

    float3x3 XYZ =  {0.4124, 0.3576, 0.1805,
                     0.2126, 0.7152, 0.0722,
                     0.0193, 0.1192, 0.9505};

    float3x3 XYZT = {0.4124564, 0.2126729, 0.0193339,
                     0.3575761, 0.7151522, 0.1191920,
                     0.1804375, 0.0721750, 0.9503041};
*/

float3 rgb2xyz( float3 c ) {
    float3 tmp;
    tmp.x = ( c.r > 0.04045 ) ? pow( ( c.r + 0.055 ) / 1.055, 2.4 ) : c.r / 12.92;
    tmp.y = ( c.g > 0.04045 ) ? pow( ( c.g + 0.055 ) / 1.055, 2.4 ) : c.g / 12.92,
    tmp.z = ( c.b > 0.04045 ) ? pow( ( c.b + 0.055 ) / 1.055, 2.4 ) : c.b / 12.92;
    const float3x3 mat = float3x3(
		0.4124, 0.3576, 0.1805,
        0.2126, 0.7152, 0.0722,
        0.0193, 0.1192, 0.9505 
	);
    return 100.0 * mul(tmp, mat);
}

float3 xyz2lab( float3 c ) {
    float3 n = c / float3(95.047, 100, 108.883);
    float3 v;
    v.x = ( n.x > 0.008856 ) ? pow( n.x, 1.0 / 3.0 ) : ( 7.787 * n.x ) + ( 16.0 / 116.0 );
    v.y = ( n.y > 0.008856 ) ? pow( n.y, 1.0 / 3.0 ) : ( 7.787 * n.y ) + ( 16.0 / 116.0 );
    v.z = ( n.z > 0.008856 ) ? pow( n.z, 1.0 / 3.0 ) : ( 7.787 * n.z ) + ( 16.0 / 116.0 );
    return float3(( 116.0 * v.y ) - 16.0, 500.0 * ( v.x - v.y ), 200.0 * ( v.y - v.z ));
}

float3 rgb2lab( float3 c ) {
    float3 lab = xyz2lab( rgb2xyz( c ) );
    return float3( lab.x / 100.0, 0.5 + 0.5 * ( lab.y / 127.0 ), 0.5 + 0.5 * ( lab.z / 127.0 ));
}


float3 get_closest_color(float3 color)
{
    if (palette_size.x>0)
    {
        float min_distance = 1e10;
        float3 result = {0.0, 0.0, 0.0};
        float2 pixel_size = (1.0).xx / min(256, palette_size);
        for (float u=pixel_size.x/2.0; u<1.0; u+=pixel_size.x)
            for (float v=pixel_size.y/2.0; v<1.0; v+=pixel_size.y)
            {
                float4 palette_sample = palette_texture.Sample(point_clamp, float2(u, v));
                float3 linear_palette_color = decode_gamma(palette_sample.rgb, palette_gamma, 0.0);

                //float3 difference = linear_palette_color - color;
                //float current_distance = dot(difference, difference*float3(0.299, 0.587, 0.114));

                //float current_distance = distance(mul(XYZ, color), mul(XYZ, linear_palette_color));
                float current_distance = distance(color, linear_palette_color);
                //current_distance = distance(rgb2lab(color), rgb2lab(linear_palette_color));
                if (current_distance < min_distance)
                {
                    result = linear_palette_color;
                    min_distance = current_distance;
                }
            }
        return result;
    }
    else
        return round((number_of_color_levels-1)*color)/(number_of_color_levels-1);
}

// Pixel shader used to compute an RGBA color at a given pixel position
float4 pixel_shader_halftone(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float3 linear_color = decode_gamma(source_sample.rgb, gamma, gamma_shift);

    float2 position = pixel.uv * float2(width, height);
    float3 perturbation = linear_perturbation(position);

    float3 result = clamp(linear_color + amplitude*perturbation, 0.0, 1.0);

    result = get_closest_color(result);

    return float4(encode_gamma(result, gamma), source_sample.a);
}


technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_halftone(vertex);
        pixel_shader  = pixel_shader_halftone(pixel);
    }
}
