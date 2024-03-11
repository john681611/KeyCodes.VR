#include "\a3\ui_f\hpp\definedikcodes.inc"

/*
	USAGE: [<unit>, <command>, <command_params>, <command_remote_exec_code>, keyCode] call keyCode_RequireCode;
	GEN CODE: [<length>] call keyCode_GenCode;

*/

 
keyCode_GenCode = {
	private ["_len"];
	_len = _this;
	_code = [];
	for "_i" from 0 to _len do {
		_code pushBack (selectRandom ["↑", "↓", "→", "←"]);
	};
	_code;
};

keyCode_FormatCode = {
	private ["_code"];
	_code = _this;
	_val = _code joinString "     ";
	_val;
};

keyCode_RequireCode = {
	private ["_veh", "_command", "_command_params", "_command_exec_code"];
	_veh = _this select 0;
	_command = _this select 1;
	_command_params = _this select 2;
	_command_exec_code = _this select 3;
	keyCode_keyCode = _this select 4;
	keyCode_done = false;
	keyCode_keyHistory = [];
	hint format ["Command (Hold CTRL down): \n %1", keyCode_keyCode call keyCode_FormatCode];

	keyCode_eventHandler = findDisplay 46 displayAddEventHandler ["KeyUp", {
		params ["_displayOrControl", "_key", "_shift", "_ctrl", "_alt"];
		private _override = false;
		if (!(_key in [DIK_UP, DIK_DOWN, DIK_LEFT, DIK_RIGHT])) exitWith {
			_override;
		};

		if (keyCode_done) exitWith {
			_override;
		};

		if (!_ctrl) exitWith {
			keyCode_keyHistory = [];
			hintSilent format ["Command (Hold CTRL down): \n %1 \n %2", keyCode_keyCode call keyCode_FormatCode, keyCode_keyHistory call keyCode_FormatCode];
			_override;
		};
		_override = true;

		if (_key isEqualTo DIK_UP) then {
			keyCode_keyHistory pushBack "↑";
		};

		if (_key isEqualTo DIK_DOWN) then {
			keyCode_keyHistory pushBack "↓";
		};

		if (_key isEqualTo DIK_LEFT) then {
			keyCode_keyHistory pushBack "←";
		};

		if (_key isEqualTo DIK_RIGHT) then {
			keyCode_keyHistory pushBack "→";
		};
		if (keyCode_keyHistory isEqualTo keyCode_keyCode) exitWith {
			hint "Accepted!";
			keyCode_done = true;
			keyCode_keyHistory = [];
			_override;
		};

		if (!(keyCode_keyHistory isEqualTo (keyCode_keyCode select [0, count keyCode_keyHistory]))) then {
			keyCode_keyHistory = [];
		};

		hintSilent format ["Command (Hold CTRL down): \n %1 \n %2", keyCode_keyCode call keyCode_FormatCode, keyCode_keyHistory call keyCode_FormatCode];
		_override;
	}];

	waitUntil {
		keyCode_done || player distance _veh > 10
	};
	if (!keyCode_done) then {
		hint "Command Cancelled";
	} else {
		_command_params remoteExec [_command, _command_exec_code];
	};
	findDisplay 46 displayRemoveEventHandler ["KeyUp", keyCode_eventHandler];
	eventHandler = nil;
};