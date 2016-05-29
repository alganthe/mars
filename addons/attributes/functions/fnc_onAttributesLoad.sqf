/*
 * Author: Kingsley
 * Creates the attributes GUI
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Component <STRING>
 * 2: Attribute class <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [displayNull, "mars_environment", "environment"] call mars_attributes_fnc_onAttributesLoad;
 *
 * Public: No
 */

#include "script_component.hpp"
#include "\z\mars\addons\common\macros.hpp"

params [
    ["_display", displayNull, [displayNull]],
    ["_component", "", [""]],
    ["_attribute", "", [""]]
];

SETUVAR(GVAR(interface),_display);

#define CONTROL(IDC) (_display displayCtrl IDC)
#define LABEL_RATIO 0.25
#define FIELD_RATIO 0.75
#define CATEGORY_Y_IOFFSET -(GRID_H * 2)
#define ITEM_SPACING GRID_H
#define CATEGORY_SPACING (SIZE_M * GRID_H)
#define CATEGORY_X CATEGORY_SPACING
#define CATEGORY_Y CATEGORY_SPACING
#define LABEL_WIDTH ((WINDOW_EDITATTRIBUTES_W * LABEL_RATIO) * GRID_W)
#define LABEL_HEIGHT (SIZE_M * GRID_H)
#define FIELD_WIDTH (((WINDOW_EDITATTRIBUTES_W * FIELD_RATIO) * GRID_W) - (CATEGORY_SPACING * 2) - GRID_W)

_header = (configFile >> QGVARMAIN(attributes) >> _component >> _attribute);

if (!isClass _header) exitWith {
    MARS_LOGERROR_2("Attribute is not a class: %1 >> %2", _component, _attribute);
};

GVAR(AttributesWindow_onConfirm) = ["AttributesWindow_onConfirm", {
    {
        _display = GETUVAR(GVAR(interface),displayNull);
        _ctrl = _display displayCtrl _x;
        _execExpression = _ctrl getVariable [QGVAR(execExpression), false];
        _execExpressionStr = _ctrl getVariable [QGVAR(execExpressionStr), ""];
        _execReturnData = _ctrl getVariable [QGVAR(execReturnData), _ctrl];
        
        if (_execExpression) then {
            _execReturnData call compile _execExpressionStr;
        };
        
        false
    } count GVAR(AttributesWindow_ItemControls);
    GVAR(AttributesWindow_ItemControls) = [];
}] call EFUNC(common,addEventHandler);

CONTROL(IDC_EDITATTRIBUTES_TITLE) ctrlSetText getText (_header >> "displayName");
_headerCtrlGroup = CONTROL(IDC_EDITATTRIBUTES_CATEGORIES);

_categories = "true" configClasses (_header >> "AttributeCategories");
_categoryIndex = 0;
_categoryIDC = IDC_EDITATTRIBUTES_CATEGORIES * 10;
_ctrlIDC = IDC_EDITATTRIBUTES_CATEGORIES * 1000;

_totalLabel = CATEGORY_Y_IOFFSET + ITEM_SPACING;
_totalField = 0;

