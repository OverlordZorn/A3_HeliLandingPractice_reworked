/*	KiloSwiss	*/
params [ ["_veh", objNull, [objNull] ] ];

if ( _veh isKindOf "Air" ) then
{
	_veh setVehiclePosition [_veh, [], 0, "FLY"];
	
	if ( _veh isKindOf "Plane" ) then
	{
		_veh setVelocityModelSpace [0, getNumber (configFile >> "cfgVehicles" >> typeOf _veh >> "maxSpeed") / 4, 0];
	}
	else
	{
		private _currentSimpleTask = simpleTasks player findIf { taskState _x isEqualTo "Assigned" };
		if ( _currentSimpleTask >= 0 ) then
		{
			_veh setDir ( _veh getDir ( taskDestination ( simpleTasks player select _currentSimpleTask ) ) );
			_veh setVelocityModelSpace [0, getNumber (configFile >> "cfgVehicles" >> typeOf _veh >> "maxSpeed") / 6, 0];
		};
	};
};