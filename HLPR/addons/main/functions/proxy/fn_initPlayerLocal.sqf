/*	KiloSwiss	*/
enableSaving [false, false];

// - - -

// Enter your safe zone marker names here. No LZ will ever be within those markers.
KS_HLP_staticBlockMarkers = ["KS_HLP_safeZone_0","KS_HLP_safeZone_1","KS_HLP_safeZone_2","KS_HLP_safeZone_3","KS_HLP_safeZone_4","KS_HLP_safeZone_5","KS_HLP_safeZone_6"];

// Maximum number of old LZ positions to block when searching for a new LZ. Min: 0 / Max: 10 / Auto: -1
KS_HLP_maxBlockMarkers = 10;

// - - -

if ( !isMultiplayer ) then
{
	false call KS_fnc_getLocations;
	player setVariable ["spawnPos", position player];
	{ deleteVehicle _x } forEach allUnits - [player];
}
else
{
	if ( isNil "KS_locations" ) then
	{
		false call KS_fnc_getLocations;
		publicVariable "KS_locations";
	};
};

//Setup Key Handler
waituntil { !( IsNull ( findDisplay 46 ) ) };
(findDisplay 46) displayAddEventHandler ["KeyDown",
{
	private _handled = _this call KS_fnc_onKeyDown;
	_handled
}];

player call KS_fnc_setupPlayer;

addMissionEventHandler ["Draw3D",
{
	if ( isNull objectParent player ) then
	{
		private _distance = positionCameraToWorld [0,0,0] distance heliSpawnBase_0;
		
		if ( _distance < 100 ) then
		{
			private _iconSize = 1 max ( 10 / ( _distance / 10 ) ) min 5;
			private _iconPos = getPos heliSpawnBase_0;
			_iconPos set [2, _iconPos#2 + 7];
			
			drawIcon3D
			[
				"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\heli_ca.paa",
				[1,1,1,1],
				_iconPos,
				_iconSize/5,
				_iconSize/5,
				0,
				"Heli Spawn",
				true,
				_iconSize / 80,
				"RobotoCondensed",
				"center",
				true
			];
		};
	};
}];

addMissionEventHandler ["Draw3D",
{
	if ( damage player > 0.05 ) then
	{
		private _distance = positionCameraToWorld [0,0,0] distance medicalContainer;
		
		if ( _distance < 100 ) then
		{
			private _iconSize = 1 max ( 10 / ( _distance / 10 ) ) min 5;
			private _iconPos = getPos medicalContainer;
			_iconPos set [2, _iconPos#2 + 5];
			
			drawIcon3D
			[
				"a3\ui_f\data\igui\cfg\actions\bandage_ca.paa",
				[1,1,1,1],
				_iconPos,
				_iconSize/2,
				_iconSize/2,
				0,
				"Heal",
				true,
				_iconSize / 40,
				"RobotoCondensed",
				"center",
				true
			];
		};
	};
}];

addMissionEventHandler ["Draw3D",
{
	if ( !isNull objectParent player ) then
	{
		private _distance = positionCameraToWorld [0,0,0] distance refuel_station;
		
		if ( _distance < 300 ) then
		{
			private _iconSize = 1 max ( 10 / ( _distance / 10 ) ) min 5;
			private _iconPos = getPos refuel_station;
			_iconPos set [2, _iconPos#2 + 5];
			
			drawIcon3D
			[
				"a3\ui_f\data\igui\cfg\cursors\iconRefuelAt_ca.paa",
				[1,1,1,1],
				_iconPos,
				_iconSize,
				_iconSize,
				0,
				["Refuel","LAND HERE"] select ( _distance < 30 && { objectParent player isKindOf "Air" } ),
				true,
				_iconSize / 40,
				"RobotoCondensed",
				"center",
				true
			];
		};
	};
}];

addMissionEventHandler ["Draw3D",
{
	if ( !isNull objectParent player ) then
	{
		private _distance = positionCameraToWorld [0,0,0] distance repair_station;
		
		if ( _distance < 300 ) then
		{
			private _iconSize = 1 max ( 10 / ( _distance / 10 ) ) min 5;
			private _iconPos = getPos repair_station;
			_iconPos set [2, _iconPos#2 + 5];
			
			drawIcon3D
			[
				"a3\ui_f\data\igui\cfg\cursors\iconRepairAt_ca.paa",
				[1,1,1,1],
				_iconPos,
				_iconSize,
				_iconSize,
				0,
				["Repair","LAND HERE"] select ( _distance < 30 && { objectParent player isKindOf "Air" } ),
				true,
				_iconSize / 40,
				"RobotoCondensed",
				"center",
				true
			];
		};
	};
}];

/*
"a3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa"
"a3\ui_f\data\igui\cfg\simpleTasks\types\refuel_ca.paa"
"a3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa"

//---

"a3\ui_f\data\igui\cfg\cursors\iconRefuelAt_ca.paa"
"a3\ui_f\data\igui\cfg\cursors\iconRepairAt_ca.paa"

"a3\ui_f\data\gui\cfg\hints\TakeOff_ca.paa"

"a3\ui_f\data\igui\cfg\actions\repair_ca.paa"
"a3\ui_f\data\igui\cfg\actions\refuel_ca.paa"

"a3\ui_f\data\igui\cfg\actions\heal_ca.paa"
"a3\ui_f\data\igui\cfg\actions\bandage_ca.paa"
"a3\ui_f\data\igui\cfg\actions\reload_ca.paa"
"a3\ui_f\data\igui\cfg\actions\reammo_ca.paa"
*/