/*	KiloSwiss	*/
params [ ["_newVehicle", objNull, [objNull,""] ], ["_oldVehicle", objNull, [objNull,""] ] ];

_newVehicle allowDamage false;
_newVehicle setVehicleAmmo 0;

clearItemCargoGlobal _newVehicle;
clearWeaponCargoGlobal _newVehicle;
clearMagazineCargoGlobal _newVehicle;
clearBackpackCargoGlobal _newVehicle;

// Unfortunately "weapons _vehicle" does not return all weapons from every vehicle turret.
{ _newVehicle removeWeaponGlobal _x } forEach weapons _newVehicle;

// This removes all weapons from every single turret (driver, gunner, commander) of a given vehicle.
{
	private _turret = _x;
	{
		_newVehicle removeWeaponTurret [_x, _turret];
	
	} forEach ( _newVehicle weaponsTurret _turret );

} forEach ( [[-1]] + allTurrets [_newVehicle, true] );

/*
_newVehicle = vehicle player;
{_t = _x; { _newVehicle removeWeaponTurret [_x, _t]} forEach (_newVehicle weaponsTurret _t); }forEach allTurrets [_newVehicle, true];
*/

[_newVehicle] call KS_fnc_addActionTakeOff;

/*
_newVehicle addEventHandler ["GetIn",
{
	params ["_newVehicle"];
	
	[_newVehicle, true] remoteExec ["allowDamage", _newVehicle];
}];

_newVehicle addEventHandler ["GetOut",
{
	params ["_newVehicle"];
	
	[_newVehicle, false] remoteExec ["allowDamage", _newVehicle];
}];
*/

//_oldVehicle setvariable ["BIS_fnc_moduleRespawnVehicle_getout", -1];