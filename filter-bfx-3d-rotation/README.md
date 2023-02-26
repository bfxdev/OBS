# BFX 3D Rotation Filter

This Lua script provides a filter called "BFX 3D Rotation", which can be added to a source to display it like a 3D object in space.

![animation](pics/obs-logo-animated.gif)

Main features:

- Very low extra GPU/CPU usage as the computation is only done at vertex level
- Rotations around X and Y axes (the rotation in the Transform can be used as third rotation)
- Several rotation control modes: around X-then-Y or Y-then-X or around an arbitrary axis
- Perspective strength can be set in one single parameter, from orthographic projection to extreme perspective deformation
- The rotation can be animated by setting a speed on the rotation angles

## Settings

![settings](pics/settings.png)





