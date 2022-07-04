params [ ["_object", objNull, [objNull] ] ];

if ( !isNull _object ) then
{
	_object setPosASL [getPos _object select 0, getPos _object select 1, 10000];
	_object setPosASL [getPos _object select 0, getPos _object select 1, (getPosASL _object select 2)-(getPos _object select 2)];
	
	// Workaround for some CUP vehicles.
	if
	(
		_object isKindOf "Air" &&
		{
			//( typeOf _object ) find "CUP_C_SA330" == 0 ||
			( typeOf _object ) find "CUP_B_MH47" == 0 ||
			( typeOf _object ) find "CUP_B_CH" == 0
		}
	)
	then
	{
		_object setPosASL [getPos _object select 0, getPos _object select 1, (getPosASL _object select 2)+1];
	};
};