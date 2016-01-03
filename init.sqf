	call compilefinal preprocessFileLineNumbers "oo_config.sqf";

	sleep 2;

	_config = ["new", []] call OO_CONFIG;

	_array = [["CfgWorlds", "Altis", "Names", "position"], true];
	_result = ["parseConfig", _array] call _config;

	
	hint format ["result : %1", _result];

	//hint format ["version %1", "getVersion" call _config];
	//sleep 2;