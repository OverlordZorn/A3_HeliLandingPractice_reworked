/*	KiloSwiss	*/
params [ ["_searchCenter", [0,0,0], [[]], [2,3] ], ["_minDistance", ( worldSize / 20 ) min 600, [123] ], ["_maxDistance", ( worldSize / 5 ) min 3600, [123] ], ["_vehicle", objNull, [objNull] ], ["_blockMarkers", [], [[]] ] ];

if ( isNull _vehicle ) exitWith { [worldSize / 2, worldSize / 2, 0] };

_vehicle = [vehicle _vehicle, _vehicle] select (isNull objectParent _vehicle);

if ( _searchCenter isEqualTo [0,0,0] ) then
{
	_searchCenter = getPos _vehicle;
};

if ( _minDistance >= _maxDistance / 1.5 ) then
{
	_minDistance = ( worldSize / 20 ) min 600;
	_maxDistance = ( worldSize / 5 ) min 3600;
};

if ( count _blockMarkers > 0 ) then
{
	_blockMarkers = _blockMarkers select { markerColor _x != "" };
};

if ( isNil "KS_HLP_Locations" ) then
{
	false call KS_fnc_getLocations;
};

// - - -

private _position = [];	//private "_position" for later use.
private _locations = KS_HLP_Locations select
{
	private _distance = position _x distance _searchCenter;
	( _minDistance max _distance min _maxDistance ) == _distance
};
private _location = selectRandom _locations;
private _locationRad = ( ( size _location #0 ) + ( size _location #1 ) ) / 2;
//private _posRandom = [_locationPos#0 + random(_locationRad*2)- _locationRad, _locationPos#1 + random(_locationRad*2)- _locationRad];

//private _bestPlaces = selectBestPlaces [position _location, _locationRad, "(1 - trees) * (1 - forest) * (1 - meadow)/5 * (1 - sea) * (houses * 10)", 100, 10];
private _bestPlaces = selectBestPlaces [position _location, ( _locationRad * 2.5 ) min 450, "(1 - forest) * (1 - meadow) * (1 - sea) * (trees / 2) * (houses * 10)", 100, 10];

_bestPlaces = _bestPlaces select
{
	private _placeToCheck = _x #0;
	( ( _blockMarkers findIf { _placeToCheck inArea _x } ) == -1 ) &&
	{ _placeToCheck inArea [[worldSize/2 ,worldSize/2], worldSize/2.2, worldSize/2.2, 0, true] }
};

if ( count _bestPlaces > 0 ) then
{
	private _vehicleSize = sizeOf typeOf _vehicle;
	private _bestPlaceFound = _bestPlaces findIf { count ( _x #0 nearObjects ["HouseBase", _vehicleSize * 1.5] ) > 3 };
	//private _bestPlaceFound = _bestPlaces findIf { count( _x #0 nearRoads 50 ) > 0 && { count( _x #0 nearObjects ["HouseBase", 30] ) > 2 } };
	
	if ( _bestPlaceFound >= 0 ) then
	{
		_bestPlaceFound = ( _bestPlaces select _bestPlaceFound ) #0;
		_position = _bestPlaceFound isFlatEmpty
		[
			_vehicleSize/4,		// Min Distance for surrounding objects
			-1,			// Mode (ALWAYS SET TO -1)
			0.6,			// maxGradient 0.1 (10%) ~6°, 0.5 (50%) ~27°, 1.0 (100%) ~45°
			_vehicleSize/10,	// maxGradientRadius
			0,			// overLandOrWater 0=Land 2=Water
			false,			// shoreLine
			objNull		//nearestObject [_bestPlaceFound, "Land_HighVoltageColumnWire_F"]	// ignoreObject
		];
		//systemChat format["%1 : Check isFlatEmpty: %2", time, !(_position isEqualTo [])];
	};
};
//if !( lineIntersects [AGLToASL _position, (AGLToASL _position) vectorAdd [0, 0, 10]] ) then

if ( _position isEqualTo [] ) then
{
	//systemChat format ["%1 : Search new Position", time];
	_position = [_searchCenter, ( _minDistance - 10 ) max ( worldSize / 25 ), ( _maxDistance + 300 ) min worldSize, _vehicle, _blockMarkers] call KS_fnc_getSafePos;
};

_position set [2, 0];

_position

/* Testing in the editor:
vehicle player allowDamage false;
player allowDamage false;
0 = true spawn{ while{!isNull objectParent player}do{ 
_pos = [position player, nil, nil, player, KS_HLP_staticBlockMarkers + KS_HLP_dynamicBlockMarkers] call KS_fnc_getSafePos;
[_pos, -1, true] call KS_fnc_updateBlockMarkers;
vehicle player setPos _pos;
uisleep 2}};

vehicle player allowDamage false;
player allowDamage false;
0 = true spawn{ for "_i" from 0 to 300 do{
_pos = [position player, nil, nil, player, KS_HLP_staticBlockMarkers + KS_HLP_dynamicBlockMarkers] call KS_fnc_getSafePos;
[_pos, -1, true] call KS_fnc_updateBlockMarkers;
vehicle player setPos _pos;
_m = createMarkerLocal[format["safePosMarker%1", _i], _pos];
_m setMarkerTypeLocal "mil_dot";
_m setMarkerColorLocal "ColorOrange";
_m setMarkerSizeLocal [0.3,0.3];
uisleep 0.5}; vehicle player setPos [0,0,0];};
*/
