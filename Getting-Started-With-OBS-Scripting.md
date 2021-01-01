OBS can be extended with Python and Lua scripts. This set of pages explains the basics to get started and describes how to implement common features.

## Scripts management window

Scripts are managed by the user through the _Scripts_ dialog window, displayed via the menu item _Tools > Scripts_:

![Main scripts window](images/scripting/main-scripts-window.png)

A list of scripts currently attached to OBS is displayed on the left hand side (here two scripts distributed with OBS). On the right hand side, if any, the description and editable properties of the script are shown. A script can be added by clicking on <kbd>:heavy_plus_sign:</kbd> and selecting the related Python or Lua file, removed with <kbd>:heavy_minus_sign:</kbd>. The <kbd>&#128472;</kbd> or _Reload Scripts_ button reloads all scripts and <kbd>Defaults</kbd> resets the values of the editable properties to their default values.

For Python scripts, a decent distribution of Python must be installed by the user, and the _Python Install Path_ must be set in the tab _Python Settings_. Please refer to the [OBS scripting documentation](https://obsproject.com/docs/scripting.html) for the supported version of Python (currently Python 3.6). Depending on the Python installation, locating the installation path can be difficult, e.g. on Windows 10 with Python installed from the Microsoft Store, the installation path is located at `[UserFolder]\AppData\Local\Programs\Python\Python36`.

## OBS ecosystem

Scripting is a way to add functionality to OBS but it is not the only one. Having an overview of the context is important before going into the details. Here is a non-exhaustive list of methods one could use to develop new functions that interact with OBS:

- [*Plugins*](https://obsproject.com/docs/plugins.html) are typically implemented in C/C++ and compiled into dynamic libraries that are discovered and loaded at run time by OBS. The main advantages of plugins are obviously the performance and the raw access to all functions and libraries of OBS. A significant drawback is the need to setup an OBS compilation environment and to deal with subsequent OBS versions if re-compilation is necessary. In addition, if a wide distribution is envisaged, compilation and installation for different platforms must be considered.
- [*Scripts*](https://obsproject.com/docs/scripting.html) are written in Lua or Python and are interpreted or compiled on-the-fly at run time. Scripts are mostly platform-independent and are usually not affected by slight changes of OBS data structures. They have access to large portions of the OBS C API. Obvious advantages are the simplified development and maintenance while supporting many features of plugins. The drawback is a lower performance, which is not an issue in most cases.
- [*Browser docks and sources*](https://github.com/obsproject/obs-browser) (for Windows and macOS) can use a [Javascript API](https://github.com/obsproject/obs-browser#js-bindings) to react to events in OBS and retrieve basic information. They can be hosted on a web-server or locally, and support what Chromium supports (including HTML5, WebGL, etc). They are typically used as sources for overlays reacting to events.
- [*WebSockets*](https://github.com/Palakis/obs-websocket) can be used to remotely control OBS via a [network interface](https://github.com/Palakis/obs-websocket/blob/4.x-current/docs/generated/protocol.md). Different libraries support the protocol for customized applications (C#, Javascript, Python, Java, ..).
- [*Numerous plugins*](https://obsproject.com/forum/list/plugins.35) and [*scripts*](https://obsproject.com/forum/resources/categories/scripts.5) may provide the wished behavior without development. As an example, [StreamFX](https://github.com/Xaymar/obs-StreamFX) supports customized shaders with customizable input parameters for filter, source or transition video effects.

## Comparison of Python and Lua for scripting in OBS

Lua is by far less popular and less powerful than Python, but it is simpler on purpose (to reduce the footprint in the embedding executable) and better integrated in OBS (as of v26.1):

| Criteria | [Python](https://www.python.org) | [Lua](https://www.lua.org) |
|-------|--------|-----|
| Usage | Wide usage for everything | Sparse usage as embedded scripting extension (e.g. in [Wireshark](https://gitlab.com/wireshark/wireshark/-/wikis/Lua), [VLC](https://www.videolan.org/developers/vlc/share/lua/README.txt), etc) |
| Standard library | [Full-featured standard library](https://docs.python.org/3.6/library) | [Poor standard library](https://www.lua.org/manual/5.1) (use the OBS API or [FFI](https://luajit.org/ext_ffi.html) to fill the gaps) |
| Additional modules | Supported e.g. with pip | Supported for pure Lua modules, probably possible but complex for modules with binary |
| Interpreter | Not embedded | Fully embedded, based on [LuaJIT](http://luajit.org) |
| New source types | Not supported | [Supported with source_info](https://obsproject.com/docs/scripting.html#script-sources-lua-only) |

## Bindings

There is no strong layer of protection or consistency checking between scripting and binary functions. The C functions of the OBS API are bound to the scripting environment through _wrapper functions_ written in C and compiled into OBS libraries.

Typically, when a Python/Lua function is called in a script, the interpreter calls the related C wrapper function that implements these 3 steps:

1. Validation of the data given as arguments to the script function and conversion of this data from Python/Lua types to C types
2. Call to the original C function of the API
3. Conversion of the data returned by the C function from C types to Python/Lua types

Wrapper functions exist as well for "getters" and "setters", in order to access the members of OBS data structures, again with data conversion between C types and Python/Lua types.

Most wrapper functions are generated automatically by [SWIG](http://www.swig.org) during OBS build, based on the API functions definition in C. For a few complex C functions and structures, for which SWIG would not generate proper code automatically, wrapper functions are written manually. This is the case for frontend-related functions, `source_info` and functions with callback arguments (see the section [other differences from the C API](https://obsproject.com/docs/scripting.html#other-differences-from-the-c-api)).

:warning: Even if most functions are usable as intended (especially the ones specifically re-designed for scripting), a few functions with SWIG-written wrappers cannot be used directly for scripting so far, because SWIG cannot interpret properly the data types of arguments or return values given in the C definition. Typically, with values passed by reference or buffers, C pointers and pointer-pointer types are inherently ambiguous.

:boom: TODO: common type conversions

## API documentation

OBS has a huge API of C functions and data structures. Scripting-specific API features are described in the [OBS scripting documentation](https://obsproject.com/docs/scripting.html). The rest of the [API](https://obsproject.com/docs) is documented in the original C flavour only, there is no documentation of the functions and data structures as seen from the scripting environment so far.

These resources can be helpful:

- Example scripts delivered with OBS in `[InstallationFolder]/data/obs-plugins/frontend-tools/scripts`
- [An extensive OBS Python cheat sheet by upgradeQ](https://github.com/upgradeQ/OBS-Studio-Python-Scripting-Cheatsheet-obspython-Examples-of-API) (thanks to upgradeQ for this collection of snippets, many of them were re-used on this page)
- The forum page [Tips and tricks for Lua scripts](https://obsproject.com/forum/threads/tips-and-tricks-for-lua-scripts.132256)

## Script life-cycle

A script must define some [global script functions](https://obsproject.com/docs/scripting.html#script-function-exports) called by the scripting environment at different stages of the script life-cycle and at different execution phases of OBS. The following steps are performed wherever the related global script functions are implemented.

### OBS startup

When a script was previously added to OBS, at startup:

1. The content of the script file is read and interpreted in a new script execution context (global script functions are defined during this first execution)
2. `script_defaults(settings)` is called to initialize default values in data settings
3. `script_description()` is called to retrieve a description string to be displayed in the _Scripts_ window (with [Qt-style formatting](https://doc.qt.io/qt-5/richtext-html-subset.html) :bulb:)
4. `script_load(settings)` is called for one-time initialization, possibly using values of data settings (typically to setup signal handlers)
5. `script_update(settings)` is called a first time to dispatch values of data settings (this function will be called again after any change of value in the data settings)

Please note that:

- The values of the data settings during OBS startup reflect the state saved at previous OBS closure, and are already set in `settings` when `script_defaults`, `script_load` and `script_update` are called
- Default values set through `script_defaults` are later available through [`obs_data_get_default_*`](https://obsproject.com/docs/reference-settings.html?highlight=obs_data_get_default#c.obs_data_get_default_string) functions but should have no effect during OBS startup because all values should be already set (saved at previous OBS closure)
- During OBS startup, the steps 1 to 5 are performed _before_ loading the scenes and sources in the frontend (before `OBS_FRONTEND_EVENT_FINISHED_LOADING` is emitted). This is especially important in `script_update` if sources or scenes are looked up.

### Normal OBS use

During OBS execution, once a script is initialized, `script_tick(seconds)` is called at every rendered frame (`seconds` is the time in seconds passed since the previous frame). Be very careful with the code in `script_tick`, OBS may rapidly become unresponsive if some error is logged at each frame.

### OBS closure

Two global script functions are called when OBS is closed:

1. `script_save(settings)` is called just before saving the data settings persistently
2. `script_unload()` is called just before the destruction of the script execution context

Data settings are saved automatically at OBS closure, it is not necessary for the script to call any function to save data settings (and not necessary to implement `script_save` nor `script_unload` to trigger OBS to save data set by a script).

### Displaying and changing script properties

Once OBS startup is completed, `script_properties()` is called by OBS at the first display of the _Scripts_ window (no subsequent call except when adding/reloading a script or resetting the defaults).

The function has to return an `obs_properties_t` object created using [obs_properties_create](https://obsproject.com/docs/reference-properties.html#c.obs_properties_create). The properties object will be typically filled with GUI elements though [`obs_properties_add_*`](https://obsproject.com/docs/reference-properties.html?highlight=obs_properties_add#c.obs_properties_add_bool) functions, and will be released by OBS when necessary.

A callback function can be set to each property using [`obs_property_set_modified_callback`](https://obsproject.com/docs/reference-properties.html#c.obs_property_set_modified_callback).

When the value of a property is changed, the sequence is:

1. `script_update(settings)` is called to dispatch the values of modified data settings
2. The callback of the modified property is called

Please note that:

- :bulb: The description of a property supports [Qt-style formatting](https://doc.qt.io/qt-5/richtext-html-subset.html)
- :bulb: A callback function set on a property with  has to return true to trigger the refresh of the displayed properties (no new call to `script_properties`)
- If another property or data setting is modified per script, e.g. in `script_update`, then its callback is not triggered automatically, use [`obs_properties_apply_settings`](https://obsproject.com/docs/reference-properties.html#c.obs_properties_apply_settings) to trigger all callbacks (e.g. in `script_update` with a properties object saved in a global variable in `script_properties`)

### Other script management operations

The other operations available on the _Scripts_ window trigger more complex sequences (described in this section as in OBS v26.1, the behavior may change in the future).

Adding a script:

- Initialization steps like in OBS startup except that values of data settings are not available:

  1. first execution
  2. `script_defaults`
  3. `script_description`
  4. `script_load`
  5. `script_update`

- Then because the _Scripts_ window is already displayed when adding a script, and to initialize everything:

  6. `script_properties`
  7. Call to all "modified callbacks", for all properties (with data settings still not available)
  8. `script_properties` again
  9. `script_update` with data settings available
  10. Call to the "modified callbacks" of properties actually changed in previous steps

:warning: The complete sequence may lead to inconsistencies if not carefully taken into account, because the same functions are called multiple times, including property callbacks at step 7, while data settings are not available.

Removing a script just triggers a call to `script_unload` (_not_ `script_save`).

Resetting to defaults starts with a call to `script_update`, then the same as removing a script and then re-adding it.

Reloading a script is the same as removing a script and then re-adding it, except that data settings are available all the time.


## Getting started



Other tutorials:

- [Bouncing background logo tutorial at jbscript.dev](https://jbscript.dev/my-first-lua-and-obs-script/) in Lua
- Tutorial by upgradeQ in Lua, [part 1](https://translate.google.com/translate?sl=ru&tl=en&u=https%3A%2F%2Fhabr.com%2Fru%2Fpost%2F520684%2F) (global script functions, timers, hotkeys) and [part 2](https://translate.google.com/translate?sl=ru&tl=en&u=https%3A%2F%2Fhabr.com%2Fru%2Fpost%2F522278%2F) (setting filter parameters, events)

## Troubleshooting

It is common to experience OBS crashes or unexpected behavior during the development. A few hints:

- Scripts are loaded very early when OBS starts, before the GUI appears. Depending on what the script does at start, it may lead to a very long start time (e.g. shader compilation with unrolled loops).
- If OBS crashes at start due to a script, or wrong parameters given to a script, it won't be possible to de-activate the faulty script in the _Scripts_ dialog window. To recover: rename the script, start OBS, remove the faulty script from the list of attached scripts, etc.
- Logging can be very slow (even if no log window is actually displayed), so that OBS may freeze when too much data is logged at once, or may become unresponsive after a couple of minutes. This is especially true when data is logged at every frame, e.g. when a recurrent error occurs in `script_tick`. It may be necessary to close the OBS window or even kill the process to recover.
- Many functions in OBS allocate data that needs to be released. This is the meaning of the warning in the documentation: _release/destroy objects you reference or create via the API_. For instance, a call to [`obs_get_current_scene`](https://obsproject.com/docs/reference-frontend-api.html?#c.obs_frontend_get_current_scene) must be followed by a call to [`obs_source_release`](https://obsproject.com/docs/reference-sources.html#c.obs_source_release) otherwise OBS may crash on exit (with "Freeing OBS context data" as last log entry).  As a rule of thumb, if the API documentation states "Returns: A new reference ..." then a call to a release function is probably necessary.

## TODO - Questions/information gathered from Discord

Currently missing in the documentation:

- script_description
- release after get current scene


### General

- common type conversion in Lua and Python
- unique identifier for scenes (or sources), bc obs_source_get_id seems to only return scene
- internationalization / localization
- docs for scripting say that we should manually free the properties that we create
- obs.blog()
- wondering if there's a way to add external Python library dependencies as part of the imported script, also wondering what's the development loop with scripts — do you need to reimport every time you make a change?

For the full flow of starting a script the first time, the order would be:

--- script is loaded ---
1. script_defaults
2. script_load
3. script_update
4. script_properties
5. callbacks (with null data) [note: no script_update immediately preceding the callbacks]
--- script is clicked on ---
6. script_properties
7. script_update
8. callbacks
--- then when a property is modified ---
1. script_update
2. callbacks


### Properties

- obs_properties_apply_settings, refresh after change
- https://obsproject.com/docs/reference-properties.html#c.obs_properties_add_group 
- modify a script's setting current value from the script? I thought obs_properties_apply_settings might be it, but that doesn't seem to work. Looks like holding onto a reference to the settings object passed into script_update actually works it just doesn't update the UI in the settings screen unless you leave and come back 
- modify a source's property everytime there's a transition to a specific scene, is that possible?

### Access global data

- Does scripting allow me to access twitch activity/stats dock content to save that info into files ?

- access the data in the stats panel re. streaming / network status via scripting, I want to put some of it into a scene

- scripts are able to change a video capture device's properties?

- is there a way to change the scene order by script? (so essentially what you would do with the up and down arrows under the scene list in the ui)

### React to signals

- react to OBS_FRONTEND_EVENT_SCENE_CHANGED and other signals
- get a "stream stopped" event? (Reason being that, to work properly with our video platform, a user needs to call an API to signal stream completion otherwise we buffer for the length of our RTMP reconnect window.) I realize I can poll every frame, but that seems wasteful. Your service plugin should register a signal listener on the output plugin for the stop signal

### Control

- control playback of a Media Source see https://obsproject.com/docs/reference-sources.html#c.obs_source_info.media_play_pause
- run a script at the end of a VLC Source playlist, see https://obsproject.com/forum/threads/trigger-after-media-source-playback-ends.118986/ 
- script in which i'm updating a text source. It all works fine, but the only problem I still have is that in duplicate source mode only the preview text source is updated. What's the best way to update the live text source as well?
- hides or shows a specific source
- make a "wrapper" or "derived" source type that hides parameters that my script controls and exposes to the user any parameters from the original source can still customize. e.g., like a "custom text source" where the user has all the options they normally would for a text source, except the actual text is set by my script
- start 6 videos  (data source) in the same time. How can I do that?

As for now we are recording in mkv the program, which has the signal we want to make replays. Also we have set a preview scene with a VLC source in it:

- Now execute the script. 
- The script will set to the VLC "Replay" source the mkv file we are recording now.
- Then will ask you to push F10 to save a time stamp or push F12 to show the timestamps we saved and select the one we want.
- When a time stamps is selected, the script will refresh  the VLC "Replay" source and will set the video just in the second we selected.
- Now you can add a NDI filter or a Virtual cam filter to the VLC "Replay" source, and use it as replay source in other PC
- find or make a script for OBS to show Source or Scene while I am holding a button? Something similar for push-to-talk...
 
### Draw on screen

- gifs in a folder I'd like to display at random by using a command or hotkey but I don't want to have to individually add all of them as sources to obs

- is there a script that shows a text every X minutes on the screen?

### Audio

- enable the microphone in a browser source

- script that will allow a macro to be pressed when my mic hits a certain DB? voicemeeter banana comes with "macro buttons" that allow executing an action when a volume threshold is breached; try that
