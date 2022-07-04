

if ( isNil "KS_Locations" ) then
{
	[true, "blockMarker", 300] call KS_fnc_getLocations;
};

private _loc = selectRandom KS_locations;
private _pos = position _loc;
private _rad = ( size _loc #0 max size _loc #1 );
private _newPos = [_pos#0 + random(_rad*2)- _rad, _pos#1 + random(_rad*2)- _rad];

private _position = _newPos findEmptyPosition [0, _rad min 100, typeOf vehicle Player];

if !( _position isEqualTo [] ) then
{	
	private _vehicleSize = sizeOf typeOf vehicle player;
	private _nearObjects = nearestTerrainObjects [_position, ["TREE","SMALL TREE","FOREST","FOREST BORDER","FOREST TRIANGLE","FOREST SQUARE","BUILDING","HOUSE","HIDE"], _vehicleSize min 15];
	
	if ( count _nearObjects >= 3 ) then
	{
		systemChat format["%1 : nearestTerrainObjects: %2 - Search Radius: %3", time, count _nearObjects, _vehicleSize min 15];
		_position = [];
	}
	else
	{	
		_position isFlatEmpty
		[
			_vehicleSize min 15,			// Min Distance for surrounding objects
			-1,					// Mode (ALWAYS SET TO -1)
			0.1,					// maxGradient 0.1 (10%) ~6°, 0.5 (50%) ~27°, 1.0 (100%) ~45°
			_vehicleSize/2,				// maxGradientRadius
			0,					// overLandOrWater 0=Land 2=Water
			true,					// shoreLine
			nearestObject [_position, "Land_HighVoltageColumnWire_F"]	// ignoreObject
		];
		
		systemChat format["%1 : Check isFlatEmpty: %2", time, !(_position isEqualTo [])];
	};
};

if ( _position isEqualTo [] ) then
{
	systemChat format ["%1 : Search new Position", time];
	_position = call KS_fnc_getSafePos;
};

/* Testing in the editor:
vehicle player allowDamage false;
player allowDamage false;

0 = true spawn{ while{true}do{
_pos = call KS_fnc_getSafePos;
vehicle player setVehiclePosition [_pos, [], 0, "NONE"];
cutText [format["Trees found: %1", count nearestTerrainObjects [getPos vehicle player, ['TREE','SMALL TREE','FOREST','FOREST BORDER','FOREST TRIANGLE','FOREST SQUARE','BUILDING','HOUSE'], sizeOf typeOf vehicle player]], "PLAIN DOWN", 0.5];
uisleep 5;}};
*/

_position