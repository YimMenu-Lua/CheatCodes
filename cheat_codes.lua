local cheat_handler = memory.scan_pattern("40 55 41 54 41 55 41 56 41 57 48 83 EC ? 48 8D 6C 24 ? 48 89 5D ? 48 8D 0D")

local cheat_handler_patch1 = cheat_handler:add(53):patch_byte({0x90, 0x90, 0x90, 0x90, 0x90, 0x90})
local cheat_handler_patch2 = cheat_handler:add(66):patch_byte({0x90, 0x90, 0x90, 0x90, 0x90, 0x90})
	
cheat_handler_patch1:apply()
cheat_handler_patch2:apply()

-- TO-DO: Figure out how the fuck the script sometimes still manages to terminate itself although we patch it
local cheat_controller_patch1 = scr_patch:new("cheat_controller", "ACCIMP1", "2D 00 02 00 00 71 2C", 5, {0x2E, 0x00, 0x00})
local cheat_controller_patch2 = scr_patch:new("freemode", "ACCIMP2", "2C ? ? ? 2C ? ? ? 2C ? ? ? 06 56 ? ? 25", 0, {0x00, 0x00, 0x00, 0x00})

script.register_looped("CheatCodes", function()
	globals.set_int(33197, 0) -- Disable all "IS_CHEAT_DISABLED" bits
end)