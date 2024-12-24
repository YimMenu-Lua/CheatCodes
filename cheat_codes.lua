local cheat_handler_patch = memory.scan_pattern("40 55 41 54 41 55 41 56 41 57 48 83 EC ? 48 8D 6C 24 ? 48 89 5D ? 48 8D 0D"):add(53):patch_byte({0x90, 0x1A})
local cheat_code_hash     = memory.scan_pattern("39 0D ? ? ? ? 75 ? 83 25"):add(2):rip()

cheat_handler_patch:apply()

cheat_controller_patch1 = scr_patch:new("cheat_controller", "ACCIMP1", "71 2C 04 00 8A", 0, {0x2E, 0x00, 0x00})
cheat_controller_patch2 = scr_patch:new("freemode", "ACCIMP2", "59 09 00 64 56 C0 05", 0, {0x55})

-- Put your custom cheats into the main loop using this function.
-- cheat_code (string): The cheat code of your custom cheat.
-- callback (function): Function to be executed for your custom cheat.
function REGISTER_CUSTOM_CHEAT(cheat_code, callback)
    if cheat_code_hash:get_dword() == joaat(cheat_code) then
        callback()
        cheat_code_hash:set_dword(0)
    end
end

-- These two functions can be used for error/success handling of your custom cheat.
function DISPLAY_CHEAT_SUCCESS_NOTIFICATION(text)
    HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("Cheat activated:~n~~a~" .. text)
    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(false, true)
end

function DISPLAY_CHEAT_ERROR_NOTIFICATION(text)
    HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(false, true)
end

-- Here's an example cheat that enables/disables the snow.
local function EXAMPLE_CHEAT_TURN_SNOW_ON_OFF()
    if network.is_session_started() then
        local value = tunables.get_bool("TURN_SNOW_ON_OFF")
        tunables.set_bool("TURN_SNOW_ON_OFF", not value)
        DISPLAY_CHEAT_SUCCESS_NOTIFICATION((value and "Disable" or "Enable") .. " Snow.")
    else
        DISPLAY_CHEAT_ERROR_NOTIFICATION("Can't activate that cheat right now.")
    end
end

event.register_handler(menu_event.ScriptsReloaded, function()
    cheat_controller_patch1:disable_patch()
    cheat_controller_patch2:disable_patch()
end)

script.register_looped("Cheat Codes", function(sc)
    ENSURE_CHEAT_CONTROLLER_IS_RUNNING(sc)
    
    REGISTER_CUSTOM_CHEAT("EXAMPLECHEATSNOW", EXAMPLE_CHEAT_TURN_SNOW_ON_OFF) -- Registering your custom cheat
end)