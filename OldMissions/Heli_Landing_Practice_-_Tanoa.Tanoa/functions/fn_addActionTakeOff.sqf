/*	KiloSwiss	*/
params [ ["_veh", objNull, [objNull] ] ];

if (_veh isKindOf "Air" ) then
{
	[
		_veh,									// Object the action is attached to
		"<t color='#FFAA00'>INSTANT TAKEOFF</t>",					// Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff1_ca.paa",	// Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_takeOff2_ca.paa",	// Progress icon shown on screen
		"player isEqualTo driver _target &&
		{ isTouchingGround _target } &&
		{ canMove _target }",							// Condition for the action to be shown
		"player isEqualTo driver _target &&
		{ isTouchingGround _target } &&
		{ canMove _target }",							// Condition for the action to progress
		{},									// Code executed when action starts
		{},									// Code executed on every progress tick
		{ [vehicle _target] call KS_fnc_instantTakeOff; },			// Code executed on completion
		{},									// Code executed on interrupted
		[],									// Arguments passed to the scripts as _this select 3
		1,									// Action duration [s]
		0,									// Priority
		false,									// Remove on completion
		false									// Show in unconscious state 
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _veh];
};