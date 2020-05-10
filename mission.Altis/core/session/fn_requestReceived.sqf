#include "..\..\script_macros.hpp"
/*
    File: fn_requestReceived.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Called by the server saying that we have a response so let's
    sort through the information, validate it and if all valid
    set the client up.
*/
0 cutText [localize "STR_Session_Received","BLACK FADED"];
0 cutFadeOut 9999999;

private _cash = 0;
private _bank = 0;
private _adminlevel = 5;
private _coplevel = 5;
private _mediclevel = 5;
private _donorlevel = 0;
private _positions = [3685.63, 13016.3, 0.00119972];
private _gear = switch playerSide do {
    case west: { [] };
    case independent: { [] };
    default { ['U_C_Poloshirt_stripped','','','G_Bandanna_aviator','',['ItemMap','ItemCompass','ItemWatch'],[],[],[],[],[],[],[],[],['','','',''],['','','',''],[]] };
};
private _license = [['license_civ_driver',false],['license_civ_boat',false],['license_civ_pilot',false],['license_civ_trucking',false],['license_civ_gun',false],['license_civ_dive',false],['license_civ_home',false],['license_civ_oil',false],['license_civ_diamond',false],['license_civ_salt',false],['license_civ_sand',false],['license_civ_iron',false],['license_civ_copper',false],['license_civ_cement',false],['license_civ_medmarijuana',false],['license_civ_cocaine',false],['license_civ_heroin',false],['license_civ_marijuana',false],['license_civ_rebel',false]];
private _stats = [100,100,0];

/*
    DONT EDIT BELOW
*/
CASH = _cash;
BANK = _bank;
CONST(life_adminlevel, _adminlevel);
CONST(life_donorlevel, _donorlevel);

if (count (_license) > 0) then {
    {
        missionNamespace setVariable [(_x select 0),(_x select 1)];
    } forEach _license;
};

switch (playerSide) do {
    case west: {
        CONST(life_coplevel, _coplevel);
        CONST(life_medicLevel, 0);
        life_blacklisted = false;
        if (LIFE_SETTINGS(getNumber,"save_playerStats") isEqualTo 1) then {
            life_hunger = _stats select 0;
            life_thirst = _stats select 1;
            player setDamage (_stats select 2);
        };
    };

    case civilian: {
        life_is_arrested = false;
        CONST(life_coplevel, 0);
        CONST(life_medicLevel, 0);
        life_houses = [];
        if (LIFE_SETTINGS(getNumber,"save_playerStats") isEqualTo 1) then {
            life_hunger = _stats select 0;
            life_thirst = _stats select 1;
            player setDamage (_stats select 2);
        };

        if (LIFE_SETTINGS(getNumber,"save_civilian_position") isEqualTo 1) then {
            life_is_alive = true;
            life_civ_position = _positions;
            if (life_is_alive) then {
                if !(count life_civ_position isEqualTo 3) then {
                    diag_log format ["[requestReceived] Bad position received. Data: %1",life_civ_position];
                    life_is_alive = false;
                };
                if (life_civ_position distance (getMarkerPos "respawn_civilian") < 300) then {
                    life_is_alive = false;
                };
            };
        };

        {
            _house = nearestObject [(call compile format ["%1",(_x select 0)]), "House"];
            life_vehicles pushBack _house;
        } forEach life_houses;

        /*
        life_gangData = _this select (_count - 2);
        if !(count life_gangData isEqualTo 0) then {
            [] spawn life_fnc_initGang;
        };
        */
        [] spawn life_fnc_initHouses;
    };

    case independent: {
        CONST(life_medicLevel, _mediclevel);
        CONST(life_coplevel, 0);
        if (LIFE_SETTINGS(getNumber,"save_playerStats") isEqualTo 1) then {
            life_hunger = _stats select 0;
            life_thirst = _stats select 1;
            player setDamage (_stats select 2);
        };
    };
};

life_gear = _gear;
call life_fnc_loadGear;

/*
if (count (_this select (_count - 1)) > 0) then {
    {
        life_vehicles pushBack _x;
    } forEach (_this select (_count - 1));
};
*/

life_session_completed = true;
