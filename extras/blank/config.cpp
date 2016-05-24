#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mars_common"};
        author[] = {"Kingsley"};
        authorUrl = "https://github.com/jameslkingsley/mars";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgMenu.hpp"
#include "CfgToolbar.hpp"
#include "CfgContext.hpp"
