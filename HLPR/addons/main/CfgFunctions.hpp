class CfgFunctions
{
	#include "VVS\Functions.h"
	class KS
	{
		class randomFunctions {
			file = QPATHTOFOLDER(legacyFunctions);
			class skipBriefing {preInit = 1};
			class onKeyDown {};
			class createTask {};
			class setupPlayer {};
			class setupVehicle {};
			class teleportBack {};
			class volumeControl {};
			class getSafePos {};
			class getLocations {};
			class setupRespawnLogic {};
			class respawnVehicle {};
			class instantTakeOff {};
			class addActionTakeOff {};
			class viewDistanceControl {};
			class updateBlockMarkers {};
		};
	};
	class ADDON {
		class proxy {
			file = QPATHTOFOLDER(functions\proxy);
			class initPlayerLocal {};
			class onPlayerKilled {};
			class onPlayerRespawn {}
		};
	};
};
