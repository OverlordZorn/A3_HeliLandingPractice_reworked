/*	KiloSwiss	*/
if ( isNull playerTeleport ) then
{
	player setVehiclePosition [( player getVariable "spawnPos" ), [], 10];
}
else
{
	player setVehiclePosition [getPos playerTeleport, [], 5];
	
	if ( !isNull MedicalContainer ) then
	{
		player setDir ( player getDir ( getPos MedicalContainer ) );
	}
	else
	{
		player setDir ( getDir playerTeleport );
	};
};