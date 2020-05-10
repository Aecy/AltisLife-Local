#include "..\..\script_macros.hpp"

if (life_session_completed) exitWith {};

cutText[format [localize "STR_Session_Query", getPlayerUID player],"BLACK FADED"];
0 cutFadeOut 999999999;

[] call SOCK_fnc_requestReceived;
