	/*
	Author: code34 nicolas_boiteux@yahoo.fr
	Copyright (C) 2016-2018 Nicolas BOITEUX

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
			DEBUG(#, "OO_CONFIG::constructor")
			MEMBER("version", 0.1);
		};

		PUBLIC FUNCTION("","getVersion") FUNC_GETVAR("version");

		PUBLIC FUNCTION("array", "makeCondition") {
			DEBUG(#, "OO_CONFIG::makeCondition")
			private _temp = configName _x;
		};

		PUBLIC FUNCTION("array", "parseConfig") {
			DEBUG(#, "OO_CONFIG::parseConfig")
			private _array = [];
			private _path = _this select 0;
			private _condition = _this select 1;
			
			_path = call compile (MEMBER("buildPath", _path));	
			private _type = MEMBER("checkType", _path);
			private _count = count (_path);		
			for "_i" from 0 to (_count-1) do {
				if(_type isEqualTo "text") then {
					_array pushBack getText (_path select _i);
				};
				if(_type isEqualTo "class") then {
					_array pushBack configName (_path select _i);
				};
				if(_type isEqualTo "number") then {
					_array pushBack getNumber (_path select _i);
				};
				if(_type isEqualTo "array") then {
					_array pushBack getArray (_path select _i);
				};
				sleep 0.001;
			};
			_path;
		};

		PUBLIC FUNCTION("config", "checkType") {
			DEBUG(#, "OO_CONFIG::checkType")	
			private _type = "";
			if(isText _this) then { _type = "text"; };
			if(isClass _this) then { _type = "class"; };
			if(isNumber _this) then { _type = "number"; };
			if(isArray _this) then { _type = "array"; };
			_type;
		};

		PUBLIC FUNCTION("array", "buildPath") {
			DEBUG(#, "OO_CONFIG::buildPath")	
			private _string = "configFile";
			{ _string = _string +' >> "'+ _x + '" '; } foreach _this;
			_string;
		};

		PUBLIC FUNCTION("","deconstructor") { 
			DEBUG(#, "OO_CONFIG::deconstructor")	
			DELETE_VARIABLE("version");
		};
	ENDCLASS;