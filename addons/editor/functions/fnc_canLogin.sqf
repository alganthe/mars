/*
 * Author: Kingsley
 * Checks whether the given player unit is eligible to login to Mars
 *
 * Arguments:
 * 0: Player unit <OBJECT, UID>
 *
 * Return Value:
 * Can login or not <BOOL>
 *
 * Example:
 * _canLogin = [player] call mars_editor_fnc_canLogin;
 *
 * Public: Yes
 */

#include "script_component.hpp"

params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {false};

private _uid = getPlayerUID _unit;

if (_uid in GVAR(blacklisted)) exitWith {false};

if (_uid in GVAR(whitelisted)) exitWith {true};

if (isNull GVAR(initialLoginPlayer) && {GVAR(alwaysAllowLoginWhenEmpty)}) exitWith {true};

false