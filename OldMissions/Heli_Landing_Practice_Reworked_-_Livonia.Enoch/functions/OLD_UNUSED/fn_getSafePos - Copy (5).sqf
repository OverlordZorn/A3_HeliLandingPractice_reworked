
params [ ["_minDistance", 600, [123] ], ["_maxDistance", 3000, [123] ] ];

if ( isNil "KS_Locations" ) then
{
	[true, "blockMarker", 300] call KS_fnc_getLocations;
};

private _loc = selectRandom KS_locations;
private _pos = position _loc;
private _rad = ( size _loc #0 max size _loc #1 );
//private _posRandom = [_pos#0 + random(_rad*2)- _rad, _pos#1 + random(_rad*2)- _rad];

private _position = selectBestPlaces [_pos, _rad, "(1 - forest)/2 * (1 - trees)/2 * (1 - houses) * (1 - sea) * (1 - meadow)", 100, 50];
_position = _position#0 #0;

if ( !isNil {_position} ) then
{
	private _distance = _position distance player;
	if ( _distance < _minDistance || _distance > _maxDistance ) then
	{
		_position = nil;
	}
	else
	{
		private _vehType = typeOf vehicle player;
		_position = _position findEmptyPosition [0, 30 max _rad/2 min 100, _vehType];
		
		if ( !( _position isEqualTo [] ) && ( _position inArea [[worldSize/2 ,worldSize/2], worldSize/2.1, worldSize/2.1, 0, true] ) ) then
		{
			private _vehSize = sizeOf _vehType;
			_position = _position isFlatEmpty
			[
				_vehSize/5,		// Min Distance for surrounding objects
				-1,			// Mode (ALWAYS SET TO -1)
				0.37,			// maxGradient 0.1 (10%) ~6°, 0.5 (50%) ~27°, 1.0 (100%) ~45°
				_vehSize/10,		// maxGradientRadius
				0,			// overLandOrWater 0=Land 2=Water
				false,			// shoreLine
				nearestObject [_position, "Land_HighVoltageColumnWire_F"]	// ignoreObject
			];
			
			//systemChat format["%1 : Check isFlatEmpty: %2", time, !(_position isEqualTo [])];
		};
		//if !( lineIntersects [AGLToASL _position, (AGLToASL _position) vectorAdd [0, 0, 10]] ) then
	};
};

if ( isNil {_position} || { _position isEqualTo [] } ) then
{
	//systemChat format ["%1 : Search new Position", time];
	_position = call KS_fnc_getSafePos;
};

/* Testing in the editor:
vehicle player allowDamage false;
player allowDamage false;

0 = true spawn{ while{true}do{
_pos = [] call KS_fnc_getSafePos;
vehicle player setVehiclePosition [_pos, [], 0, "NONE"];
uisleep 5;}};
*/
_position set [2, 0];

_position