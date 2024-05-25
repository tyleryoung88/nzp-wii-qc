/*
+----+
|Main|
+----+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Scratch                                      Http://www.admdev.com/scratch |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Contains some 'base' subroutines. As a general rule nothing in this file   |
| does much, except to setup basic variables and entities.                   |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
*/

void() precaches;
void() LightStyles_setup; // Entities/Lights.QC

void() main = 
{
	
	
	
};


void() worldspawn = 
{
	
	precaches();
	LightStyles_setup();
	
};


void() SetNewParms = 
{
	
	
	
};


void() SetChangeParms = 
{
	
	
	
};


void() StartFrame = 
{
	
	
	
};

void() precaches =
{
	
	precache_model ("progs/player.mdl");
	
};

void() EndFrame =
{
	//RelinkZombies();
/*
	if (cheats_have_been_activated == false && cvar("sv_cheats") == 1) {
		cheats_have_been_activated = true;
	}
*/
};

