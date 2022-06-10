/*	KiloSwiss	*/
private _logic = _this param [0, objnull, [objnull]];

if (typeof _logic == "Logic" /*"ModuleRespawnVehicle_F"*/) then
{
	_logic setVariable ["Delay","15"];
	_logic setVariable ["DesertedDelay","30"]; //--- Obsolete, left because of backward compatibility
	_logic setVariable ["DesertedDistance","150"];
	_logic setVariable ["RespawnCount","-1"];
	_logic setVariable ["Init","_this call KS_fnc_setupVehicle"];
	_logic setVariable ["Position","0"];
	_logic setVariable ["PositionType","0"];
	_logic setVariable ["Wreck","1"];
	_logic setVariable ["ShowNotification","1"];
	_logic setVariable ["ForcedRespawn","1"];
	_logic setVariable ["RespawnWhenDisabled", true];
};