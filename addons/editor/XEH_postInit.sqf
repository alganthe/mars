#include "script_component.hpp"

if (isServer) then {
    private _settings = (configFile >> "ACE_ServerSettings" >> QGVAR(players));
    
    if (isClass _settings) then {
        missionNamespace setVariable [QGVAR(alwaysAllowLoginWhenEmpty), INT2BOOL(getNumber (_settings >> "alwaysAllowLoginWhenEmpty")), true];
        missionNamespace setVariable [QGVAR(whitelisted), getArray (_settings >> "whitelisted"), true];
        missionNamespace setVariable [QGVAR(blacklisted), getArray (_settings >> "blacklisted"), true];
    } else {
        GVAR(alwaysAllowLoginWhenEmpty) = true;
        GVAR(whitelisted) = [];
        GVAR(blacklisted) = [];
    };
};

if (isNil QGVAR(initialLoginPlayer)) then {
    GVAR(initialLoginPlayer) = objNull;
    publicVariable QGVAR(initialLoginPlayer);
};

[QMODNAME, "OpenMissionEditor", ["Open Mission Editor", "Press to open the mission editor interface"], {
    if (GVAR(isRemoteControl)) then {
        [false] call FUNC(exitRemoteControl);
    };
    
    [] call FUNC(openEditor);
}, ""] call CBA_fnc_addKeybind;

// Object creation handler
[QGVAR(spawnObject), {
    _this call FUNC(spawnObject);
    
    #ifdef DEBUG_MODE_FULL
        MARS_LOGINFO("Spawned object(s)");
    #endif
}] call CBA_fnc_addEventHandler;

// Is this needed?
createCenter west;
createCenter east;
createCenter resistance;
createCenter civilian;

[QGVAR(setDir), {
    params ["_unit", "_dir"];
    _unit setFormDir _dir;
    _unit setDir _dir;
}] call CBA_fnc_addEventHandler;