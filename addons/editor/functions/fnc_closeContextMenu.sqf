/*
 * Author: Kingsley
 * Closes any open context menu
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * N/A
 *
 * Public: No
 */

#include "script_component.hpp"

{
    ctrlDelete (GETUVAR(GVAR(interface),displayNull) displayCtrl _x);
} forEach GVAR(allContextControls);

/*if (!isNil QGVAR(contextPosLinePFH)) then {
    [GVAR(contextPosLinePFH)] call CBA_fnc_removePerFrameHandler;
};*/

GVAR(allContextControls) = [];
GVAR(parentContextControls) = [];
GVAR(childContextControls) = [];
GVAR(isMouseOverChild) = false;