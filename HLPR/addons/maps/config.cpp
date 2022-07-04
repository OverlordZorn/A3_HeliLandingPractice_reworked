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

class CfgMissions {
    class Missions {
        class HLPR_Altis {
            briefingName = $STR_HLPR_map_Altis_brifingName;
            directory = "x\HLPR\addons\maps\HLPR_Altis.Altis";
        };
    };
};
