/*	KiloSwiss	*/
{ player removeSimpleTask _x } forEach simpleTasks player;

private _taskLoc = [position player, nil, nil, player, KS_HLP_staticBlockMarkers + KS_HLP_dynamicBlockMarkers] call KS_fnc_getSafePos;

[_taskLoc, KS_HLP_maxBlockMarkers] call KS_fnc_updateBlockMarkers;

private _newTask = player createSimpleTask ["Land at LZ"];

_newTask setSimpleTaskDestination _taskLoc;
_newTask setSimpleTaskDescription
[
	format["Make your way to the LZ and land safely.<br/><br/>Hint:<br/>Unassign this Task to remove it."],	//description
	"Land at LZ",			//descriptionShort
	"LZ"				//descriptionHUD
];
_newTask setTaskState "Assigned";
_newTask setSimpleTaskType "Land";
_newTask setSimpleTaskAlwaysVisible true;

[_newTask] spawn
{
	params ["_task"];
	
	while { !isNull _task } do
	{
		
		if ( taskState _task isEqualTo "Assigned" ) then
		{
			private _veh = objectParent player;
			if
			(
				!isNull _veh &&
				{ isTouchingGround _veh } &&
				{ abs speed _veh < 0.05 } &&
				{ _veh distance taskDestination _task < 30 }
			)
			then
			{
				_task setTaskState "Succeeded";
				if ( canMove _veh ) then
				{
					private _distance = _veh distance taskDestination _task;
					private _text = switch true do
					{
						case ( _distance < 5 ) : { "BULLSEYE!" };
						case ( _distance < 10 ) : { "SPOT ON!" };
						default { "GOOD LANDING!" };
					};
					titleText [ format["<t shadow='2' color='#CCCC00' size='3'>%1</t><br/>Move to the next Waypoint.", _text], "PLAIN DOWN", -1, true, true];
					UIsleep 1;
					call KS_fnc_createTask;
				}
				else
				{
					if ( alive player ) then
					{
						titleText ["<t shadow='2' color='#D20000' size='3'>ROUGH LANDING PILOT!</t><br/>Abandon your vehicle and teleport back to base!", "PLAIN", -1, true, true];
					};
				};
			};
		}
		else
		{
			player removeSimpleTask _task;
		};
	};
};


/*
private _title = 	"Land at LZ";
private _description = 	"Make your way to the LZ and land there safely.";
private _waypoint = 	"LZ"

private _newTask = [player, "taskID", [_description, _title, _waypoint], objDocuments, true] call BIS_fnc_taskCreate;
_newTask setTaskState "Assigned";
*/