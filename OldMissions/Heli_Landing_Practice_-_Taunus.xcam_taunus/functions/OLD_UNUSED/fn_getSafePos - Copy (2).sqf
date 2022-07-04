

if ( isNil "KS_Locations" ) then
{
	[true, "blockMarker", 300] call KS_fnc_getLocations;
};

private _loc = selectRandom KS_locations;
private _pos = position _loc;
private _rad = ( size _loc #0 max size _loc #1 );
private _pos = [_pos#0 + random(_rad*2)- _rad, _pos#1 + random(_rad*2)- _rad];

// "+trees +forest*10 -meadow"
private _position = selectBestPlaces [_pos, _rad, "(1 - forest) * (1 - sea) * (1 - trees)/2 * (1 - houses)", 100, 10];
//_position = selectRandom _position #0;
//_position = (_position select ( _position findIf {typeName(_x #0) isEqualTo "ARRAY"} ) ) #0;
_position = _position#0 #0;

if ( !isNil {_position} ) then
{
	private _vehicleSize = sizeOf typeOf vehicle player;
	private _nearObjects = nearestTerrainObjects [_position, ["TREE","SMALL TREE","FOREST","FOREST BORDER","FOREST TRIANGLE","FOREST SQUARE","BUILDING","HOUSE","HIDE"], _vehicleSize/2];
	
	if ( count _nearObjects > 3 ) then
	{
		systemChat format["%1 : nearestTerrainObjects: %2 - Search Radius: %3", time, count _nearObjects, _vehicleSize/2];
		_position = [];
	}
	else
	{	
		_position = _position isFlatEmpty
		[
			_vehicleSize/10,			// Min Distance for surrounding objects
			-1,					// Mode (ALWAYS SET TO -1)
			0.5,					// maxGradient 0.1 (10%) ~6°, 0.5 (50%) ~27°, 1.0 (100%) ~45°
			1,				// maxGradientRadius
			0,					// overLandOrWater 0=Land 2=Water
			true,					// shoreLine
			nearestObject [_position, "Land_HighVoltageColumnWire_F"]	// ignoreObject
		];
		
		systemChat format["%1 : Check isFlatEmpty: %2", time, !(_position isEqualTo [])];
		
		//if !( lineIntersects [AGLToASL _position, (AGLToASL _position) vectorAdd [0, 0, 10]] ) then
		
	};
};


if ( isNil {_position} || { _position isEqualTo [] } ) then
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