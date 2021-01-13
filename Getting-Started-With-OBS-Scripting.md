OBS can be extended with Python and Lua scripts. This set of pages explains the basics to get started and describes how to implement common features.

## Scripts management window

Scripts are managed by the user through the _Scripts_ dialog window, displayed via the menu item _Tools > Scripts_:

![Main scripts window](images/scripting/main-scripts-window.png)

A list of scripts currently added to OBS is displayed on the left hand side (here two scripts distributed with OBS). On the right hand side, if any, the description and editable properties of the script are shown. A script can be added by clicking on <kbd>:heavy_plus_sign:</kbd> and selecting the related Python or Lua file, removed with <kbd>:heavy_minus_sign:</kbd>. Use the <kbd>&#128472;</kbd> button to _Reload Scripts_ and the <kbd>Defaults</kbd> button to reset the values of the editable properties to their default values.

For Python scripts, a decent distribution of Python must be installed by the user, and the _Python Install Path_ must be set in the tab _Python Settings_. Please refer to the [OBS scripting documentation](https://obsproject.com/docs/scripting.html) for the supported version of Python (currently Python 3.6). Depending on the Python installation, locating the installation path can be difficult, e.g. on Windows 10 with Python installed from the Microsoft Store, the installation path is located at `[UserFolder]\AppData\Local\Programs\Python\Python36`.

## OBS ecosystem

Scripting is a way to add functionality to OBS but it is not the only one. Having an overview of the context is important before going into the details. Here is a non-exhaustive list of methods one could use to develop new functions that interact with OBS:

- [*Plugins*](https://obsproject.com/docs/plugins.html) are typically implemented in C/C++ and compiled into dynamic libraries that are discovered and loaded at run time by OBS. The main advantages of plugins are obviously the performance and the raw access to all functions and libraries of OBS. A significant drawback is the need to setup an OBS compilation environment and to deal with subsequent OBS versions if re-compilation is necessary. In addition, if a wide distribution is envisaged, compilation and installation for different platforms must be considered.
- [*Scripts*](https://obsproject.com/docs/scripting.html) are written in Lua or Python and are interpreted or compiled on-the-fly at run time. Scripts are mostly platform-independent and are usually not affected by slight changes of OBS data structures. They have access to large portions of the OBS C API. Obvious advantages are the simplified development and maintenance while supporting many features of plugins. The drawback is a lower performance, which is not an issue in most cases.
- [*Browser docks and sources*](https://github.com/obsproject/obs-browser) (for Windows and macOS) can use a [Javascript API](https://github.com/obsproject/obs-browser#js-bindings) to react to events in OBS and retrieve basic information. They can be hosted on a web-server or locally, and support what Chromium supports (including HTML5, WebGL, etc). They are typically used as sources for overlays reacting to events.
- [*WebSockets*](https://github.com/Palakis/obs-websocket) can be used to remotely control OBS via a [network interface](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md). Different libraries support the protocol for customized applications (C#, Javascript, Python, Java, ..).
- [*Numerous plugins*](https://obsproject.com/forum/list/plugins.35) and [*scripts*](https://obsproject.com/forum/resources/categories/scripts.5) may provide the wished behavior without development. As an example, [StreamFX](https://github.com/Xaymar/obs-StreamFX) supports customized shaders with customizable input parameters for filter, source or transition video effects.

## Comparison of Python and Lua for scripting in OBS

Lua is by far less popular and less powerful than Python, but it is a bit simpler (on purpose, to reduce complexity and footprint in the embedding executable) and better integrated in OBS (as of v26.1):

| Criteria | [Python](https://www.python.org) | [Lua](https://www.lua.org) |
|-------|--------|-----|
| General usage | Wide usage for everything, [full-featured standard library](https://docs.python.org/3.6/library), etc | Sparse usage mainly as embedded scripting extension (e.g. in [Wireshark](https://gitlab.com/wireshark/wireshark/-/wikis/Lua), [VLC](https://www.videolan.org/developers/vlc/share/lua/README.txt), [RPM](https://rpm.org/user_doc/lua.html), etc), [poor standard library](https://www.lua.org/manual/5.1) (use the OBS API or [FFI](https://luajit.org/ext_ffi.html) to fill the gaps) |
| Additional modules | Supported e.g. with pip | Supported for pure Lua modules, probably possible but complex for modules with binary |
| Interpreter | Not embedded | Fully embedded, based on [LuaJIT](http://luajit.org) |
| Supported [libobs modules](https://obsproject.com/docs/reference-modules.html) | None | [Sources](https://obsproject.com/docs/scripting.html#script-sources-lua-only) only |

## API documentation

OBS has a huge API of C functions and data structures. Scripting-specific API features are described in the [OBS scripting documentation](https://obsproject.com/docs/scripting.html). The rest of the [API](https://obsproject.com/docs) is documented in the original C flavour only, there is no documentation of the functions and data structures as seen from the scripting environment so far.

These resources can be helpful (feel free to add something):

- Example scripts delivered with OBS in `[InstallationFolder]/data/obs-plugins/frontend-tools/scripts`
- [An extensive OBS Python cheat sheet by upgradeQ](https://github.com/upgradeQ/OBS-Studio-Python-Scripting-Cheatsheet-obspython-Examples-of-API) (thanks to upgradeQ for this huge collection of code snippets)
- The forum page [Tips and tricks for Lua scripts](https://obsproject.com/forum/threads/tips-and-tricks-for-lua-scripts.132256)

## Getting started

A bare text editor is the only thing you need to get started, but prefer the IDE of your choice for a more comfortable editing. There is no official supporting file for features such as Intellisense so far.

Two tutorials are proposed in this Wiki:

- Start with the [**Source Shake tutorial**](Scripting-Tutorial-Source-Shake.md) that shows how to animate a source displayed in a scene with a hotkey and customizable properties, in Python and Lua
- The [**Halftone Filter tutorial**](Scripting-Tutorial-Halftone-Filter.md) is an example of shader-based video filter in Lua

Other tutorial resources (feel free to add something):

- [Bouncing background logo tutorial at jbscript.dev](https://jbscript.dev/my-first-lua-and-obs-script/) in Lua
- Tutorial by upgradeQ in Lua, [part 1](https://translate.google.com/translate?sl=ru&tl=en&u=https%3A%2F%2Fhabr.com%2Fru%2Fpost%2F520684%2F) (global script functions, timers, hotkeys) and [part 2](https://translate.google.com/translate?sl=ru&tl=en&u=https%3A%2F%2Fhabr.com%2Fru%2Fpost%2F522278%2F) (setting filter parameters, events)

## Bindings

There is no strong layer of protection or consistency checking between scripting and binary functions. The C functions of the OBS API are bound to the scripting environment through _wrapper functions_ written in C and compiled into OBS libraries.

Typically, when a Python/Lua function is called in a script, the interpreter calls the related C wrapper function that implements these 3 steps:

1. Validation of the data given as arguments to the script function and conversion of this data from Python/Lua types to C types
2. Call to the original C function of the API
3. Conversion of the data returned by the C function from C types to Python/Lua types

Wrapper functions exist as well for "getters" and "setters", in order to access the members of OBS data structures, again with data conversion between C types and Python/Lua types.

Nearly all of wrapper functions are generated automatically by [SWIG](http://www.swig.org) during OBS build, based on the API functions definition in C. For a few complex C functions and structures, for which SWIG would not generate proper code automatically, wrapper functions are written manually. This is the case for frontend-related functions, `source_info` and functions with callback arguments (see the section [other differences from the C API](https://obsproject.com/docs/scripting.html#other-differences-from-the-c-api)).

:warning: Even if most functions are usable as intended (especially the ones specifically re-designed for scripting), a few functions with SWIG-written wrappers cannot be used directly for scripting so far, because SWIG cannot interpret properly the data types of arguments or return values given in the C definition. Typically, with values passed by reference or buffers, C pointers and pointer-pointer types are inherently ambiguous.

## Script life-cycle

A script must define some [global script functions](https://obsproject.com/docs/scripting.html#script-function-exports) called by the scripting environment at different stages of the script life-cycle and at different execution phases of OBS. The following steps are performed wherever the related global script functions are implemented.

### Global script functions called at OBS startup

When a script was previously added to OBS, at startup:

1. The content of the script file is read and interpreted in a new script execution context (global script functions are defined during this first execution)
2. `script_defaults(settings)` is called to initialize default values in data settings
3. `script_description()` is called to retrieve a description string to be displayed in the _Scripts_ window (with [Qt-style formatting](https://doc.qt.io/qt-5/richtext-html-subset.html) :bulb:)
4. `script_load(settings)` is called for one-time initialization, possibly using values of data settings (typically to setup signal handlers)
5. `script_update(settings)` is called a first time for initializations depending on the values of data settings (this function will be called again after any change of value in the data settings, see below)

Please note that:

- The values of the data settings available in `settings` during OBS startup reflect the state saved at previous OBS closure (properties changed by the user), and are already set in `settings` when `script_defaults`, `script_load` and `script_update` are called
- Because OBS does not store the values of properties that were not changed by the user, i.e. properties still set to their default values, such values are not available in `settings` when `script_defaults` is called at OBS startup (and are available as set by `script_defaults` later in `script_load` and `script_update`)
- During OBS startup, the steps 1 to 5 are performed _before_ loading the scenes and sources in the frontend (before `OBS_FRONTEND_EVENT_FINISHED_LOADING` is emitted). This is especially important in `script_update` if sources or scenes are looked up.

Check how OBS saves properties in the user's JSON configuration file (at `[UserFolder]\AppData\Roaming\obs-studio\basic\scenes` under Windows) to better understand what is going on.

### Global script function called every frame

During OBS execution, once a script is initialized, `script_tick(seconds)` is called every rendered frame (`seconds` is the time in seconds passed since the previous frame). Consider using a timer instead of a recurrent test in `script_tick` if possible.

:warning: Be very careful with the code in `script_tick`, OBS may rapidly become unresponsive if some error or text is logged every frame.

### Global script functions called at OBS closure

Two global script functions are called when OBS is closed:

1. `script_save(settings)` is called just before saving the data settings persistently
2. `script_unload()` is called just before the destruction of the script execution context

Data settings are saved automatically at OBS closure, it is not necessary for the script to call any function to save data settings (and not necessary to implement `script_save` nor `script_unload` to trigger OBS to save data set by a script).

### Global script functions for editable properties

Once OBS startup is completed, `script_properties()` is called by OBS if the script is selected in the _Scripts_ window (selecting another script would always call the related `script_properties` function).

The function has to return an `obs_properties_t` object created using [`obs_properties_create`](https://obsproject.com/docs/reference-properties.html#c.obs_properties_create) and filled with GUI elements though [`obs_properties_add_*`](https://obsproject.com/docs/reference-properties.html?highlight=obs_properties_add#c.obs_properties_add_bool) functions. The object will be released by OBS when necessary.

A callback function can be set to each property using [`obs_property_set_modified_callback`](https://obsproject.com/docs/reference-properties.html#c.obs_property_set_modified_callback).

When the value of a property is changed, the sequence is:

1. `script_update(settings)` is called (for initializations depending on the values of data settings)
2. The callback of the modified property is called

Please note that:

- :bulb: The description of a property supports [Qt-style formatting](https://doc.qt.io/qt-5/richtext-html-subset.html)
- :bulb: A callback function set on a property with  has to return true to trigger the refresh of the displayed properties (no new call to `script_properties`)
- If another property or data setting is modified per script, e.g. in `script_update`, then its callback is not triggered automatically, use [`obs_properties_apply_settings`](https://obsproject.com/docs/reference-properties.html#c.obs_properties_apply_settings) to trigger all callbacks (e.g. in `script_update` with a properties object saved in a global variable in `script_properties`)

### Global script functions call sequence for other operations

The management operations available on the _Scripts_ window trigger more complex sequences (described in this section as in OBS v26.1, the behavior may change in the future).

Adding a script:

- Initialization steps like in OBS startup except that values of data settings are not available:

  1. First script execution
  2. `script_defaults`
  3. `script_description`
  4. `script_load`
  5. `script_update`

- Then, as the script is selected in the _Scripts_ window, the properties are initialized and displayed:

  6. `script_properties`
  7. Call to all "modified callbacks", for all properties (with data settings still not available)
  8. `script_properties` again
  9. `script_update` with data settings available
  10. Call to the "modified callbacks" of properties actually changed in previous steps

:warning: The complete sequence may lead to inconsistencies if not carefully handled, because the same functions are called multiple times, including property callbacks at step 7, while data settings are not available (credits to eukraticism for pointing out this behavior).

Removing a script just triggers a call to `script_unload` (_not_ `script_save`).

Resetting to defaults starts with a call to `script_update` followed by the same steps as for removing and then re-adding a script (data settings not available).

Reloading a script is the same as removing and then re-adding a script, except that the values of data settings are available during the complete sequence.

## Troubleshooting

It is common to experience OBS crashes or unexpected behavior during the development. A few hints (feel free to add your own!):

- Scripts are loaded very early when OBS starts, before the GUI appears. Depending on what the script does at start, it may lead to a very long start time (e.g. shader compilation with unrolled loops).
- If OBS crashes at start due to a script, or wrong parameters given to a script, it won't be possible to de-activate the faulty script in the _Scripts_ dialog window. To recover: rename the script, start OBS, remove the faulty script from the list of attached scripts, etc.
- OBS will tend to keep any defined/changed property in the user's JSON configuration file, even if the related property does not exist any more in a later version of the script. Removing a script and then re-adding it (and set again the related properties) will clean-up such ghost properties.
- OBS may freeze when too much data is logged at once, or may become unresponsive after a couple of minutes. This is especially true when data is logged at every frame, e.g. when a recurrent error occurs in `script_tick`. It may be necessary to close the OBS window or even kill the process to recover.
- Many functions in OBS allocate data that needs to be released. This is the meaning of the warning in the documentation: _release/destroy objects you reference or create via the API_. For instance, a call to [`obs_get_current_scene`](https://obsproject.com/docs/reference-frontend-api.html?#c.obs_frontend_get_current_scene) must be followed by a call to [`obs_source_release`](https://obsproject.com/docs/reference-sources.html#c.obs_source_release) otherwise OBS may crash on exit (with "Freeing OBS context data" as last log entry).  The need to release objects is not always documented. As a rule of thumb, if the API documentation states "Returns: A new reference ..." then a call to a release function is probably necessary (credits to J. Buchanan for this helpful synthesis).
- The [effects](https://obsproject.com/docs/graphics.html#creating-effects) parser misses often unbalanced brackets, without any log (credits to skeletonbow for this general remark). It is recommended to use an IDE able to detect such issues in HLSL (using the extension `.hlsl` on the effect file name may help).
