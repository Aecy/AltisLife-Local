# Altis Life Local Framework
Une mission Altis Life RPG pour faciliter la vie des développeurs.

## Foires Aux Questions!

**Comment m'ajouter de l'argent en espèce ?**
```sqf
// -- Temporairement (debugConsole)
life_cash = 5000000;                        // -- Permet de définir notre argent à 5,000,000 €.
life_cash = life_cash + 5000000;            // -- Permet d'ajouter 5.000.000 à notre compte actuel.

// -- Définitivement (core\session\fn_requestReceived)
private _cash = 0;                          // -- Remplacer 0 par la valeur souhaitée.
```
**Comment m'ajouter de l'argent en banque ?**
```sqf
// -- Temporairement (debugConsole)
life_atmbank = 5000000;                     // -- Permet de définir notre argent à 5,000,000 €.
life_atmbank = life_atmbank + 5000000;      // -- Permet d'ajouter 5.000.000 à notre compte actuel.

// -- Définitivement (core\session\fn_requestReceived)
private _bank = 0;                          // -- Remplacer 0 par la valeur souhaitée.
```
**Comment changer mes niveaux de permissions ?**
```sqf
// -- Définitivement (core\session\fn_requestReceived)
private _adminlevel = 5;
private _coplevel = 5;
private _mediclevel = 5;
private _donorlevel = 0;
```
**Comment changer mon stuff de manière permanente ?**
```sqf
/*
    Information additionel:
        Respecter bien cette structure d'array.
*/
// -- Définitivement (core\session\fn_requestReceived)
private _gear = switch playerSide do {
    case west: { [] };
    case independent: { [] };
    default { ['U_C_Poloshirt_stripped','','','G_Bandanna_aviator','',['ItemMap','ItemCompass','ItemWatch'],[],[],[],[],[],[],[],[],['','','',''],['','','',''],[]] };
};
```
**Comment m'ajouter ou me retirer une licence ?**
```sqf
/*
    Information additionel:
        Il suffit de passer le boolean en false ou true.
*/
// -- Définitivement (core\session\fn_requestReceived)
private _license = [['license_civ_driver',false],['license_civ_boat',false],['license_civ_pilot',false],['license_civ_trucking',false],['license_civ_gun',false],['license_civ_dive',false],['license_civ_home',false],['license_civ_oil',false],['license_civ_diamond',false],['license_civ_salt',false],['license_civ_sand',false],['license_civ_iron',false],['license_civ_copper',false],['license_civ_cement',false],['license_civ_medmarijuana',false],['license_civ_cocaine',false],['license_civ_heroin',false],['license_civ_marijuana',false],['license_civ_rebel',false]];
```
**Comment modifier mes stats ?**
```sqf
/*
    Information additionel:
        Il suffit de passer le boolean en false ou true.
*/
// -- Temporairement (debugConsole)
life_hunger = 100;                          // -- Permet de modifier la valeur de la faim.
life_thirst = 100;                          // -- Permet de modifier la valeur de la soif.

// -- Définitivement (core\session\fn_requestReceived)
private _stats = [100,100,0];
```
