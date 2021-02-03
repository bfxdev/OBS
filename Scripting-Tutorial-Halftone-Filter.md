
# Scripting Tutorial Halftone Filter

This tutorial describes the implementation of a "halftone" filter as a Lua script for OBS. Such a filter appears in the list of filters and can be added as part of a filter chain to any video source. As effect, the filter mimics the [halftone technique](https://en.wikipedia.org/wiki/Halftone), used for printing with a reduced set of ink colors arranged in patterns. It is based on [dithering](https://en.wikipedia.org/wiki/Dither) with a carefully designed texture.

## First part - 4 Shades of Grey

The tutorial is divided into two parts. In this first part, we create a minimal script that implements a simple rendering effect. Such a script with its effect file can be easily re-used as starting point for new projects.

### Script creation

Similarly to the [Source Shake tutorial](https://github.com/obsproject/obs-studio/wiki/Scripting-Tutorial-Source-Shake), create a script file named `filter-halftone.lua` with this content:

``` Lua
obs = obslua

-- Returns the description displayed in the Scripts window
function script_description()
  return [[<center><h2>Halftone Filter</h2></center>
  <p>This Lua script adds a video filter named <it>Halftone</it>. The filter can be added
  to a video source to reduce the number of colors of the input picture. It reproduces
  the style of a magnified printed picture.</p>]]
end
```

Add the new script in the _Scripts_ window, the description should appear (with no properties).

### Registering a first source info structure

Sources are supported in Lua through the [`source_info` structure](https://obsproject.com/docs/scripting.html#script-sources-lua-only). It is defined as a usual Lua table containing a set of mandatory keys referencing values and functions that mimic a subset of the [C `obs_source_info` structure](https://obsproject.com/docs/reference-sources.html?highlight=source_info#c.obs_source_info).

The `source_info` structure is registered using [`obs_register_source`](https://obsproject.com/docs/reference-sources.html#c.obs_register_source). OBS will use the structure to create the internal data and settings when the filter is added to an existing video source. A filter has its own independent set of properties and data settings, i.e. an instance of such settings exists for each filter instance. OBS manages the filter creation, destruction and the persistent storage of its settings.

Let's create the source info structure for a video filter with a minimal set of values and functions. It is typically registered in `script_load`:

``` Lua
-- Called on script startup
function script_load(settings)
  obs.obs_register_source(source_info)
end

-- Definition of the global variable containing the source_info structure
source_info = {}
source_info.id = 'filter-halftone'              -- Unique string identifier of the source type
source_info.type = obs.OBS_SOURCE_TYPE_FILTER   -- INPUT or FILTER or TRANSITION
source_info.output_flags = obs.OBS_SOURCE_VIDEO -- Combination of VIDEO/AUDIO/ASYNC/etc

-- Returns the name displayed in the list of filters
source_info.get_name = function()
  return "Halftone"
end
```

Add the code, refresh the script, then choose a source (here a colorful picture of the VR game Anceder) and display the _Filter_ dialog window for the source (e.g. _Filters_ in the context menu of the source). Click on <kbd>+</kbd> and the name _Halftone_ should appear in the list of filters:

![filter halftone list](images/scripting/filter-halftone-list.png)

Add the new _Halftone_ filter. For now the filter has no effect because the `source_info.create` function is not defined.

### Effect compilation and rendering

Lua would not be fast enough for video processing so the filter is based on GPU computation. A GPU can be programmed through "shaders" compiled by the graphics device driver from [GLSL](https://en.wikipedia.org/wiki/OpenGL_Shading_Language) for OpenGL or [HLSL](https://en.wikipedia.org/wiki/High-Level_Shading_Language) in the MS Windows world. OBS relies on HLSL and expects shader code in the so-called [effect files](https://obsproject.com/docs/graphics.html).

An effect can be compiled from a file with [`gs_effect_create_from_file`](https://obsproject.com/docs/reference-libobs-graphics-effects.html#c.gs_effect_create_from_file) or from a string with [`gs_effect_create`](https://obsproject.com/docs/reference-libobs-graphics-effects.html#c.gs_effect_create), and is destroyed with [`gs_effect_destroy)`](https://obsproject.com/docs/reference-libobs-graphics-effects.html#c.gs_effect_destroy). Like other graphic functions in OBS, manipulating effects needs to occur in the [graphics context](https://obsproject.com/docs/graphics.html#the-graphics-context). This is ensured by calling [`obs_enter_graphics`](https://obsproject.com/docs/reference-core.html#c.obs_enter_graphics) and then [`obs_leave_graphics`](https://obsproject.com/docs/reference-core.html#c.obs_leave_graphics) when everything is done.

The compilation is typically implemented in the [`source_info.create`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.create) function and resources are released in the [`source_info.destroy`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.destroy) function. `source_info.create` returns a Lua table containing custom data used for the filter instance. Most functions of the `source_info` structure will provide this Lua table passed as an argument, so this is where you want to store any custom data needed by the filter. Please note that if `source_info.create` returns `nil`, then the filter initialization is considered failed (and logged accordingly).

Add this code to the Lua script:

``` Lua
-- Creates the implementation data for the source
source_info.create = function(settings, source)

  -- Initializes the custom data table
  local data = {}
  data.source = source -- Keeps a reference to this filter as a source object
  data.width = 1       -- Dummy value during initialization phase
  data.height = 1      -- Dummy value during initialization phase

  -- Compiles the effect
  obs.obs_enter_graphics()
  local effect_file_path = script_path() .. 'filter-halftone.effect.hlsl'
  data.effect = obs.gs_effect_create_from_file(effect_file_path, nil)
  obs.obs_leave_graphics()

  -- Calls the destroy function if the effect was not compiled properly
  if data.effect == nil then
    obs.blog(obs.LOG_ERROR, "Effect compilation failed for " .. effect_file_path)
    source_info.destroy(data)
    return nil
  end

  return data
end

-- Destroys and release resources linked to the custom data
source_info.destroy = function(data)
  if data.effect ~= nil then
    obs.obs_enter_graphics()
    obs.gs_effect_destroy(data.effect)
    data.effect = nil
    obs.obs_leave_graphics()
  end
end
```

The effect file `filter-halftone.effect.hlsl` is mentioned in the code, it will defined in the next section. Please note that the `source` argument of the function `source_info.create` is a reference to the current instance of the filter as a source object (almost everything is a source in OBS). This reference, as well as the variables `width` and `height`, initialized with dummy values, are used in the rendering function.

Namely, the function [`source_info.video_render`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.video_render) is called each frame to render the output of the filter in the graphics context (no need to call `obs_enter_graphics`). To render an effect, first [`obs_source_process_filter_begin`](https://obsproject.com/docs/reference-sources.html#c.obs_source_process_filter_begin) is called, then the effect parameters can be set, and then [`obs_source_process_filter_end`](https://obsproject.com/docs/reference-sources.html#c.obs_source_process_filter_end) is called to draw.

Determining the width and height to pass to `obs_source_process_filter_end` is somehow tricky in OBS, because the filter is itself in a chain of filters, where the resolution could theoretically change at any stage. The usual method is to retrieve the "parent source" of the filter with [`obs_filter_get_parent`](https://obsproject.com/docs/reference-sources.html#c.obs_filter_get_parent), i.e. "the source being filtered", and then to use the so far undocumented functions `obs_source_get_base_width` and `obs_source_get_base_height`. Note that some filters reference the next source in the chain using `obs_filter_get_target`, not the source being filtered (it may make a difference depending on the use case).

In addition, two additional functions `source_info.get_width` and `source_info.get_height` must be defined to provide the values to OBS whenever necessary. The functions will re-use the values determined in `source_info.video_render`.

The effect rendering code looks like:

``` Lua
-- Returns the width of the source
source_info.get_width = function(data)
  return data.width
end

-- Returns the height of the source
source_info.get_height = function(data)
  return data.height
end

-- Called when rendering the source with the graphics subsystem
source_info.video_render = function(data)
  local parent = obs.obs_filter_get_parent(data.source)
  data.width = obs.obs_source_get_base_width(parent)
  data.height = obs.obs_source_get_base_height(parent)

  obs.obs_source_process_filter_begin(data.source, obs.GS_RGBA, obs.OBS_NO_DIRECT_RENDERING)

  -- Effect parameters initialization goes here

  obs.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end
```

Add the code blocks to the Lua script, but no need to reload for now, the effect file is still missing.

### Simple HLSL luminance effect file

The Lua code is in place, now create a new file called `filter-halftone.effect.hlsl` in the same directory as the Lua script.

:warning: The extension `.hlsl` is chosen such that a code editor or an IDE recognizes directly that it is HLSL code. As the parser of OBS may miss unbalanced brackets or parenthesis (and say nothing about it in the logs), it is very important to have syntax checking in the editor.

An [effect file](https://docs.microsoft.com/en-us/windows/win32/direct3d11/d3d11-effect-format) follows a strict syntax and structure. It is a mix of static data definitions and code. These constraints are necessary to allow the compilation for the GPU and the massively parallel execution. The various parts are described below.

Our effect file starts with macro definitions that will allow writing HLSL-compliant code instead of the effect dialect understood by OBS, in order to support a full syntax check in the IDE. Indeed, the keywords `sampler_state` and `texture2d` are specific to effects in OBS. Using such macros is of course not mandatory (and not so common looking at other OBS effect files):

``` HLSL
// OBS-specific syntax adaptation to HLSL standard to avoid errors reported by the code editor
#define SamplerState sampler_state
#define Texture2D texture2d
```

Then the two mandatory `uniform` parameters required by OBS are defined. The values of these parameters will be set transparently by OBS according to the input picture of the source being filtered set in `image`, and the "View-Projection Matrix" `ViewProj` used to compute the screen coordinates where the filtered picture will be drawn:

``` HLSL
// Uniform variables set by OBS (required)
uniform float4x4 ViewProj; // View-projection matrix used in the vertex shader
uniform Texture2D image;   // Texture containing the source picture
```

The next definition is a "[sampler state](https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc)". It defines how to sample colors from pixels in a texture, i.e. how to interpolate colors between two pixels (Linear) or just to take the next neighbor (Point), and how to behave in the the pixel coordinates are outside of the texture, i.e. take the pixels from the nearest edge (Clamp), wrap around (Wrap) or mirror the texture over the edges (Mirror). The [supported values for sampler states](https://obsproject.com/docs/graphics.html#effect-sampler-states) are documented in the OBS API reference.

We define a simple linear clamp sampler state that will be used in the pixel shader:

``` HLSL
// Interpolation method and wrap mode for sampling a texture
SamplerState linear_clamp
{
    Filter    = Linear;     // Anisotropy / Point / Linear
    AddressU  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    AddressV  = Clamp;      // Wrap / Clamp / Mirror / Border / MirrorOnce
    BorderColor = 00000000; // Used only with Border edges (optional)
};
```

After that, two very specific data structures are defined to specify which parameters are given to the vertex shader, and passed from the vertex shader to the pixel shader. In this tutorial these structures are artificially separated for better understanding and more generality. In most effects, both structures are defined in only one structure.

The structures require for each parameter a [semantics](https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-semantics) identifier giving the intended use of the parameter. [Supported semantics](https://obsproject.com/docs/graphics.html#effect-vertex-pixel-semantics) are documented in the OBS API reference. Semantics are necessary for the graphics pipeline of the GPU:

``` HLSL
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
```

Before going further, some words about the classical 3D rendering pipeline. Roughly speaking, it comprises these main steps:

- The application, here OBS, set-ups all data structures (textures, data parameters, arrays, etc) necessary for the computation and then feeds the 3D coordinates of triangles into the vertex shader together with various vertex attributes such as UV coordinate of the vertex mapped to a texture or a color assigned to this vertex, all part of the `vertex_data` structure.
- Each time a `vertex_data` structure is available in the GPU, the _vertex shader_ is called and returns a `pixel_data` structure corresponding to the pixel under the vertex as seen on the screen. During this call, the vertex shader transforms the 3D world coordinates of the vertex into screen coordinates, and transforms the other vertex attributes if necessary.
- Then many complex steps are performed by the GPU to determine how far the surface of each triangle is visible on the screen, up to each visible pixel.
- Each time the GPU determines that a pixel of a triangle is visible, it calls the _pixel shader_ with a `pixel_data` structure as argument that corresponds to the position of the pixel. In order to provide position-specific values for each pixel of the triangle, the GPU interpolates values from the values of the 3 structures returned for the 3 vertices of the triangle by the vertex shader.

To render sources, OBS follows the same model and renders simply quads (2 triangles) on the screen, where each vertex has the UV mapping of the source picture as attribute. The vertex shader is only used to compute the screen coordinates of the 4 vertices of the quad, according to the transform of the source, and to pass the UV coordinates to the pixel shader. The classical method for the transformation of world coordinates into screen coordinates is a [multiplication through the "View-Projection" 4x4 matrix in homogeneous coordinates](http://www.it.hiof.no/~borres/j3d/math/threed/p-threed.html) (don't be afraid, it is not necessary to understand homogeneous coordinates for the tutorial):

``` HLSL
// Vertex shader used to compute position of rendered pixels and pass UV
pixel_data vertex_shader_halftone(vertex_data vertex)
{
    pixel_data pixel;
    pixel.pos = mul(float4(vertex.pos.xyz, 1.0), ViewProj);
    pixel.uv  = vertex.uv;
    return pixel;
}
```

The vertex shader will remain like this in most cases with OBS. Altering the 3D transformation would change the proper location of displayed sources on the screen. Note that interesting results could be achieved, e.g. actually the Source Shake animation could be certainly implemented as a smart modification of the View-Projection matrix.

Please note the well-adapted HLSL syntax `vertex.pos.xyz` here. `pos` is a `vertex` member with vector type `float4`. Adding the suffix `.xyz` is sufficient to convert it to a temporary `float3` vector with the values of the components `x`, `y` and `z` of `pos`. Then `float4(vertex.pos.xyz, 1.0)` is again a `float4` vector with the 3 first components of `vertex.pos.xyz` and `1.0` as fourth component. The HLSL syntax, which is by the way very similar to GLSL used in OpenGL, has this special feature that makes it very compact for matrix and vector operations.

Now the real heart of the video filter effect is in the Pixel Shader. The main principle of a pixel shader is very simple: this is a function that computes a color at a given pixel position. The pixel shader function is called for every single pixel within the draw area.

As a simple gray shading effect, we want to compute the "luminance" of the source pixel (i.e. its brightness or luminous intensity), and use it for each RGB component of the output color:

``` HLSL
// Pixel shader used to compute an RGBA color at a given pixel position
float4 pixel_shader_halftone(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float luminance = dot(source_sample.rgb, float3(0.299, 0.587, 0.114));
    return float4(luminance.xxx, source_sample.a);
}
```

Please again admire the incredibly compact syntax:

- On the first line, the `source_sample` variable receives the RGBA color of the pixel at `pixel.uv` in the source picture in UV coordinates, following a sampling method given by `linear_clamp`. Attention: here `.uv` is just a `float2` member of the structure `pixel`, not a suffix to access particular vector components.
- On the second line, the [relative luminance](https://en.wikipedia.org/wiki/Relative_luminance) is computed as a [dot product](https://en.wikipedia.org/wiki/Dot_product) of the `float3` vector of the RGB components of `sample_color` and the constant `float3` vector _(0.299, 0.587, 0.114)_. The expression is equivalent to `source_sample.r*0.299 + source_sample.g*0.587 + source_sample.b*0.114`. Suffices `r`, `g`, `b`, `a` can be used like `x`, `y`, `z`, `w` to access particular vector components. It is necessary to write `source_sample.rgb` here because it is a `float4` vector and we want to exclude the `a` component from the dot product.
- On the third line, a `float4` vector is built with three time the `luminance` value and then the original alpha value of the source color as fourth component. The color is returned as a `float4` containing the values of the RGBA components between 0.0 and 1.0.

The position of the pixel is provided through the `pixel_data` structure:

- `pixel.pos` is a `float4` vector resulting from the computation in the vertex shader and further interpolation. In the pixel shader `pixel.pos.xy` may contain the absolute position on screen of the pixel being rendered (i.e. values change if the user moves the source with the mouse). Now if the source is itself scaled with a setting of _Scale filtering_ different than _Disable_, or if some other filter needs to render in a texture as an intermediate step, then `pixel.pos.xy` may contain some other pixel coordinates corresponding to the internal texture used to render the output of our filter before further processing. In addition, as `pixel.pos` is in homogeneous coordinates, normally it is necessary to divide `x` and `y` by the `w` components (which should be always equal to 1 here as there is no 3D). Long story short, it is not recommended to use `pixel.pos` directly.
- `pixel.uv` gives the interpolated UV coordinates of the pixel in the source picture as a `float2` vector, i.e. it does not depend on the position or scaling of the source. As UV coordinates, `pixel.uv.x` and `pixel.uv.y` have values in range 0.0 to 1.0, with the upper left corner of the source picture is at position (0.0,0.0) and the bottom right corner at (1.0,1.0). This is what we want to use to reference the source pixels. In addition, the UV coordinates can be used directly to retrieve the pixel color from the `image` texture.

The final part of the effect file is the definition of the "techniques". Here again the structure will be similar in most effects, typically with one pass and one technique:

``` HLSL
technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_halftone(vertex);
        pixel_shader  = pixel_shader_halftone(pixel);
    }
}
```

Add all the code blocks in the HLSL file, then restart OBS, normally the source should be displayed in black and white:

![filter halftone luminance](images/scripting/filter-halftone-luminance.png)

Well, this is not really a halftone picture here, but it clearly shows the expected shades of gray according to the luminance. The example picture is very dark. And actually our simple computation of the luminance is wrong as it does not take into account the "gamma compression" of RGB components.

### Gamma compression and correction

Colors are typically encoded with 8 bits for each RGB component, i.e. in range 0 to 255, corresponding to the range 0.0 to 1.0 in HLSL. But because the human eye has a [non-linear perception of the light intensity](http://blog.johnnovak.net/2016/09/21/what-every-coder-should-know-about-gamma/) emitted by the monitor, the values encoded in the RGB components do not grow linearly with the intensity, they follow a power law instead. The power law for encoding and decoding uses typically an exponent _2.2_ or _1/2.2_.

This non-linearity of the RGB components is of course an issue in a video filter if a computation is performed assuming they are encoded in a linear way.

The two operations of [gamma correction](https://en.wikipedia.org/wiki/Gamma_correction) are called first _gamma compression_, i.e. encoding of an RGB component proportional to the light intensity into a value to be displayed to a human eye, with an exponent lower than 1, and _gamma expansion_ with an exponent greater than 1.

Let's call _gamma_ the exponent used for color decoding (greater than 1) with a value of _2.2_. We can use simplified formulas for gamma encoding:

_encoded_value = linear_value <sup>1/gamma</sup>_

And for gamma decoding:

_linear_value = encoded_value <sup>gamma</sup>_

Please note that such formulas keep values nicely between 0.0 and 1.0.

Now to come back to the halftone filter, we noted that the example picture is a bit too dark, and we know that changing the "gamma" of a picture change its overall luminosity. So we can introduce a gamma computation for 2 purposes: use of linear values for more exact calculations and a somehow abusively named "gamma correction" of the source picture.

Namely, a gamma decoding including a subtractive "correction" would look like this, performed _before_ any computation on the RGB color components (with a minus such that positive values increase the luminosity):

_linear_value = encoded_value <sup>gamma-correction</sup>_

Let's do it in the code, starting with the definition of a global constant `GAMMA` and a uniform variable `gamma_correction` with a default value:

``` HLSL
// Constants
#define GAMMA 2.2

// General properties
uniform float gamma_correction = 1.2;
```

Experiment and adapt the default value of `gamma_correction` to your source. It will be defined as an OBS property later on.

Then we introduce the gamma encoding and decoding functions, and re-write the pixel shader to use it:

``` HLSL
float3 decode_gamma(float3 color)
{
    return pow(color, GAMMA - gamma_correction);
}

float3 encode_gamma(float3 color)
{
    return pow(color, 1.0/GAMMA);
}

// Pixel shader used to compute an RGBA color at a given pixel position
float4 pixel_shader_halftone(pixel_data pixel) : TARGET
{
    float4 source_sample = image.Sample(linear_clamp, pixel.uv);
    float3 linear_color = decode_gamma(source_sample.rgb);

    float luminance = dot(linear_color, float3(0.299, 0.587, 0.114));
    float3 result = luminance.xxx;

    return float4(encode_gamma(result), source_sample.a);
}
```

Add all the code blocks in the HLSL file, then _restart OBS_ (only reloading the script would not help, because the effect remains cached and would not be re-compiled). Depending on the value you select for `gamma_correction`, the filtered picture should have a different overall luminosity:

![filter halftone gamma corrected luminance](images/scripting/filter-halftone-gamma-corrected-luminance.png)

The picture is a bit better now.

### Width and height from Lua to the shader

Whatever the final form, the halftone effect is based on a pattern applied pixel-by-pixel to the source picture. While it is easy to transform the color of a single pixel, if the position of the pixel is necessary to recognize in which part of a pattern the pixel is located, then the UV coordinates alone are not sufficient in the general case, it is necessary to know the size of the source picture. More about the calculations in the next section.

In this section we will first see how to make the values of `width` and `height` available in the shader from the Lua code. Strangely, OBS does not foresee these parameters in effect files by default. We start with the definition of `uniform` variables in the effect file:

``` HLSL
// Size of the source picture
uniform int width;
uniform int height;
```

Only uniform variables can be changed from the Lua code. Once an effect is compiled, the function [`gs_effect_get_param_by_name`](https://obsproject.com/docs/reference-libobs-graphics-effects.html#c.gs_effect_get_param_by_name) provides the necessary `gs_eparam` structure where the value can be set. The effect parameters can be retrieved right after effect compilation in `source_info.create`:

``` Lua
  -- Retrieves the shader uniform variables
  data.params = {}
  data.params.width = obs.gs_effect_get_param_by_name(data.effect, "width")
  data.params.height = obs.gs_effect_get_param_by_name(data.effect, "height")
```

Finally the values are set with [`gs_effect_set_int`](https://obsproject.com/docs/reference-libobs-graphics-effects.html#c.gs_effect_set_int) between `obs_source_process_filter_begin` and `obs_source_process_filter_end` in in `source_info.video_render`:

``` Lua
  -- Effect parameters initialization goes here
  obs.gs_effect_set_int(data.params.width, data.width)
  obs.gs_effect_set_int(data.params.height, data.height)
```

Add the code, restart OBS, for now no difference is expected, the interesting things start in the net section.

### Luminance perturbation

Now that the size of the picture is available, we can start to use pixel coordinates for formulas. Namely, we want to add a little perturbation on the computed luminance according to the formula _sin(x)*sin(y)_. The form of this classic formula looks like:

![filter halftone ](images/scripting/filter-halftone-perturbation-curve.png)

The formula will be such that:

- It adds to the luminance a small negative or positive value with a given amplitude
- The scale of the form can be changed, with a scale of 1.0 corresponding to an oscillation long of 1 pixel

If we name the parameters of the formula simply _scale_ and _amplitude_, assuming _x_ and _y_ are in pixels, the angle for the oscillations on _x_ is given by _2\*&pi;\*x/scale_ (the bigger the _scale_, the longer the oscillations). The sine function returns values between -1.0 and 1.0, so the _amplitude_ can be just multiplied to the product of sine.

The final parameterized formula will be:

_perturbation = amplitude\*sin(2\*&pi;\*x/scale)\*sin(2\*&pi;\*y/scale)_

For the coordinates _x_ and _y_ in pixels, as we have the _width_ and _height_ plus the UV coordinates, the formula are simply _x = U * width_ and _y = V * height_ if we call the UV coordinates _U_ and _V_ here.

In the code, we will use a more compact form with a component-by-component multiplication of `pixel.uv` with `float2(width,height)`. Re-write the center part of the pixel shader (between the decoding and encoding lines) with:

``` HLSL
    float luminance = dot(linear_color, float3(0.299, 0.587, 0.114));
    float2 position = pixel.uv * float2(width, height);
    float perturbation = amplitude * sin(2.0*PI*position.x/scale) * sin(2.0*PI*position.y/scale);
    float3 result = (luminance + perturbation).xxx;
```

At the top of the file, do not forget to define a new constant for `PI` and the new uniform variables `scale` and `amplitude` with default values:

``` HLSL
// Constants
#define PI 3.141592653589793238

// General properties
uniform float amplitude = 0.2;
uniform float scale = 8.0;
```

Add the code, restart OBS, now the effect should look like this:

![filter halftone perturbation](images/scripting/filter-halftone-perturbation.png)

It slowly starts to look like a halftone.

### Reducing the number of colors

Until now we use a continuous luminance. The next step is to mimic a reduced number of inks on a printed paper.

For a given value of luminance from 0.0 to 1.0, we can multiply the value by a constant factor and then round the product to obtain a certain number of integer values. For example, with a factor of 3, we obtain the values 0, 1, 2 and 3. The we re-divide by 3 to obtain 4 luminance values with values 0.0, 0.33, 0.66 and 1.0. It can be generalized to _n_ colors by multiplying/dividing by _n-1_.

The computation is really simple to implement. We start by adding a global uniform number of colors:

``` HLSL
uniform int number_of_colors = 4.0;
```

And we add a single line in the pixel shader, just before the gamma encoding:

``` HLSL
    result = round((number_of_colors-1)*result)/(number_of_colors-1);
```

Add the code, restart OBS, now the effect should look like this:

![filter halftone 4 colors](images/scripting/filter-halftone-4-colors.png)

Here we are! It is nice to see what a simple sine-based perturbation plus rounding can do. The active part of the effect is just a couple of lines long.

And now it is also very interesting to check how the effect behaves with different kinds of scale filtering (context menu of the source in OBS, then _Scale Filtering_).

First example, the scale filtering _Point_ does not perform any interpolation after zoom and shows square-formed pixels:

![filter halftone zoom scale filtering point](images/scripting/filter-halftone-zoom-scale-filtering-point.png)

Typically, as we use a periodic pattern in the effect, "aliasing" artifacts may appear if we reduce the size of the picture:

![filter halftone unzoom scale filtering point](images/scripting/filter-halftone-unzoom-scale-filtering-point.png)

With a scale filtering set to _Bicubic_, the interpolation after scaling shows anti-aliasing:

![filter halftone zoom scale filtering bicubic](images/scripting/filter-halftone-zoom-scale-filtering-bicubic.png)

With reduced size, the aliasing is not completely gone but at least reduced:

![filter halftone unzoom scale filtering bicubic](images/scripting/filter-halftone-unzoom-scale-filtering-bicubic.png)

Now a very interesting effect appears when the scale filtering is set to _Disable_ on a strongly zoomed picture (attention it may not work if other filters are in the chain of the source). The pixel shader works directly on the screen (the output is not rendered into an intermediate texture for later scaling), so it renders every single pixel in the screen space, at a sub-pixel level for the source picture. As we use continuous mathematical functions, and sample the source picture using a `Linear` interpolation with `linear_clamp`,  the curves drawn by the pixel shader hide completely the pixel grid of the source picture. It looks like a vector drawing:

![filter halftone zoom scale filtering disable](images/scripting/filter-halftone-zoom-scale-filtering-disable.png)

With reduced size it still behaves well:

![filter halftone unzoom scale filtering disable](images/scripting/filter-halftone-unzoom-scale-filtering-disable.png)

The sine-based halftone effect is completely implemented now. It has many parameters set with default values but the user cannot set these parameters so far.

### Adding properties

The effect is already satisfactory, we now want to improve the user experience by creating properties for the uniform variables that we already have in the effect file: `gamma_correction`, `amplitude`, `scale` and `number_of_colors`.

By convention, we will name all instances of the variables or properties with the sames names as in the effect file, i.e. for the effect parameters, the data settings and the variables of the `data` structure.

Similarly to what is described in the Source Shake tutorial, we first have to define default values in [`source_info.get_defaults`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_defaults). Default values are chosen such that applying them to a new source would give a reasonable result (no extreme values, no pre-defined corrections):

``` Lua
-- Sets the default settings for this source
source_info.get_defaults = function(settings)
  obs.obs_data_set_default_double(settings, "gamma_correction", 0.0)
  obs.obs_data_set_default_double(settings, "scale", 5.0)
  obs.obs_data_set_default_double(settings, "amplitude", 0.2)
  obs.obs_data_set_default_int(settings, "number_of_colors", 4)
end
```

Then we define the properties as sliders in [`source_info.get_properties`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.get_properties), which builds and returns a properties structure:

``` Lua
-- Gets the property information of this source
source_info.get_properties = function(data)
  local props = obs.obs_properties_create()
  obs.obs_properties_add_float_slider(props, "gamma_correction", "Gamma correction", -2.0, 2.0, 0.1)
  obs.obs_properties_add_float_slider(props, "scale", "Pattern scale", 0.01, 10.0, 0.01)
  obs.obs_properties_add_float_slider(props, "amplitude", "Perturbation amplitude", 0.0, 2.0, 0.01)
  obs.obs_properties_add_int_slider(props, "number_of_colors", "Number of colors", 2, 10, 1)
  return props
end
```

Once a property is changed, the [`source_info.update`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.update) function is called. This is where we will transfer the values from data settings to the `data` structure used to hold values until they are set in the shader:

``` Lua
-- Updates the internal data for this source upon settings change
source_info.update = function(data, settings)
  data.gamma_correction = obs.obs_data_get_double(settings, "gamma_correction")
  data.scale = obs.obs_data_get_double(settings, "scale")
  data.amplitude = obs.obs_data_get_double(settings, "amplitude")
  data.number_of_colors = obs.obs_data_get_int(settings, "number_of_colors")
end
```

Next, like for `width` and `height`, we need to store the effect parameters and we call once `source_info.update` to initialize the members of the `data` structure (do not forget it, otherwise OBS will try to use non-initialized data in `source_info.video_render` and log errors every frame). This block comes at the end of the `source_info.create` function, after effect compilation:

``` Lua
  data.params.gamma_correction = obs.gs_effect_get_param_by_name(data.effect, "gamma_correction")
  data.params.amplitude = obs.gs_effect_get_param_by_name(data.effect, "amplitude")
  data.params.scale = obs.gs_effect_get_param_by_name(data.effect, "scale")
  data.params.number_of_colors = obs.gs_effect_get_param_by_name(data.effect, "number_of_colors")

  -- Calls update to initialize the rest of the properties-managed settings
  source_info.update(data, settings)
```

And finally we transfer the values from the `data` structure into the effect parameters in `source_info.video_render`:

``` Lua
  obs.gs_effect_set_float(data.params.gamma_correction, data.gamma_correction)
  obs.gs_effect_set_float(data.params.amplitude, data.amplitude)
  obs.gs_effect_set_float(data.params.scale, data.scale)
  obs.gs_effect_set_int(data.params.number_of_colors, data.number_of_colors)
```

Well, that's a lot. Each variable appears 7 times in different forms! Every line above has a justification, and this is the way OBS manages the persistency of settings, default values, display of properties, etc, and that for any filter instance added to any source. Let's say it is worth the pain but it calls for a proper object-oriented design to avoid writing so many times the same of code.

Add the pieces of code, restart OBS, open the _Filters_ of the source, it should look like this (here in 2 colors):

![filter halftone properties](images/scripting/filter-halftone-properties.png)

Playing with the parameters of a video filter and seeing the result immediately is quite satisfying.Note the aliasing effects in the preview, it seems that there is nothing foreseen to avoid it.

This first part is completed. This version is definitely a good starting point for further development. The complete [source code of this first part](Scripting-Tutorial-Halftone-Filter-Listing.md) is available.

## Second part - Dithering with texture

In this second part we will see how to use additional textures.



``` Lua
```

``` Lua
```

``` Lua
```
