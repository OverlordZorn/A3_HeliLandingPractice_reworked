#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {};
        author = AUTHOR;
        authors[] = { AUTHORS };
        authorUrl = "";
        VERSION_CONFIG;
    };
};

#include "CfgFunctions.hpp"
//GUI
#include "VVS\menu.h"

class CfgTaskTypes
{
    class Land
    {
        icon = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\land_ca.paa";
    };
};
