class GVARMAIN(context) {
    class ADDON {
        class Artillery {
            displayName = CSTRING(Name);
            condition = QUOTE(\
                [EGVAR(editor,selection)] call FUNC(isArtillery) &&\
                {[_this] call FUNC(hasAmmo)} &&\
                {[EGVAR(editor,selection)] call CFUNC(isAllSameClass)}\
            );
            children = QFUNC(getAmmoTypeOptions);
        };
    };
};