

if ( isNil "KS_Locations" ) then
{
	[true, "blockMarker", 300] call KS_fnc_getLocations;
};

private _vehType = typeOf vehicle player;
private _loc = selectRandom KS_locations;
private _pos = position _loc;
private _rad = ( size _loc #0 max size _loc #1 );
private _posRandom = [_pos#0 + random(_rad*2)- _rad, _pos#1 + random(_rad*2)- _rad];

private _position = _posRandom findEmptyPosition [0, 50 max _rad/2 min 150, _vehType];

if ( !isNil {_position} && { !( _position isEqualTo [] ) } ) then
{
	private _vehSize = sizeOf _vehType;
	_position = _position isFlatEmpty
	[
		_vehSize/3,		// Min Distance for surrounding objects
		-1,			// Mode (ALWAYS SET TO -1)
		0.3,			// maxGradient 0.1 (10%) ~6°, 0.5 (50%) ~27°, 1.0 (100%) ~45°
		_vehSize/10,		// maxGradientRadius
		0,			// overLandOrWater 0=Land 2=Water
		false,			// shoreLine
		nearestObject [_position, "Land_HighVoltageColumnWire_F"]	// ignoreObject
	];
	
	systemChat format["%1 : Check isFlatEmpty: %2", time, !(_position isEqualTo [])];
		
	//if !( lineIntersects [AGLToASL _position, (AGLToASL _position) vectorAdd [0, 0, 10]] ) then
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