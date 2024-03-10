#include "\a3\ui_f\hpp\definedikcodes.inc"

keyHistory = [];
publicVariable "keyHistory";

findDisplay 46 displayAddEventHandler ["KeyUp", {
	params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
	private _override = false;
	if(!_ctrl) exitWith {
		keyHistory = [];
		_override;
	};
	_override = true;

	if (_key isEqualTo DIK_UP) then 
	{
		systemChat "You pressed (UP).";
		keyHistory pushBack "UP";
	};

	if (_key isEqualTo DIK_DOWN) then 
	{
		systemChat "You pressed (DOWN).";
		keyHistory pushBack "DOWN";
	};

	if (_key isEqualTo DIK_LEFT) then 
	{
		systemChat "You pressed (LEFT).";
		keyHistory pushBack "LEFT";
	};

	if (_key isEqualTo DIK_RIGHT) then 
	{
		systemChat "You pressed (RIGHT).";
		keyHistory pushBack "RIGHT";
	};
	hint format ["Key history: %1", keyHistory];

	if(keyHistory isEqualTo ["UP", "UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT"]) then
	{
		hint "You pressed the Konami Code!";
		[] spawn {sleep 5; ("DemoCharge_Remote_Ammo" createVehicle (getPosATL player)) setDamage 1;};
		keyHistory = [];
	};
	_override;
}];