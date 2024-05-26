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
void() LightStyles_setup;

void() main = 
{
	
	
	
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

string(string s) precache_model         = #20;
void() precaches =
{
	precache_model ("models/player.mdl");

	//
	// Models
	//

	// sprites
	precache_model ("models/sprites/sprkle.spr");
	precache_model ("models/sprites/explosion.spr");
	precache_model ("models/sprites/null.spr");
	precache_model ("models/sprites/lightning.spr");
/*
	if (cvar("waypoint_mode")) {
		precache_model ("models/way/current_way.spr");
		precache_model ("models/way/current_way_door.spr");
		precache_model ("models/way/last_way.spr");
		precache_model ("models/way/last_way_door.spr");
		precache_model ("models/way/normal_way.spr");
		precache_model ("models/way/normal_way_door.spr");
		precache_model ("models/way/way_jump.spr");
		precache_model ("models/way/way_land.spr");
	}
*/
/*
	// zombie
	precache_model ("models/ai/zfull.mdl");
	precache_model ("models/ai/zal(.mdl");
	precache_model ("models/ai/zar(.mdl");
	precache_model ("models/ai/zb%.mdl");
	precache_model ("models/ai/zh^.mdl");
*/
/*
	// For debugging zombie AI
	if (cvar("developer")) {
		precache_model ("models/way/normal_way.spr");
	}

	// zombie crawler
	precache_model ("models/ai/zcfull.mdl");
	precache_model ("models/ai/zbc%.mdl");
	precache_model ("models/ai/zalc(.mdl");
	precache_model ("models/ai/zarc(.mdl");
	precache_model ("models/ai/zhc^.mdl");
*/
	// start weapons
	precache_model ("models/weapons/m1911/v_colt.mdl");
	precache_model ("models/weapons/m1911/g_colt.mdl");
	precache_model ("models/weapons/knife/v_knife.mdl");
	precache_model ("models/weapons/grenade/v_grenade.mdl");
	precache_model ("models/weapons/grenade/g_grenade.mdl");
	precache_extra (W_BIATCH);

	// perk machine defaults
	//precache_model (PERK_QUICKREVIVE_DEFAULT_MODEL);
	//precache_model (PERK_JUGGERNOG_DEFAULT_MODEL);
	//precache_model (PERK_SPEEDCOLA_DEFAULT_MODEL);
	//precache_model (PERK_)

#ifdef FTE

	// FTE only has co-op, so don't precache morphine elsewhere.
	precache_model ("models/weapons/morphine/v_morphine.mdl");

#endif // FTE

	//
	// Sounds
	//

	// player-made

#ifdef FTE

	precache_sound("sounds/player/footstep1.wav");
	precache_sound("sounds/player/footstep2.wav");
	precache_sound("sounds/player/footstep3.wav");
	precache_sound("sounds/player/footstep4.wav");
	precache_sound("sounds/player/footstep5.wav");

#endif // FTE

	precache_sound("sounds/player/jump.wav");
	precache_sound("sounds/player/land.wav");
	precache_sound("sounds/player/pain4.wav");

	// weapons
	precache_sound("sounds/weapons/colt/magin.wav");
	precache_sound("sounds/weapons/colt/magout.wav");
	precache_sound("sounds/weapons/colt/shoot.wav");
	precache_sound("sounds/weapons/colt/slide.wav");
	precache_sound("sounds/weapons/papfire.wav");

	// grenade
	precache_sound("sounds/weapons/grenade/prime.wav");
	precache_sound("sounds/weapons/grenade/throw.wav");
	precache_sound("sounds/weapons/grenade/explode.wav");

	// melee
	precache_sound("sounds/weapons/knife/knife_hitbod.wav");
	precache_sound("sounds/weapons/knife/knife.wav");
	precache_sound("sounds/weapons/knife/knife_hit.wav");

	// tunes
	precache_sound("sounds/rounds/eround.wav");
	precache_sound("sounds/rounds/nround.wav");
	precache_sound("sounds/rounds/splash.wav");
	precache_sound("sounds/music/end.wav");

	// purchasing
	precache_sound("sounds/misc/ching.wav");
	precache_sound("sounds/misc/buy.wav");
	precache_sound("sounds/misc/denybuy.wav");

	// power-ups
	precache_sound ("sounds/pu/pickup.wav");
	precache_sound ("sounds/pu/powerup.wav");
	precache_sound ("sounds/pu/drop.wav");
	precache_sound ("sounds/pu/byebye.wav");

	// zombie walk
	precache_sound ("sounds/zombie/w0.wav");
	precache_sound ("sounds/zombie/w1.wav");
	precache_sound ("sounds/zombie/w2.wav");
	precache_sound ("sounds/zombie/w3.wav");
	precache_sound ("sounds/zombie/w4.wav");
	precache_sound ("sounds/zombie/w5.wav");
	precache_sound ("sounds/zombie/w6.wav");
	precache_sound ("sounds/zombie/w7.wav");
	precache_sound ("sounds/zombie/w8.wav");
	precache_sound ("sounds/zombie/w9.wav");

	// zombie run
	precache_sound ("sounds/zombie/r0.wav");
	precache_sound ("sounds/zombie/r1.wav");
	precache_sound ("sounds/zombie/r2.wav");
	precache_sound ("sounds/zombie/r3.wav");
	precache_sound ("sounds/zombie/r4.wav");
	precache_sound ("sounds/zombie/r5.wav");
	precache_sound ("sounds/zombie/r6.wav");
	precache_sound ("sounds/zombie/r7.wav");
	precache_sound ("sounds/zombie/r8.wav");
	precache_sound ("sounds/zombie/r9.wav");

	// zombie swipe
	precache_sound ("sounds/zombie/a0.wav");
	precache_sound ("sounds/zombie/a1.wav");
	precache_sound ("sounds/zombie/a2.wav");
	precache_sound ("sounds/zombie/a3.wav");
	precache_sound ("sounds/zombie/a4.wav");
	precache_sound ("sounds/zombie/a5.wav");
	precache_sound ("sounds/zombie/a6.wav");
	precache_sound ("sounds/zombie/a7.wav");

	// zombie death
	precache_sound ("sounds/zombie/d0.wav");
	precache_sound ("sounds/zombie/d1.wav");
	precache_sound ("sounds/zombie/d2.wav");
	precache_sound ("sounds/zombie/d3.wav");
	precache_sound ("sounds/zombie/d4.wav");
	precache_sound ("sounds/zombie/d5.wav");
	precache_sound ("sounds/zombie/d6.wav");
	precache_sound ("sounds/zombie/d7.wav");

	// zombie taunt
	precache_sound ("sounds/zombie/t0.wav");
	precache_sound ("sounds/zombie/t1.wav");
	precache_sound ("sounds/zombie/t2.wav");
	precache_sound ("sounds/zombie/t3.wav");
	precache_sound ("sounds/zombie/t4.wav");

	// zombie footsteps
	precache_sound ("sounds/zombie/s0.wav");
	precache_sound ("sounds/zombie/s1.wav");
	precache_sound ("sounds/zombie/sc0.wav");
	precache_sound ("sounds/zombie/sc1.wav");

	// null
	precache_sound("sounds/null.wav");
}

void() worldspawn = 
{
	
	precaches();
	LightStyles_setup();
	
	//set game elements
	//G_STARTPOINTS = 500;
	//G_STARTROUND = 1;
	//G_PRONEPOINTS = 0;
	G_STARTWEAPON[0] = W_COLT;
	G_STARTWEAPON[1] = 8;
	G_STARTWEAPON[2] = 32;
	//G_WORLDTEXT = 1;
	//G_PERKS = 0;
	//G_PERKPOWER = 0;
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

