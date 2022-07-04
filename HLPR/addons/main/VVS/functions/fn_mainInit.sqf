#include "..\..\script_component.hpp"
[] call compile PreprocessFileLineNumbers QPATHTOFOLDER(VVS\configuration.sqf);
VVS_Checkbox = false;
[] spawn VVS_fnc_buildCfg;
