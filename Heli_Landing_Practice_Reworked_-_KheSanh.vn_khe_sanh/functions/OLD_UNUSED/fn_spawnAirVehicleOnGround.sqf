/*
	KiloSwiss
	
	Usage:
	["ClassName", Marker or Position/Coordinates] call KS_fnc_spawnAirVehicleOnGround;
	["B_Heli_Transport_01_F", "HeliSpawn_0"] call KS_fnc_spawnAirVehicleOnGround;
	["B_Plane_Fighter_01_F", [843, 1106, 0]] call KS_fnc_spawnAirVehicleOnGround;
	
	Returns the spawned vehicle or objNull.
*/

params [ ["_type", "", [""] ], ["_spawnPos", [0,0,0], ["",[]] ] ];
private _return = objNull;

if ( _type isKindOf "Air" ) then
{
	if ( typeName _spawnPos isEqualTo "STRING" ) then
	{
		_spawnPos = getMarkerPos _spawnPos;
		// If marker does not exist (wrong name), returned position is [0,0,0].
	};
	
	if ( count _spawnPos isEqualTo 3 ) then
	{
		private _vehicle = createVehicle [_type, _spawnPos, [], 0, "FLY"];
		
		[_vehicle, true] call KS_fnc_unitActionLandingGear;
		
		[_vehicle, _spawnPos] spawn
		{
			params ["_vehicle", "_spawnPos"];
			private _delay = time + ( [2, 5] select ( _vehicle isKindOf "Plane" ) );
			while { time < _delay } do { _vehicle setPos _spawnPos };
		};
		
		_return = _vehicle;
	};
};

_return	
