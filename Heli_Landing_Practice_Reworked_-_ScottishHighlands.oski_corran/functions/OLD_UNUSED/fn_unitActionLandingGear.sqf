/*
	KiloSwiss
	
	Returns bool
*/

params [ ["_vehicle", objNull, [objNull] ], ["_gearDown", true, [true] ] ];
private _return = false;

if ( _vehicle isKindOf "Air" ) then
{
	if ( hasInterface ) then // Client or localhost
	{
		_gearDown = ["LandGearUp","LandGear"] select _gearDown;
		player action [_gearDown, _vehicle];
	}
	else // Dedicated server or headless client
	{
		private _remoteExecTarget = [_vehicle, -2] select ( local _vehicle );
		[_vehicle, _gearDown] remoteExec [KS_fnc_unitActionLandingGear, _remoteExecTarget];
		// Remote executing this on all clients (-2) if vehicle is local to the server seems a bit overkill, I'll have to find a better way to do it!
	};
	
	_return = true;
};

_return