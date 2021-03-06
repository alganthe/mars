/*
 * Author: Kingsley
 * Orders the given units to suppress the given position
 *
 * Arguments:
 * 0: Units that will suppress <ARRAY>
 * 1: Position to suppress <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[u1, u2], [0,0,0]] call mars_ai_fnc_suppress;
 *
 * Public: Yes
 */

#include "script_component.hpp"

params [["_args", []], ["_broadcast", false]];
_args params [["_units", []], ["_pos", []]];

if (_units isEqualTo [] || {_pos isEqualTo []}) exitWith {};

if (_broadcast) then {
    [QGVAR(suppress), [_units, _pos], _units] call CBA_fnc_targetEvent;
} else {
    {
        _x lookAt _pos;
        _x doSuppressiveFire _pos;
        
        false
    } count _units;
};
