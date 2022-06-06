/*
Much kudos to killzonekid. Nice workaround.
Just the thing, that idd 53 is not anymore the Diary briefing.
The addition to the config, will deal with that and will always take the correct idd.
https://forums.bohemia.net/forums/topic/193040-skip-briefing-in-mp-mission/
*/

if (hasInterface) then {
    if (!isNumber (missionConfigFile >> "briefing")) exitWith {};
    if (getNumber (missionConfigFile >> "briefing") == 1) exitWith {};
    [] spawn {
        private "_d";
        _d = (getNumber (configfile >> "RscDisplayServerGetReady" >> "idd"));
        waitUntil{
            if (getClientState == "BRIEFING READ") exitWith {true};
            if (!isNull findDisplay _d) exitWith {
                ctrlActivate (findDisplay _d displayCtrl 1);
                findDisplay _d closeDisplay 1;
                true
            };
            false
       };
    };
};