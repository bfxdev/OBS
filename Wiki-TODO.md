## TODO - Questions/information gathered from Discord


:boom: TODO: common type conversions in section bindings

:boom: TODO: generalize description of libobs objects with source_info https://obsproject.com/docs/backend-design.html?highlight=reference#libobs-plugin-objects


Currently missing in the documentation:

- script_description
- release after get current scene
- get_current_scene (and other frontend functions?)


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



### To be sorted

[12:16 AM] voodooDoubloon: Looking for a script to overlay twitch follow alerts for OBS? Can someone point me in the general direction? Browsing scripts directory didnt help.
[2:40 AM] voodooDoubloon: fyi not looking for plugin or streamlabs functionality.  Would like to hand code or modify a script if available.
[2:46 AM] Matt | WizardCM: it'd have to be a lua script that adds a new source, or a python script that modifies an existing source in the scene



Hello everyone! I am currently working on a project in which I wanted to use the LUA Countdown Script, however I have been attempting to modify it to allow me to add an extra digit of time (from 5 to 6) in the Duration setting, which I succeeded in
And then I attempted to add an extra Days segment to the code, in hopes that it would work. however it seems the Hours segment doesn't want to function properly (marked each segment with D, H, M S (Days, hours, minutes, seconds))

