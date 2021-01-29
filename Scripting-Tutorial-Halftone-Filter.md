
# Scripting Tutorial Halftone Filter

This tutorial describes the implementation of a "halftone" filter as a Lua script for OBS. Such a filter appears in the list of filters and can be added as part of a filter chain to any video source. As effect, the filter mimics the [halftone technique](https://en.wikipedia.org/wiki/Halftone), used for printing with a reduced set on ink colors arranged in patterns. It is based on [dithering](https://en.wikipedia.org/wiki/Dither) with a carefully designed texture.

### Script creation

As described in the [Source Shake tutorial](https://github.com/obsproject/obs-studio/wiki/Scripting-Tutorial-Source-Shake), create a script file named `filter-halftone.lua` with this content:

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
  data.effect = obslua.gs_effect_create_from_file(effect_file_path, nil)
  obslua.obs_leave_graphics()

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
    obslua.obs_enter_graphics()
    obslua.gs_effect_destroy(data.effect)
    data.effect = nil
    obslua.obs_leave_graphics()
  end
end
```

The effect file `filter-halftone.effect.hlsl` is mentioned in the code, it will defined in the next section. Please note that the `source` argument of the function `source_info.create` is a reference to the current instance of the filter as a source object (almost everything is a source in OBS). This reference, as well as the variables `width` and `height`, initialized with dummy values, are used in the rendering function.

Namely, the function [`source_info.video_render`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.video_render) is called each frame to render the output of the filter in the graphics context (no need to call `obs_enter_graphics`). To render an effect, first [`obs_source_process_filter_begin`](https://obsproject.com/docs/reference-sources.html#c.obs_source_process_filter_begin) is called, then the effect parameters can be set, and then [`obs_source_process_filter_end`](https://obsproject.com/docs/reference-sources.html#c.obs_source_process_filter_end) is called to draw.

Determining the width and height to pass to `obs_source_process_filter_end` is somehow tricky in OBS, because the filter is itself in a chain of filters, where the resolution could theoretically change at any stage. The usual method is to retrieve the "parent source" of the filter with [`obs_filter_get_parent`](https://obsproject.com/docs/reference-sources.html#c.obs_filter_get_parent), i.e. "the source being filtered", and then to use the so far undocumented functions `obs_source_get_base_width` and `obs_source_get_base_height`.

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

  obslua.obs_source_process_filter_begin(data.source, obslua.GS_RGBA, obslua.OBS_NO_DIRECT_RENDERING)

  -- Effect parameters initialization goes here

  obslua.obs_source_process_filter_end(data.source, data.effect, data.width, data.height)
end
```

Add the code blocks to the Lua script, but no need to reload for now, the effect file is still missing.

### Preliminary effect file

The Lua code is in place, now create a new file called `filter-halftone.effect.hlsl` in the same directory as the Lua script.

:warning: The extension `.hlsl` is chosen such that a code editor or an IDE recognizes directly that it is HLSL code. As the parser of OBS may miss unbalanced brackets or parenthesis (and say nothing about it in the logs), it is very important to have syntax checking in the editor.

An [effect file](https://docs.microsoft.com/en-us/windows/win32/direct3d11/d3d11-effect-format) follows a strict syntax and structure. It is a mix of static data definitions and code. These constraints are necessary to allow the compilation for the GPU and the massively parallel execution. The various parts are described below.

Our effect file starts with macro definitions that will allow writing HLSL-compliant code instead of the dialect understood by OBS, in order to support a full syntax check in the IDE. Indeed, the keywords `sampler_state` and `texture2d` are specific to OBS. Using such macros is of course not mandatory (and not so common looking at other OBS effect files):

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

After that, a very specific data structure is defined to specify which parameters are given to the vertex shader, and passed from the vertex shader to the pixel shader. It includes [semantics](https://docs.microsoft.com/en-us/windows/win32/direct3dhlsl/dx-graphics-hlsl-semantics) defining the intended use of the parameters of the structure, necessary for the rendering pipeline of the GPU ([supported semantics](https://obsproject.com/docs/graphics.html#effect-vertex-pixel-semantics) in the OBS API reference):

``` HLSL
// Helper structure used as input/output argument for vertex and fragment shaders
struct shader_data
{
    float4 pos : POSITION;  // Homogeneous coordinates XYZW
    float2 uv  : TEXCOORD0; // UV coordinates in a texture
};
```

The `shader_data` structure is then used first as argument for the function implementing the Vertex Shader. As the GPU rendering pipeline model is based on drawing 3D triangles with a dynamic texture, OBS renders quads (2 triangles) on the screen filled pixel-by-pixel by the pixel shader. The vertex shader is only used to compute the screen coordinates of the 4 vertices of the quad, according to the transform of the source. The classical method to transform vertices is a [multiplication through a 4x4 matrix in homogeneous coordinates](http://www.it.hiof.no/~borres/j3d/math/threed/p-threed.html) (don't be afraid, it is not necessary to understand this for the filter):

``` HLSL
// Default vertex shader used to compute position of rendered pixels and pass UV
shader_data vertex_shader_default(shader_data cur)
{
    shader_data res;
    res.pos = mul(float4(cur.pos.xyz, 1.0), ViewProj);
    res.uv  = cur.uv;
    return res;
}
```

The vertex shader will remain like this in most cases with OBS. Modifying it would alter the proper location of displayed sources on the screen, but interesting results could be achieved. Actually the Source Shake animation could be implemented as well just in the vertex shader.

The real heart of a video filter effect is in the Pixel Shader:

``` HLSL
// Specific pixel shader for the halftone effect
float4 pixel_shader_halftone(shader_data cur) : TARGET
{
    float4 smp = image.Sample(linear_clamp, cur.uv);
    float level = round(smp.r + smp.g + smp.b) / 3.0;
    return float4(level, level, level, smp.a);
}
```

The main principle of a pixel shader is very simple: this is a function that computes a color at a given pixel position. The pixel shader function is called for every single pixel within the draw area.

The color is returned as a `float4` containing the values of the RGBA components between 0.0 and 1.0. The position of the pixel is provided through the `shader_data` structure:

- `cur.pos.xy` gives the screen pixel coordinates (i.e. it changes if the user moves the filtered source)
- `cur.uv` gives the UV coordinates of the input picture seen as a texture (i.e. independent of the position and scaling of the filtered source)

UV coordinates are between 0.0 and 1.0, with the upper left corner of the picture is at position (0.0,0.0) and the bottom right corner at (1.0,1.0). This is what we want to use to reference the source pixels.

In the pixel shader above:

- `smp` receive the RGBA color of the pixel at `cur.uv` in the input source, following a sampling method given by `linear_clamp`
- a value `level` is computed by adding all RGB components between 0.0 and 1.0, giving a value from 0.0 to 3.0, then rounding it to obtain either 3.0, 2.0, 1.0 or 0.0, and then dividing it by 3.0 to normalize these values between 0.0 and 1.0
- the returned color is a grey with an intensity given by `level`, and takes the original alpha value `smp.a`

The expected result of the pixel shader is to re-draw the input picture in 4 levels of gray, with an intensity given by the average of the RGB components at any pixel position.

The final part of the effect file is the definition of the "techniques". Here again the structure will be similar in most effects, typically with one pass and one technique:

``` HLSL
technique Draw
{
    pass
    {
        vertex_shader = vertex_shader_default(cur);
        pixel_shader  = pixel_shader_halftone(cur);
    }
}
```

Add the code blocks in the HLSL file, then restart OBS, normally the source should be now displayed in 4 colors:

![filter halftone 4 colors](images/scripting/filter-halftone-4-colors.png)

This is not the nicest half-toning effect, but it works! Additional computations will be necessary in the pixel shader to improve the effect.

Nevertheless, it s a good starting point. The complete source code is available for re-use as a script skeleton for any new video filter development.

``` Lua
```

``` Lua
```

``` Lua
```
