waitUntil { time > 0 }; // Wait until mission fully started
private _factories = [0,0,0] nearObjects [Factory_Building, 50000]; //get all factories
private _resourcesPerFactory = createHashMap;

{
 private _count = count (getPos _x nearObjects [Small_Barrel, 200]);
 _count = _count + count (getPos _x nearObjects [Bigger_Barrel, 200]);
 if (_count == 0) then {
    _resourcesPerFactory set [getPos _x, 0];
 } else {
    _resourcesPerFactory set [getPos _x, _count];
 };

} forEach _factories;


// TODO: Nweed to attach a map marker to each factory!

while {true} do {
  {
      if ((_resourcesPerFactory get getPos _x) < Resource_Cap_Factory) then {   // if factory has less than 5 barrels
          private _barrel = nil;
          if (random [1,50,100] <= Small_Barrel_Chance) then { // chance of spawn of type of supplies. big or small
            _barrel = createVehicle [Small_Barrel, getpos _x, [], 0, "NONE"];
            _barrel setMass 125;
            sleep 5;
            _barrel addAction ["Deposit Supplies","scripts\build\SellResourcesSmall.sqf"];
            [_barrel, 2] call ace_cargo_fnc_setSize;
          } else {
            _barrel = createVehicle [Bigger_Barrel, getpos _x, [], 0, "NONE"];
            _barrel setMass 500;
            sleep 5;
            _barrel addAction ["Deposit Supplies","scripts\build\SellResourcesBig.sqf"];
            [_barrel, 4] call ace_cargo_fnc_setSize;
          };
          _resourcesPerFactory set [getPos _x, (_resourcesPerFactory get (getPos _x)) + 1]; // update the number of resources in the factory
      };
  } forEach _factories;
  sleep RESOURCETIMER; // wait 15 minutes until next spawn of supplies
};