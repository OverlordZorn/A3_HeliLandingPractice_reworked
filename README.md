# A3_HeliLandingPractice
Arma 3 - Helicopter Landing Practice Mission, original by KiloSwiss - Ports to more Maps + minor Adaptations


I thorougly enjoy to just fly around places, explore the Areas, maybe listening to a podcast or sth in the background and have a good time.

This is an effort to take KiloSwiss' `HeliLandingPractice` Mission and bring it to more Maps + do minor creature comfort adaptions. 


Original Mission: https://steamcommunity.com/sharedfiles/filedetails/?id=1962268953

KiloSwiss: https://steamcommunity.com/id/kiloswiss

## Future Plans and Ideas

- Add a way to control the max distance from player for new Landing Zones - Flying from one corner of the map to the opposite one can get tiring after a while.

## Known Issues

- After extended playtime, the helicopter gets immune to damage.

## Feel Free to help!

Since Im a novice with SQF and coding in general, im happy for everyone who wants to contribute.

## Found a Problem with the Mission?

Create a new issue, explain the problem - Ideally with locations or RPT's attached.

## Want to suggest a map to be ported?

Create a Issue and call it map request. Add the link to the steam workshop page. I'll take a look at it.

Alternatively you can port it yourself, its fairly easy. I'll add a guide if there is enough interest.

## You have a modded helicopter that isnt automatically detected by the `Virtual Vehicle Spawner`?
`VVS/functions/fn_buildCfg.sqf` at line 63 and 86 needs the `vehicleClass` added into the array
