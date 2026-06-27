# WiPet Blender Helper

Use `tools/blender/wipet-blender` for WiPet 3D asset automation.

The helper resolves Blender in this order:

1. `WIPET_BLENDER_BIN`
2. `blender` on `PATH`
3. `/Applications/Blender.app/Contents/MacOS/Blender`

Example:

```sh
tools/blender/wipet-blender --background --python path/to/script.py
```
