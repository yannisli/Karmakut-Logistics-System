
_content = preprocessFile "BuildTrigger.sqf"; // File path for Start build system
_activated = profileNamespace getVariable "Activated"; // Calls for number of activated build stations (Max 1)
params [_obj];

while {true} do {
      if (_activated == 0) then {
          _obj addAction ["<t color='#FF0000'>Activate Building</t>", { // Add activate building option
              if ((_this select 1) in BUILD_PERMS) then {
                  if ( _activated == 0 ) then {  // If less than 1 active, Run script, add one to profile name space
                      execVM _content; // Starts build trigger
                      _activated = _activated + 1; // adds one to activated
                      profileNamespace setVariable ["Activated", _activated]; // Sets new Variable
                      saveProfileNamespace; // saves profile
                  } else {
                  hint "build is already active elsewhere";
                  };
              };
          }];
      } else {
          _obj addAction [ "<t color='#FF0000'>Stop Building</t>" , {
              if ((_this select 1) in BUILD_PERMS) then {
                  deleteVehicle _FortifyAllowed;
                  _activated = 0; // removes one from activated
                  if (isPlayer (_this select 1)) then {[removeItem "ACE_Fortify"];};
                  profileNamespace setVariable ["Activated", _activated]; // Sets new Variable
                  saveProfileNamespace; // saves profile
              } else {
                  hint "build is already active elsewhere";
              };
          }
          ];
      };
};
