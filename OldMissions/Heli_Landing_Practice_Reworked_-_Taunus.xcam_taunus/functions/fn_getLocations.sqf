/*	KiloSwiss	*/
params [ ["_drawMarkers", false, [true] ] ];

KS_worldCenter = [worldSize / 2, worldSize / 2];
KS_innerWorldRadius = worldSize / 2;
KS_outerWorldRadius = sqrt(KS_innerWorldRadius^2 + KS_innerWorldRadius^2);

//_locations = (configfile >> "CfgWorlds" >> worldName >> "Names") call BIS_fnc_returnChildren;
private _locations = nearestLocations [KS_worldCenter, ["NameCityCapital","NameCity","NameVillage","NameLocal","CityCenter","Airport","Strategic"], KS_outerWorldRadius];
if ( count KS_HLP_staticBlockMarkers > 0 ) then
{
	_locations = _locations select
	{
		private _positionToCheck = position _x;
		( ( KS_HLP_staticBlockMarkers findIf { _positionToCheck inArea _x } ) == -1 )
	};
};
KS_HLP_Locations = _locations;

//To create coloured markers on all found locations use:
//private["_worldRadius","_worldCenterPos","_allLocations","_marker"];
//_worldRadius = (getNumber(configFile >> "CfgWorlds" >> worldName >> "MapSize")/2);
//_worldCenterPos = [ _worldRadius, _worldRadius, 0];
//
if ( _drawMarkers ) then
{
	//private _allLocations = nearestLocations [KS_worldCenter, ["NameCityCapital","NameCity","NameVillage","NameLocal","CityCenter","Airport","NameMarine","Strategic","ViewPoint","RockArea","StrongpointArea","FlatArea","FlatAreaCity","FlatAreaCitySmall"], KS_outerWorldRadius];
	{
		private ["_marker","_markerName","_marker2","_markerName2"];
		
		_markerName = format["locationMarker_%1", _forEachIndex];
		deleteMarkerLocal _markerName;
		_marker = createMarkerLocal [_markerName, position _x];
		_marker setMarkerShapeLocal "ELLIPSE";
		private _locationRad = ( ( size _x #0 ) + ( size _x #1 ) ) / 2;
		_locationRad = ( _locationRad * 2.5 ) min 450;
		_marker setMarkerSizeLocal [_locationRad, _locationRad];
		_marker setMarkerTextLocal format["%1 %2", _forEachIndex, type _x];
		
		_marker setMarkerColorLocal "ColorPink";
		if ((type _x) in ["NameCityCapital","NameCity","NameVillage","NameLocal","CityCenter","Airport"])then{ _marker setMarkerColorLocal "ColorWhite"; };
		if ((type _x) in ["NameMarine"])then{ _marker setMarkerColorLocal "ColorBlue"; };
		if ((type _x) in ["Strategic","StrongpointArea"])then{ _marker setMarkerColorLocal "ColorRed"; };
		if ((type _x) in ["ViewPoint","RockArea"])then{ _marker setMarkerColorLocal "ColorGreen"; };
		if ((type _x) in ["FlatArea"])then{ _marker setMarkerColorLocal "ColorOrange"; };
		if ((type _x) in ["FlatAreaCity","FlatAreaCitySmall"])then{ _marker setMarkerColorLocal "ColorYellow"; };
		
		_markerName2 = format["locationMarker2_%1", _forEachIndex];
		deleteMarkerLocal _markerName2;
		_marker2 = createMarkerLocal [_markerName2, position _x];
		_marker2 setMarkerTypeLocal "mil_dot";
		_marker2 setMarkerTextLocal format["%1 %2", _forEachIndex, type _x];
		_marker2 setMarkerColorLocal "ColorBlack";
	}forEach KS_HLP_Locations;
};