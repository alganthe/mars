class MARS_gui_ctrlButton: MARS_gui_ctrlDefaultButton {
    type = CT_BUTTON;
    style = ST_CENTER + ST_UPPERCASE;
    colorBackground[] = {0,0,0,1};
    colorBackgroundDisabled[] = {0,0,0,0.5};
    colorBackgroundActive[] = {QCOLOR_ACTIVE_RGBA};
    colorFocused[] = {QCOLOR_ACTIVE_RGBA};
    font = FONT_THIN;
    text = "";
    size = SIZEEX_PURISTA_M;
    sizeEx = SIZEEX_PURISTA_M;
    colorText[] = {COLOR_TEXT_RGBA};
    colorDisabled[] = {COLOR_TEXT_RGB,0.25};
    borderSize = 0;
    colorBorder[] = {0,0,0,0};
    colorShadow[] = {0,0,0,0};
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = pixelW;
    offsetPressedY = pixelH;
    period = 0;
    periodFocus = 2;
    periodOver = 0.5;
    onCanDestroy = "";
    onDestroy = "";
    onMouseEnter = "";
    onMouseExit = "";
    onSetFocus = "";
    onKillFocus = "";
    onKeyDown = "";
    onKeyUp = "";
    onMouseButtonDown = "";
    onMouseButtonUp = "";
    onMouseButtonClick = "";
    onMouseButtonDblClick = "";
    onMouseZChanged = "";
    onMouseMoving = "";
    onMouseHolding = "";
    onButtonClick = "";
    onButtonDown = "";
    onButtonUp = "";

    class KeyHints {
        class A {
            key = KEY_XBOX_A;
            hint = "KEY_XBOX_A";
        };
    };
};

class MARS_gui_ctrlButtonPicture: MARS_gui_ctrlButton {
    style = ST_CENTER + ST_PICTURE;
};

class MARS_gui_ctrlButtonPictureKeepAspect: MARS_gui_ctrlButton {
    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
};

class MARS_gui_ctrlButtonOK: MARS_gui_ctrlButton {
    default = 1;
    idc = IDC_OK;
    text = "";
};

class MARS_gui_ctrlButtonCancel: MARS_gui_ctrlButton {
    idc = IDC_CANCEL;
    text = "";
};

class MARS_gui_ctrlButtonClose: MARS_gui_ctrlButtonCancel {
    text = "";
};

class MARS_gui_ctrlButtonToolbar: MARS_gui_ctrlButtonPictureKeepAspect {
    colorBackground[] = {0,0,0,0};
    colorBackgroundDisabled[] = {0,0,0,0};
    offsetPressedX = 0;
    offsetPressedY = 0;
};

class MARS_gui_ctrlButtonSearch: MARS_gui_ctrlButton {
    style = ST_CENTER + ST_PICTURE + ST_KEEP_ASPECT_RATIO;
    text = "\a3\3DEN\Data\Displays\Display3DEN\search_start_ca.paa";
    textSearch = "\a3\3DEN\Data\Displays\Display3DEN\search_end_ca.paa";
    tooltip = "";
};

class MARS_gui_ctrlButtonFilter: MARS_gui_ctrlButton {
    colorBackground[] = {0,0,0,0};
    colorBackgroundDisabled[] = {0,0,0,0};
    colorBackgroundActive[] = {1,1,1,0.3};
    colorFocused[] = {0,0,0,0};
};

class MARS_gui_ctrlButtonStatic: MARS_gui_ctrlButton {
    style = ST_MULTI + ST_NO_RECT;
    colorText[] = {1,1,1,0.5};
    colorBackground[] = {COLOR_BACKGROUND_RGBA};
    colorFocused[] = {COLOR_BACKGROUND_RGBA};
    colorBackgroundActive[] = {COLOR_BACKGROUND_RGBA};
    colorShadow[] = {1,1,1,0.5};
    offsetPressedX = 0;
    offsetPressedY = 0;
    size = SIZEEX_PURISTA_L;
    sizeEx = SIZEEX_PURISTA_L;
};

class MARS_gui_ctrlButtonCheckboxLabel: MARS_gui_ctrlButton {
    style = ST_MULTI + ST_NO_RECT;
    colorText[] = {COLOR_TEXT_RGB,0.7};
    colorDisabled[] = {COLOR_TEXT_RGB,0.25};
    colorFocused[] = {COLOR_TEXT_RGBA};
    colorBackground[] = {COLOR_BACKGROUND_RGBA};
    colorBackgroundActive[] = {COLOR_BACKGROUND_RGBA};
    colorBackgroundDisabled[] = {COLOR_BACKGROUND_RGBA};
    colorShadow[] = {1,1,1,0.5};
    offsetPressedX = 0;
    offsetPressedY = 0;
    size = SIZEEX_PURISTA_L;
    sizeEx = SIZEEX_PURISTA_L;
};

class MARS_gui_ctrlButtonStaticAlignRight: MARS_gui_ctrlButtonStatic {
    style = ST_MULTI + ST_NO_RECT + ST_RIGHT + ST_VCENTER;
    size = SIZEEX_PURISTA_M;
    sizeEx = SIZEEX_PURISTA_M;
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0.75};
    colorBackgroundDisabled[] = {0,0,0,0.25};
    colorBackgroundActive[] = {0,0,0,0.75};
    colorFocused[] = {0,0,0,0.75};
    colorDisabled[] = {COLOR_TEXT_RGB,0.25};
};

class MARS_gui_ctrlButtonStaticFooter: MARS_gui_ctrlButtonStaticAlignRight {
    colorText[] = {COLOR_BACKGROUND_RGBA};
    colorBackground[] = {COLOR_BACKGROUND_RGBA};
    colorBackgroundDisabled[] = {COLOR_BACKGROUND_RGBA};
    colorBackgroundActive[] = {COLOR_BACKGROUND_RGBA};
    colorFocused[] = {COLOR_BACKGROUND_RGBA};
};

class MARS_gui_ctrlButtonVectorX: MARS_gui_ctrlButtonCheckboxLabel {
    style = ST_MULTI + ST_NO_RECT + ST_CENTER + ST_VCENTER;
    colorText[] = {COLOR_TEXT_RGBA};
    colorBackground[] = {COLOR_POSX_RGBA};
    colorBackgroundActive[] = {COLOR_POSX_RGBA};
    colorBackgroundDisabled[] = {COLOR_POSX_RGBA};
    text = "X";
};

class MARS_gui_ctrlButtonVectorY: MARS_gui_ctrlButtonVectorX {
    colorBackground[] = {COLOR_POSY_RGBA};
    colorBackgroundActive[] = {COLOR_POSY_RGBA};
    colorBackgroundDisabled[] = {COLOR_POSY_RGBA};
    text = "Y";
};

class MARS_gui_ctrlButtonVectorZ: MARS_gui_ctrlButtonVectorX {
    colorBackground[] = {COLOR_POSZ_RGBA};
    colorBackgroundActive[] = {COLOR_POSZ_RGBA};
    colorBackgroundDisabled[] = {COLOR_POSZ_RGBA};
    text = "Z";
};

class MARS_gui_ctrlButtonAttributes: MARS_gui_ctrlButton {
    style = ST_CENTER + ST_UPPERCASE;
    size = SIZEEX_PURISTA_S;
    sizeEx = SIZEEX_PURISTA_S;
};
