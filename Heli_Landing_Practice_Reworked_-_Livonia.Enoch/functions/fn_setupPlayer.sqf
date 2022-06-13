/*	KiloSwiss	*/
params ["_unit"];

_unit disableAI "ALL";
_unit allowDamage false;
_unit enableFatigue false;
_unit setAnimSpeedCoef 1.2;
removeAllWeapons _unit;

for "_i" from 1 to 5 do
{
	if ( _unit canAdd "FirstAidKit" ) then
	{
		_unit addItem "FirstAidKit";
	};
};

// - - -

if ( hasInterface ) then
{
	KS_HLP_dynamicBlockMarkers = []; // DO NOT EDIT THIS LINE!
	//--------------------------------------------------------
	
	if ( !isNil "KS_EHID_GetInMan" ) then
	{
		_unit removeEventHandler ["GetInMan", KS_EHID_GetInMan];
	};
	
	KS_EHID_GetInMan = _unit addEventHandler ["GetInMan",
	{
		params ["_unit", "", "_vehicle"];
		
		_unit allowDamage true;
		
		if ( local _vehicle ) then
		{
			_vehicle allowDamage true;
		}
		else
		{
			[_vehicle, true] remoteExec ["allowDamage", _vehicle];
		};
	}];
	
	if ( !isNil "KS_EHID_GetOutMan" ) then
	{
		_unit removeEventHandler ["GetInMan", KS_EHID_GetOutMan];
	};
	
	KS_EHID_GetOutMan = _unit addEventHandler ["GetOutMan",
	{
		params ["_unit", "", "_vehicle"];
		
		_unit allowDamage false;
		
		if ( crew _vehicle findIf {alive _x} isEqualTo -1 ) then
		{
			[_vehicle, false] remoteExec ["allowDamage", _vehicle];
		};
	}];
	
	//systemchat format["isDamageAllowed for [ player: %1 | Vehicle: %2 | cursorTarget: %3 ]", isDamageAllowed player, isDamageAllowed vehicle player, isDamageAllowed cursortarget];
	
	// - - -
	
	if ( !isNil "KS_holdActionID_teleport" ) then
	{
		[_unit, KS_holdActionID_teleport ] call BIS_fnc_holdActionRemove;
	};
	
	KS_holdActionID_teleport = [
		_unit,									// Object the action is attached to
		"<t color='#FFAA00'>TELEPORT BACK</t>",					// Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",	// Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",	// Progress icon shown on screen
		"isNull objectParent player &&
		{ player distance playerTeleport > 500 }",				// Condition for the action to be shown
		"isNull objectParent player &&
		{ player distance playerTeleport > 500 }",				// Condition for the action to progress
		{},									// Code executed when action starts
		{},									// Code executed on every progress tick
		{ call KS_fnc_teleportBack; },						// Code executed on completion
		{},									// Code executed on interrupted
		[],									// Arguments passed to the scripts as _this select 3
		2,									// Action duration [s]
		0,									// Priority
		false,									// Remove on completion
		false									// Show in unconscious state 
	] call BIS_fnc_holdActionAdd;
	
	
	if ( !isNil "KS_holdActionID_createTask" ) then
	{
		[_unit, KS_holdActionID_createTask ] call BIS_fnc_holdActionRemove;
	};
	
	KS_holdActionID_createTask = [
		_unit,									// Object the action is attached to
		"<t color='#FFAA00'>GET NEW LZ</t>",					// Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",	// Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloadDevice_ca.paa",	// Progress icon shown on screen
		"vehicle player isKindOf 'Helicopter' &&
		{ player isEqualTo driver vehicle player } &&
		{ count simpleTasks player == 0 } &&
		{ canMove vehicle player }",						// Condition for the action to be shown
		"vehicle player isKindOf 'Helicopter' &&
		{ player isEqualTo driver vehicle player } &&
		{ count simpleTasks player == 0 } &&
		{ canMove vehicle player }",						// Condition for the action to progress
		{},									// Code executed when action starts
		{},									// Code executed on every progress tick
		{ call KS_fnc_createTask; },						// Code executed on completion
		{},									// Code executed on interrupted
		[],									// Arguments passed to the scripts as _this select 3
		1,									// Action duration [s]
		0,									// Priority
		false,									// Remove on completion
		false									// Show in unconscious state 
	] call BIS_fnc_holdActionAdd;
	
	if ( isNil "KS_HLP_welcomeHintShown" ) then
	{
		KS_HLP_welcomeHintShown = true;
		_unit spawn
		{
			waituntil { !( IsNull ( findDisplay 46 ) ) };
			["blackandwhite", 0.0] call BIS_fnc_setPPeffectTemplate;
			UIsleep 0.01;
			
			private _worldName = [worldName, "Livonia"] select (worldName == "Enoch");
			private _hintCTitle = [ format ["HELI LANDING PRACTICE %1", toUpper _worldName],"PRACTICE MAKES PERFECT"] select ( random 1 < 0.025 );
			
			_hintCTitle hintC
			[
				parseText format ["Welcome %1<br/>The mission is easy: Spawn a helicopter, fly and have fun.", name player],
				parseText format
				[
					"Try to remember these handy key combinations:<br/><br/>
					<t align='left'><img size='2' image='%1'/></t>
					<t align='left' size='2.0'> Game Volume</t><br/>
					<t align='left' size='1.5'>SHIFT + F1 = Decrease</t><br/>
					<t align='left' size='1.5'>SHIFT + F2 = Increase</t><br/>
					<br/>
					<t align='left'><img size='2' image='%2'/></t>
					<t align='left' size='2.0'> View Distance</t><br/>
					<t align='left' size='1.5'>SHIFT + F3 = Decrease</t><br/>
					<t align='left' size='1.5'>SHIFT + F4 = Increase</t><br/>",
					"a3\ui_f\data\gui\cfg\hints\Voice_ca.paa",
					"a3\ui_f\data\gui\cfg\hints\Zooming_ca.paa"
				],
				parseText format
				[
					"Recommendation:<br/>Listen to your favourite music, podcast or audio book in the background, while you practice heli flying and hone your landing skills here on %1.
					<br/><br/><t align='left'>KiloSwiss</t>",
					_worldName
				]
			];
			hintC_arr_EH = findDisplay 72 displayAddEventHandler ["unload", {
				["default", 1.8] call BIS_fnc_setPPeffectTemplate;
				0 = _this spawn {
					_this select 0 displayRemoveEventHandler ["unload", hintC_arr_EH];
					hintSilent "";
				};
			}];
			/*
			//OLD HINT:
			//private _icon3 = "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\heli_ca.paa";
			hint parseText format
			[
				"<t align='center'><img size='5' image='%1'/></t><br/>
				<t align='Left' size='1.2'>SHIFT + F4 = Increase ViewDistance</t><br/>
				<t align='Left' size='1.2'>SHIFT + F3 = Decrease ViewDistance</t><br/>
				<br/><br/>
				<t align='center'><img size='5' image='%2'/></t><br/>
				<t align='Left' size='1.2'>SHIFT + F2 = Increase Game Volume</t><br/>
				<t align='Left' size='1.2'>SHIFT + F1 = Decrease Game Volume</t><br/>",
				_icon1,
				_icon2
			];
			*/
		};
	};
};