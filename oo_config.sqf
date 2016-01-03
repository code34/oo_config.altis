	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2016 Nicolas BOITEUX

	CLASS OO_CONFIG - A3 config manager
	
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>. 
	*/

	#include "oop.h"

	CLASS("OO_CONFIG")
		PRIVATE VARIABLE("scalar","version");

		PUBLIC FUNCTION("array","constructor") {
			MEMBER("version", 0.1);
		};

		PUBLIC FUNCTION("","getVersion") FUNC_GETVAR("version");

		PUBLIC FUNCTION("array", "makeCondition") {
			_temp = configName _x;
		};

		PUBLIC FUNCTION("array", "parseConfig") {
			private ["_array", "_condition", "_path", "_count", "_type"];
			_array = [];

			_path = _this select 0;
			_condition = _this select 1;

			_path = call compile (MEMBER("buildPath", _path));
			_type = MEMBER("checkType", _path);
			_count = count (_path);
			
			for "_i" from 0 to (_count-1) do {
				if(_type == "text") then {
					_array = _array + [getText (_path select _i)];
				};
				if(_type == "class") then {
					_array = _array + [configName (_path select _i)];
				};
				if(_type == "number") then {
					_array = _array + [getNumber (_path select _i)];
				};
				if(_type == "array") then {
					_array = _array + [getArray (_path select _i)];
				};
				sleep 0.001;
			};
			_path;
		};

		PUBLIC FUNCTION("config", "checkType") {
			private ["_type"];
			
			_type = "";
			if(isText _this) then {
				_type = "text";
			};
			if(isClass _this) then {
				_type = "class";
			};
			if(isNumber _this) then {
				_type = "number";
			};
			if(isArray _this) then {
				_type = "array";
			};
			_type;
		};

		PUBLIC FUNCTION("array", "buildPath") {
			private ["_string"];
			_string = "configFile";
			{
				_string = _string +' >> "'+ _x + '" ';
			} foreach _this;
			_string;
		};

		PUBLIC FUNCTION("","deconstructor") { 
			DELETE_VARIABLE("version");
		};
	ENDCLASS;