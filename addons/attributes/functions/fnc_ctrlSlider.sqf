/*
 * Author: Kingsley
 * Creates a slider control
 *
 * Arguments:
 * 0: Control config <STRING>
 * 1: IDC <NUMBER>
 * 2: Position <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["configFile >> 'SomeConfig'", 100, [0,0,0,0]] call mars_attributes_fnc_ctrlSlider;
 *
 * Public: No
 */

#include "script_component.hpp"

params [
    ["_config", "", [""]],
    ["_idc", -1, [0]],
    ["_position", [0,0,0,0], [[]]]
];

_config = call compile _config;
_display = GETUVAR(GVAR(interface),displayNull);

_categoryGroup = _display displayCtrl IDC_EDITATTRIBUTES_CATEGORIES;
_controlGroup = _display displayCtrl IDC_EDITATTRIBUTES_CATEGORIES_ITEMS;

_ctrlSlider = _display ctrlCreate ["MARS_gui_ctrlXSliderH", _idc, _controlGroup];
_ctrlSlider ctrlSetPosition _position;

_range = getArray (_config >> "range");
_step = getNumber (_config >> "step");
_startPos = [getNumber (_config >> "position"), call compile getText (_config >> "position")] select (isText (_config >> "position"));

if (count _range > 2) then {
    MARS_LOGERROR_1("Range array has more than 2 values in %1. Ignoring extra values.", _config);
    _range resize 2;
};

_ctrlSlider sliderSetRange _range;
_ctrlSlider sliderSetSpeed [_step, _step];
_ctrlSlider sliderSetPosition _startPos;

{
    _x params ["_configEvent","_runtimeEvent"];
    if (!isNull (_config >> _configEvent)) then {
        _ctrlSlider ctrlAddEventHandler [_runtimeEvent, getText (_config >> _configEvent)];
    };
} forEach [
    ["onSliderPosChanged", "SliderPosChanged"]
];

_ctrlSlider ctrlCommit 0;