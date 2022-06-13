/*
	Author:	KiloSwiss
	
	Description:
		Increases or decreases view distance.
		Shows new view distance in a hint.
	
	Execution:
		Client
	
	Compatible:
		Singleplayer
		Multiplayer
	
	Parameter(s):
		0: BOOL - Increase or decrease.
		1: ARRAY (optionsl) - Array of possible values for view distance  [200-40000]
	
	Returns:
		-nothing-
*/
params [ ["_increaseOrDecrease", true, [true] ], ["_valuesUnsorted", [400, 800, 1200, 1600, 2400, 3200, 4000, 6000, 8000, 10000, 12000, 16000], [] ] ];

// Get rid of double entries and sort values by smalles to largest.
private _values = [];
{ private _val = 200 max _x min 40000; _values pushBackUnique _val } forEach _valuesUnsorted;
_values sort true;

// Retrieve current value to work with.
private _currentValue = viewDistance;

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
setViewDistance _newValue;

// Give the player a visual feedback of the change in form of a silent hint.
private _icon = "a3\ui_f\data\gui\cfg\hints\Zooming_ca.paa";
hintSilent parseText format
[
	"<t align='center'><img size='5' image='%1'/></t><br/>
	<t align='center' size='1.5'>View Distance: %2%3</t>",
	_icon,
	[_newValue / 1000, _newValue] select ( _newValue < 1000 ),
	["km", "m"] select ( _newValue < 1000 )
];

/*
"a3\ui_f\data\gui\cfg\hints\Zooming_ca.paa"		// Binoculars
"a3\ui_f\data\gui\cfg\hints\Thirdperson_ca.paa"		// Camera
"a3\ui_f\data\gui\cfg\hints\Pheripheal_vision_ca.paa"	// Eye
"a3\ui_f\data\gui\cfg\hints\Head_ca.paa"		// Same as Zooming_ca
"a3\ui_f\data\gui\cfg\hints\Camera_ca.paa"		// Heli with Eye underneath
"a3\ui_f\data\gui\cfg\hints\BasicLook_ca.paa"		// Eye with Arrow circle underneath
*/