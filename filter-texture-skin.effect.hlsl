// View-projection matrix, set by OBS
uniform float4x4 ViewProj;

// Texture containing the source picture, set by OBS
uniform texture2d image;
uniform float width = 320.0;
uniform float height = 200.0;

// Constants
#define PI 3.14159265
#define MAX_ITERRATIONS 50

// Time
uniform float time = 0.0;

// Opacity (alpha) of original picture (non-detected parts)
uniform float unprocessed_alpha = 0.5;

// HSV thresholds
uniform float hue_min = 0.0;
uniform float hue_max = 1.0;
uniform float saturation_min = 0.0;
uniform float saturation_max = 1.0;
uniform float value_min = 0.0;
uniform float value_max = 1.0;

// Outline mode 0:nothing, 1: Solid color, 2: Smooth
uniform int outline_mode = 2;
uniform float4 outline_color = {1.0, 0.1, 0.1, 1.0};
uniform float outline_size = 2.0;
uniform float outline_color_mix_ratio = 1.0;

// Effect mode 0:nothing, 1: Jiggle, 2: Texture flat static, 3: Texture rounded static, 4: Texture rounded moving
uniform int effect_mode = 2;

// Deformation
uniform float jiggle_radius = 20.0;
uniform float jiggle_speed = 3.0;

// Texture for skin replacement
uniform texture2d texture_data;
uniform int texture_width = 1;
uniform int texture_height = 1;
uniform float texture_scale = 1.0;
uniform int texture_scan_size = 1.0;

 // Helper structure used as input/output of the vertex shader and as input of the pixel shader
struct shader_data
{
  float4 pos : POSITION;
  float2 uv  : TEXCOORD0;
};

// Definition of the processing of the input texture
// See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc
sampler_state linear_wrap
{
  AddressU  = Wrap;
  AddressV  = Wrap;
  Filter    = Linear;
  //BorderColor = 00000000;
};

sampler_state linear_clamp
{
  AddressU  = Clamp;
  AddressV  = Clamp;
  Filter    = Linear;
  //BorderColor = 00000000;
};

// RGB to HSV, ranges [0, 1]
float3 rgb2hsv(float3 c)
{
  float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
  float4 p = lerp(float4(c.bg, K.wz), float4(c.gb, K.xy), step(c.b, c.g));
  float4 q = lerp(float4(p.xyw, c.r), float4(c.r, p.yzx), step(p.x, c.r));

  float d = q.x - min(q.w, q.y);
  float e = 1.0e-10;
  return float3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// Default vertex shader used to adapt virtual triangle coordinates to location
// of output picture as set by OBS, and to pass the UV coordinates unchanged
shader_data vertex_shader_default(shader_data cur)
{
  shader_data res;
  res.pos = mul(float4(cur.pos.xyz, 1.0), ViewProj);
  res.uv  = cur.uv;
  return res;
}

// Returns true if the given RGBA is in HSV ranges
bool detected(float4 rgba)
{
  float3 hsv = rgb2hsv(rgba.rgb);
  return ((hue_min        <= hsv.x && hsv.x <= hue_max && hue_min<hue_max) || 
          (hue_max        <= hsv.x && hsv.x <= hue_min && hue_max<hue_min)) &&
           saturation_min <= hsv.y && hsv.y <= saturation_max &&
           value_min      <= hsv.z && hsv.z <= value_max;
}

// Pixel shader to map texture on pixels with particular HSV levels
float4 pixel_shader_texture_skin(shader_data cur) : TARGET
{
  // Gets current pixel color and transforms it to HSV
  float4 smp = image.Sample(linear_wrap, cur.uv);

  // Detects if color is in detection range
  if (detected(smp))
  {
    // Searches closest edge
    bool edge_found = false;
    float edge_radius = 0;
    float edge_angle = 0;
    int i;
    if (outline_mode>0)
      for(i=0; i<MAX_ITERRATIONS && edge_radius<outline_size && !edge_found; i++)
      {
        // Scans in a spiral around detected point for edges of detected zone
        edge_angle = i*2.0*PI/9.6;
        edge_radius = edge_angle/(2.0*PI);
        float2 posuv = cur.uv + float2(edge_radius*cos(edge_angle)/width, edge_radius*sin(edge_angle)/height);
        edge_found = !detected(image.Sample(linear_clamp, posuv));
      }

    // Searches closest edges in X and Y for shape-shifting
    float2 edge_distance = {0.0, 0.0};
    bool edge_x_found = false, edge_y_found = false;
    if (effect_mode>=3)
      for(i=1; i<MAX_ITERRATIONS && i<texture_scan_size && !edge_x_found && !edge_y_found; i++)
      {
        // Scans in a line for edge of detected zone in X direction
        if (!edge_x_found)
          if (!detected(image.Sample(linear_clamp, cur.uv + float2(i/width, 0.0))))
            {edge_distance.x = texture_scan_size-i; edge_x_found=true;}
          else if (!detected(image.Sample(linear_clamp, cur.uv + float2(-i/width, 0.0))))
            {edge_distance.x = i-texture_scan_size; edge_x_found=true;}

        // Scans in a line for edge of detected zone in Y direction
        if (!edge_y_found)
          if (!detected(image.Sample(linear_clamp, cur.uv + float2(0.0, i/height))))
            {edge_distance.y = texture_scan_size-i; edge_y_found=true;}
          else if (!detected(image.Sample(linear_clamp, cur.uv + float2(0.0, -i/height))))
            {edge_distance.y = i-texture_scan_size; edge_y_found=true;}
      }
    

    // Returns outline color if boundary found
    float4 original_smp = smp;
    if (outline_mode==1 && edge_found)
    {
      smp = lerp(smp, outline_color, outline_color_mix_ratio);
    }
    // Jiggle
    else if(effect_mode==1)
    {
      float angle = time*jiggle_speed;
      float radius = jiggle_radius*cos(angle*4.32123);
      float2 posuv = cur.uv + float2(radius*cos(angle)/width, radius*sin(angle)/height);
      smp = image.Sample(linear_clamp, posuv);
    }
    // Texture
    else if (effect_mode>=2)
    {
      // Pixel position in texture relative to current position with wrap (in sampler settings)
      float2 pos = cur.uv*float2(width, height);

      // Texture rounded
      if (effect_mode>=3)
      {
        float2 ratio = edge_distance/texture_scan_size;
        float2 offset = sign(edge_distance)*(exp(4.0*abs(ratio))-1.0);

        if (effect_mode==4)
        {
          // If edge was detected, starts texture from edge (moving with edge)
          if (edge_x_found) pos.x = offset.x;
          if (edge_y_found) pos.y = offset.y;
        }
        else
          // Rounds texture when edge is near
          pos += offset;
      }

      smp = texture_data.Sample(linear_wrap, pos / float2(texture_width, texture_height) / texture_scale);
    }


    // Smooth
    if (outline_mode==2 && edge_found)
      smp = lerp(lerp(original_smp, smp, edge_radius/outline_size), outline_color,
                      outline_color_mix_ratio*(1.0-abs(2.0*edge_radius/outline_size-1.0)));
  }
  else
    smp.a *= unprocessed_alpha;

  return smp;
}

technique Draw
{
  pass
  {
    vertex_shader = vertex_shader_default(cur);
    pixel_shader  = pixel_shader_texture_skin(cur);
  }
}
