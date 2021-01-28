
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

### Effect compilation

Lua would not be fast enough for video processing so the filter is based on GPU computation. A GPU can be programmed through "shaders" compiled by the graphics device driver from [GLSL](https://en.wikipedia.org/wiki/OpenGL_Shading_Language) for OpenGL or [HLSL](https://en.wikipedia.org/wiki/High-Level_Shading_Language) in the MS Windows world. OBS relies on HLSL and expects shader code in the so-called [effect files](https://obsproject.com/docs/graphics.html).

An effect can be compiled from a file with [`gs_effect_create_from_file`](https://obsproject.com/docs/reference-libobs-graphics-effects.html#c.gs_effect_create_from_file) or from a string with [`gs_effect_create`](https://obsproject.com/docs/reference-libobs-graphics-effects.html#c.gs_effect_create), and is destroyed with [`gs_effect_destroy)`](https://obsproject.com/docs/reference-libobs-graphics-effects.html#c.gs_effect_destroy). Like other graphic functions in OBS, manipulating effects needs to occur in the [graphics context](https://obsproject.com/docs/graphics.html#the-graphics-context). This is ensured by calling [`obs_enter_graphics`](https://obsproject.com/docs/reference-core.html#c.obs_enter_graphics) and then [`obs_leave_graphics`](https://obsproject.com/docs/reference-core.html#c.obs_leave_graphics) when everything is done.

The compilation is typically implemented in the [`source_info.create`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.create) function and resources are released in the [`source_info.destroy`](https://obsproject.com/docs/reference-sources.html#c.obs_source_info.destroy) function. `source_info.create` returns a Lua table containing custom data used for the filter instance. Most functions of the `source_info` structure will provide this Lua table passed as an argument, so this is where you want to store any custom data needed by the filter. Please note that if `source_info.create` returns `nil`, then the filter initialization is considered failed (and logged accordingly).

Add this code to the Lua script:

``` Lua
-- Creates the implementation data for the source
source_info.create = function(settings, source)

  -- Initializes the custom data table and keeps a ref to this filter as OBS source
  local data = {}
  data.source = source

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

The effect file is already mentioned in the code. It is defined in the next section.

### Preliminary effect file

The Lua code is in place for the compilation, now create a new file called `filter-halftone.effect.hlsl` in the same directory as the Lua script.

:warning: The extension `.hlsl` is chosen such that a code editor or an IDE recognizes directly that it is HLSL code. As the parser of OBS may miss unbalanced brackets or parenthesis (and say nothing about it in the logs), it is very important to have syntax checking in the editor.





 See https://docs.microsoft.com/en-us/windows/win32/api/d3d11/ns-d3d11-d3d11_sampler_desc



``` Lua
```

