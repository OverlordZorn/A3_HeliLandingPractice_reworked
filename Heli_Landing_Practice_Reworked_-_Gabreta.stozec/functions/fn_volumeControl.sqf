/*
	Author:	KiloSwiss
	
	Description:
		Increases or decreases in game volume.
		Shows new volume in a hint.
	
	Execution:
		Client
	
	Compatible:
		Singleplayer
		Multiplayer
	
	Parameter(s):
		0: BOOL - Increase or decrease.
		1: ARRAY (optional) - Array of possible values for volume [0-1]
	
	Returns:
		-nothing-
*/
params [ ["_increaseOrDecrease", true, [true] ], ["_valuesUnsorted", [0.0, 0.2, 0.5, 1], [] ] ];

// Get rid of double entries and sort values by smalles to largest.
private _values = [];
{ private _val = 0 max _x min 1; _values pushBackUnique _val } forEach _valuesUnsorted;
_values sort true;

// Retrieve current value to work with.
private _currentValue = soundVolume;

// If current value is not in the array of values passed to the function then...
if ( _values find _currentValue < 0 ) then
{
	// ...find the element within the array that is closest to the retrieved value.
	// This makes sure we only work with the values passed to the function.
	// As a fallback there is an array of default values defined in params.
	private _tempArray = _values apply { [abs ( _x - _currentValue ), _x] }; 
	_temparray sort true;
	_currentValue = _tempArray #0 #1;
};

// Select the next higher or lower element from the array.
private _newValue = ( _values find _currentValue ) + ( [-1, 1] select _increaseOrDecrease );
// Select at least the first element and at max the last element in the array.
_newValue = _values select ( 0 max _newValue min ( count _values -1 ) );

// Apply new value.
0.3 fadeSound _newValue;

// Give the player a visual feedback of the change in form of a silent hint.
//private _icon = "a3\ui_f\data\gui\cfg\hints\Voice_ca.paa";

private _icon = switch true do
{
	case ( _newValue <= 0 ) :
	{
		"icons\speaker_off.paa";
	};
	case ( _newValue < 0.40 ) :
	{
		"icons\speaker_low.paa";
	};
	case ( _newValue < 0.80 ) :
	{
		"icons\speaker_high.paa";
	};
	default { "icons\speaker_full.paa" };
};

hintSilent parseText format
[
	"<t align='center'><img size='5' image='%1'/></t><br/>
	<t align='center' size='1.5'>Volume: %2%3</t>",
	_icon,
	_newValue * 100,
	"%"
];

//hint composeText [image "a3\ui_f\data\gui\cfg\hints\Voice_ca.paa", format[" Volume: %1%2", _newValue * 100, "%"] ];