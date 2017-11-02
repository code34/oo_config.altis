	call compile preprocessFileLineNumbers "oo_config.sqf";

	sleep 2;

	private _config = ["new", []] call OO_CONFIG;
	private _array = [["CfgWorlds", "Altis", "Names", "position"], true];
	private _result = ["parseConfig", _array] call _config;
	hint format ["result : %1", _result];