{
    // Categories
    _catConfig = _x;
    _catPosX = CATEGORY_X;
    _catPosY = CATEGORY_Y;
    _catPosW = 0;
    
    _items = "true" configClasses (_catConfig >> "AttributeItems");
    _itemIDC = IDC_EDITATTRIBUTES_CATEGORIES * 100;
    _itemIndex = 0;
    
    {
        // Items
        _itemConfig = _x;
        _itemControls = "true" configClasses (_itemConfig >> "AttributeControls");
        _itemLabelY = LABEL_HEIGHT + ITEM_SPACING;
        _itemLabel = _display ctrlCreate ["MARS_gui_ctrlButtonStaticAlignRight", _itemIDC, _headerCtrlGroup];
        _itemLabel ctrlSetText getText (_itemConfig >> "displayName");
        _itemLabel ctrlSetTooltip getText (_itemConfig >> "tooltipText");
        
        _ctrlIndex = 0;
        _ctrlLargestHeight = 0;
        _ctrlIWidth = FIELD_WIDTH / count _itemControls;
        
        {
            // Controls
            _ctrlConfig = _x;
            
            _ctrlConfigPath = [
                "configFile",
                format ["'%1'", QGVARMAIN(attributes)],
                format ["'%1'", _component],
                format ["'%1'", _attribute],
                "'AttributeCategories'",
                format ["'%1'", configName _catConfig],
                "'AttributeItems'",
                format ["'%1'", configName _itemConfig],
                "'AttributeControls'",
                format ["'%1'", configName _ctrlConfig]
            ] joinString " >> ";
            
            _ctrlType = getText (_ctrlConfig >> "type");
            _ctrlCreateFunction = format ["%1_fnc_ctrl%2", QGVARMAIN(attributes), _ctrlType];

            if (!isNil _ctrlCreateFunction) then {
                _ctrlCreateCode = format [
                    "[""%1"", %7, %8, [%2,%3,%4,%5]] call %6",
                    _ctrlConfigPath,
                    CATEGORY_SPACING + LABEL_WIDTH + GRID_W + (_ctrlIndex * _ctrlIWidth),
                    _totalLabel + _itemLabelY,
                    _ctrlIWidth,
                    LABEL_HEIGHT,
                    _ctrlCreateFunction,
                    _ctrlIDC,
                    IDC_EDITATTRIBUTES_CATEGORIES
                ];
                
                _ctrlRet = call compile _ctrlCreateCode;
                GVAR(AttributesWindow_ItemControls) pushBackUnique (ctrlIDC _ctrlRet);
                
                _ctrlHeight = (ctrlPosition _ctrlRet) select 3;
                if (_ctrlHeight > _ctrlLargestHeight) then {
                    _ctrlLargestHeight = _ctrlHeight;
                    if (_ctrlHeight > LABEL_HEIGHT) then {
                        ADD(_totalLabel, (_ctrlHeight - CATEGORY_SPACING));
                    };
                };
            };
            
            INC(_ctrlIDC);
            INC(_ctrlIndex);
            
            false
        } count _itemControls;
        
        _itemLabelPosY = [(_totalLabel + _itemLabelY), ((_totalLabel + _itemLabelY) - _ctrlLargestHeight) + CATEGORY_SPACING] select (_ctrlLargestHeight > LABEL_HEIGHT);
        _itemLabel ctrlSetPosition [CATEGORY_SPACING, _itemLabelPosY, LABEL_WIDTH, LABEL_HEIGHT];
        _itemLabel ctrlCommit 0;
        
        ADD(_totalLabel, _itemLabelY);
        
        INC(_itemIDC);
        INC(_itemIndex);
        
        false
    } count _items;
    
    ADD(_totalLabel, CATEGORY_SPACING);
    
    INC(_categoryIDC);
    INC(_categoryIndex);
    
    false
} count _categories;

_footer = _display ctrlCreate ["MARS_gui_ctrlButtonStaticFooter", (_categoryIDC + 1), _headerCtrlGroup];
_footer ctrlSetPosition [0, _totalLabel, (WINDOW_EDITATTRIBUTES_W * GRID_W), LABEL_HEIGHT];
_footer ctrlCommit 0;

GVAR(AttributesWindow_onConfirm) = ["AttributesWindow_onConfirm", getText (_header >> "actionConfirm")] call EFUNC(common,addEventHandler);
GVAR(AttributesWindow_onCancel) = ["AttributesWindow_onCancel", getText (_header >> "actionCancel")] call EFUNC(common,addEventHandler);

(_display displayCtrl IDC_EDITATTRIBUTES_BTN_OK) ctrlAddEventHandler ["MouseButtonClick", {["AttributesWindow_onConfirm", _this] call EFUNC(common,localEvent)}];
(_display displayCtrl IDC_EDITATTRIBUTES_BTN_CANCEL) ctrlAddEventHandler ["MouseButtonClick", {["AttributesWindow_onCancel", _this] call EFUNC(common,localEvent)}];
