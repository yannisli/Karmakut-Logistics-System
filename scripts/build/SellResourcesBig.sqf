params ["_caller", "_target"];

if ("ACE_Fortify" in ((vestItems player) + (uniformItems player) + (backpackItems player))) then {
DeleteVehicle _caller;
[west, 500, false] call acex_fortify_fnc_updateBudget;
} else {hint "NO Build Active"} ;
