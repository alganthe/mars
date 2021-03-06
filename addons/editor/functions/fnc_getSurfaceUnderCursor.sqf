/*
 * Author: Kingsley
 * Gets the surface detected underneath the cursor position in world space
 *
 * Arguments:
 * 0: Ignore object (optional) <OBJECT>
 *
 * Return Value:
 * Surface position ASL <POSITION>
 *
 * Example:
 * _pos = [] call mars_editor_fnc_getSurfaceUnderCursor;
 *
 * Public: Yes
 */

#include "script_component.hpp"

params [["_ignoreObj", objNull, [objNull]]];

private ["_worldPos", "_camPos", "_objects"];

_worldPos = AGLtoASL (screenToWorld GVAR(mousePos));
_camPos = getPosASLVisual GVAR(camera);

_objects = lineIntersectsSurfaces [
    _camPos,
    _worldPos,
    GVAR(camera),
    _ignoreObj,
    true,
    1
];

if (count _objects > 0) exitWith {
    ((_objects select 0) select 0)
};

_worldPos