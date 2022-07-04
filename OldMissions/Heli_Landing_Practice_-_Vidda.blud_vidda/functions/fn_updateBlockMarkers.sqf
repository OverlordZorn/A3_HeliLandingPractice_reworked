
params [ ["_position", [0,0,0], [[]], [2,3] ], ["_maxMarkers", -1, [0123] ], ["_showMarker", false, [true] ] ];

if ( count _position < 3 ) then { _position set [2, 0] };

if ( _maxMarkers == -1 ) then
{
	if ( isNil "KS_HLP_Locations" ) then { false call KS_fnc_getLocations };
	_maxMarkers = floor ( count KS_HLP_Locations / 5 );
};

_maxMarkers = 0 max _maxMarkers min 10;

if ( isNil "KS_HLP_dynamicBlockMarkers" ) then { KS_HLP_dynamicBlockMarkers = [] };

private _blockMarkerCount = count KS_HLP_dynamicBlockMarkers;

if ( _maxMarkers > 0 ) then
{
	if ( _blockMarkerCount >= _maxMarkers ) then
	{
		for "_i" from 0 to ( _blockMarkerCount - _maxMarkers ) do
		{
			deleteMarkerLocal ( KS_HLP_dynamicBlockMarkers # _i );
		};
		KS_HLP_dynamicBlockMarkers deleteRange [0, _blockMarkerCount - _maxMarkers];
		_blockMarkerCount = count KS_HLP_dynamicBlockMarkers;
	};
	
	private _markerName = "KS_HLP_blockMarker_0";
	
	if ( _blockMarkerCount > 0 ) then
	{
		_markerName = KS_HLP_dynamicBlockMarkers # ( _blockMarkerCount - 1 );
		_markerNameSplit = _markerName splitString "_";
		private _lastElement = count _markerNameSplit -1;
		
		_markerNameSplit set[_lastElement, str( parseNumber (_markerNameSplit #_lastElement) +1)];
		_markerName = _markerNameSplit joinString "_";
		
		/* What an unnecessary mess.
		private _num = toArray _markerName;
		_num deleteRange [0,19];
		_num = parseNumber toString _num;
		_num = _num + 1;
		_markerName = format ["KS_HLP_blockMarker_%1", _num];
		*/
	};
	
	private _newMarker = createMarkerLocal [_markerName, _position];
	_newMarker setMarkerSizeLocal [250, 250];
	_newMarker setMarkerShapeLocal "ELLIPSE";
	_newMarker setMarkerColorLocal "ColorYellow";
	_newMarker setMarkerAlphaLocal ( [0, 1] select _showMarker );
	
	KS_HLP_dynamicBlockMarkers = KS_HLP_dynamicBlockMarkers + [_markerName];
};