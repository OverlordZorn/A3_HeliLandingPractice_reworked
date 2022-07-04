/*	KiloSwiss	*/
params [ ["_oldUnit", objNull, [objNull] ] ];

_oldUnit spawn
{
	[_this] joinSilent grpNull;
	UIsleep 5;
	hideBody _this;
};

if ( !isMultiplayer ) then
{
	private _class = typeOf _oldUnit;
	private _spawnPos = _oldUnit getVariable "spawnPos";
	private _newUnit = ( group player ) createUnit [_class, _spawnPos, [], 15, "NONE"];
	_newUnit setVariable ["spawnPos", _spawnPos];
	_newUnit disableAI "ALL";
	_newUnit call KS_fnc_setupPlayer;
	addSwitchableUnit _newUnit;
	
	_newUnit spawn
	{
		UIsleep 3;
		if ( _this in switchableUnits ) then
		{
			selectPlayer _this;
			BIS_DeathBlur ppEffectAdjust [0.0];
			BIS_DeathBlur ppEffectCommit 0.0;
		}
		else
		{
			teamSwitch;
		};
	};
};