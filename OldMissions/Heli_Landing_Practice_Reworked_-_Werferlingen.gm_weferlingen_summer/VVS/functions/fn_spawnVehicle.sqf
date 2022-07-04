/*
	File: fn_spawnVehicle.sqf
	Author: Bryan "Tonic" Boardwine
	
	Edits made by KiloSwiss.
	
	Description:
	Spawns the selected vehicle, if a vehicle is already on the spawn point
	then it deletes the vehicle from the spawn point.
*/
disableSerialization;
private["_position","_direction","_className","_displayName","_spCheck","_cfgInfo"];
if(lnbCurSelRow 38101 == -1) exitWith {systemChat "You did not select a vehicle to spawn!"};

_className = lnbData[38101,[(lnbCurSelRow 38101),0]];
_displayName = lnbData[38101,[(lnbCurSelRow 38101),1]];
_position = getMarkerPos VVS_SP;
_direction = markerDir VVS_SP;

//Make sure the marker exists in a way.
if(isNil "_position") exitWith {systemChat "The spawn point marker doesn't exist?";};

//Check to make sure the spawn point doesn't have a vehicle on it, if it does then delete it.
_spCheck = nearestObjects[_position,["landVehicle","Air","Ship"],12];
if(count _spCheck > 0) then { {_x setPos [0,0,0]; deleteVehicle _x}forEach _spCheck;};

//if ( _className find "CUP_C_SA330" == 0 ) then { _position set [2, _position #2 +1] };

_vehicle = _className createVehicle _position;
_vehicle allowDamage false;
_vehicle setPos _position; //Make sure it gets set onto the position.
_vehicle setDir _direction; //Set the vehicles direction the same as the marker.
//_vehicle call KS_fnc_moveOnTop;
_vehicle call KS_fnc_setupVehicle;

[_vehicle, 5, 5, -1, {_this call KS_fnc_setupVehicle}, 0, 0, 1, 1, 0, 150, true] call KS_fnc_respawnVehicle;

if(VVS_Checkbox) then
{
	_vehicle call KS_fnc_instantTakeOff;
	player moveInDriver _vehicle;
	_vehicle allowDamage true;
	player allowDamage true;
	closeDialog 0;
	VVS_Checkbox = false;
};

systemChat format["You have spawned a %1",_displayName];
//closeDialog 0;
