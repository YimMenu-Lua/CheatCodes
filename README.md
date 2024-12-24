# CheatCodes
Enables the single-player cheat codes in GTA Online.

You can also register custom cheat codes to use in your scripts using the `REGISTER_CUSTOM_CHEAT` function. Example Usage:
```lua
function YOUR_CHEAT_FUNCTION()
    -- Do stuff...
end

-- Put this in a loop.
REGISTER_CUSTOM_CHEAT("YOUR_CHEAT_CODE", YOUR_CHEAT_FUNCTION)
```