/*	KiloSwiss	*/
//https://community.bistudio.com/wiki/DIK_KeyCodes

params [ ["_display", displayNull, [displayNull]], ["_DIKCode", 0, [0]], ["_shift", false, [false]], ["_ctrl", false, [false]], ["_alt", false, [false]] ];

if ( isNull _display ) exitWith { hint "Something is wrong here"; false };

private _handled = false;

// 41 = ~
// 59 = F1
// 60 = F2
// 61 = F3

if ( _shift ) then
{
	switch _DIKcode do
	{
		case 59 : // F1
		{
			false call KS_fnc_volumeControl;
			_handled = true;
		};
		case 60 : // F2
		{
			true call KS_fnc_volumeControl;
			_handled = true;
		};
		case 61 : // F3
		{
			false call KS_fnc_viewDistanceControl;
			_handled = true;
		};
		case 62 : // F4
		{
			true call KS_fnc_viewDistanceControl;
			_handled = true;
		};
	};
};

_handled

/*
switch _DIKcode do
{

	case 41 : // ~
	{
		player groupChat format ["%1 = ~", _DIKcode];
	};
	
	case 59 : // F1
	{
		player groupChat format ["%1 = F1", _DIKcode];
	};
	
	case 219 : // Windows L
	{
		player setVariable ["ShowNameAllies", [true, false] select ( player getVariable ["ShowNameAllies", false] )];
		hintSilent format ["%1 = Windows L\n\nShowNameAllies: %2", _DIKcode, player getVariable ["ShowNameAllies", false]];
		_handled = true;
	};
	
	case 220 : // Windows R
	{
		player groupChat format ["%1 = Windows R", _DIKcode];
	};
	
	//default {hintSilent format ["KeyDown: %1\nShift: %2\nCtrl: %3\nAlt: %4", _DIKcode, _shift, _ctrl, _alt];};
	default { _handled = true; };
};
*/
/*
if (_dikCode in (actionKeys "TacticalPing")) then { //T == 20
            
            _handled = true;
*/

