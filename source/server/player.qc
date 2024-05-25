/*
+------+
|Client|
+------+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Scratch                                      Http://www.admdev.com/scratch |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Handle's "clients" (eg, Players) connecting, disconnecting, etc.           |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
*/

void(entity e) Light_None;
void() Spawns_Init;
void() SUB_UseTargets;
void() rec_downed;

#define PLAYER_START_HEALTH				100

#define PLAYER_CROUCH_DIFFERENCE_HL 	25
#define PLAYER_PRONE_DIFFERENCE_HL 		23
#define PLAYER_CROUCH_DIFFERENCE_QK 	15
#define PLAYER_PRONE_DIFFERENCE_QK 		13

#define PLAYER_ANIM_WALK 				1
#define PLAYER_ANIM_SPRINT				2

//
// Player 3rd Person Animations
//

// Walking
void() PAnim_Walk		=[   1,     PAnim_Walk1			] {self.frame = 0; self.tp_anim_time = time + 0.5;}
void() PAnim_Walk1		=[   2,     PAnim_Walk2			] {self.frame = 1;}
void() PAnim_Walk2		=[   3,     PAnim_Walk3			] {self.frame = 2;}
void() PAnim_Walk3		=[   4,     PAnim_Walk4			] {self.frame = 3;}
void() PAnim_Walk4		=[   5,     PAnim_Walk5			] {self.frame = 4;}
void() PAnim_Walk5		=[   6,     PAnim_Walk6			] {self.frame = 5;}
void() PAnim_Walk6		=[   7,     PAnim_Walk7			] {self.frame = 6;}
void() PAnim_Walk7		=[   8,     PAnim_Walk8			] {self.frame = 7;}
void() PAnim_Walk8		=[   9,     SUB_Null			] {self.frame = 8;}

// Sprinting
void() PAnim_Sprint 	=[	1,		PAnim_Sprint1		] {self.frame = 25; self.tp_anim_time = time + 0.65;}
void() PAnim_Sprint1 	=[	2,		PAnim_Sprint2		] {self.frame = 26;}
void() PAnim_Sprint2	=[	3,		PAnim_Sprint3		] {self.frame = 27;}
void() PAnim_Sprint3 	=[	4,		PAnim_Sprint4		] {self.frame = 28;}
void() PAnim_Sprint4 	=[	5,		PAnim_Sprint5		] {self.frame = 29;}
void() PAnim_Sprint5 	=[	6,		PAnim_Sprint6		] {self.frame = 30;}
void() PAnim_Sprint6 	=[	7,		SUB_Null			] {self.frame = 31;}

// Reloading
void() PAnim_Reload   	=[	1,		PAnim_Reload1	  	] {self.frame = 11; self.tp_anim_time = time + 1;}
void() PAnim_Reload1  	=[	2,		PAnim_Reload2	  	] {self.frame = 12;}
void() PAnim_Reload2  	=[	3,		PAnim_Reload3	  	] {self.frame = 13;}
void() PAnim_Reload3  	=[	4,		PAnim_Reload4	  	] {self.frame = 14;}
void() PAnim_Reload4  	=[	5,		PAnim_Reload5	  	] {self.frame = 15;}
void() PAnim_Reload5  	=[	6,		PAnim_Reload6	  	] {self.frame = 16;}
void() PAnim_Reload6  	=[	7,		PAnim_Reload7	  	] {self.frame = 17;}
void() PAnim_Reload7  	=[	8,		PAnim_Reload8	 	] {self.frame = 18;}
void() PAnim_Reload8  	=[	9,		PAnim_Reload9 		] {self.frame = 19;}
void() PAnim_Reload9   	=[	10,		PAnim_Reload10		] {self.frame = 20;}
void() PAnim_Reload10 	=[	11,		PAnim_Reload11		] {self.frame = 21;}
void() PAnim_Reload11 	=[	12,		PAnim_Reload12		] {self.frame = 22;}
void() PAnim_Reload12 	=[	13,		PAnim_Reload13		] {self.frame = 23;}
void() PAnim_Reload13 	=[	14,		SUB_Null			] {self.frame = 24;}

// Firing
void() PAnim_Fire 		=[	1,		PAnim_Fire1	  		] {self.frame = 9; self.tp_anim_time = time + 0.25;}
void() PAnim_Fire1 		=[	2,		SUB_Null	  		] {self.frame = 10;}

// Melee
void() PAnim_Melee 		=[	1,		PAnim_Melee1	  	] {self.frame = 49; self.tp_anim_time = time + 0.65;}
void() PAnim_Melee1 	=[	2,		PAnim_Melee2	  	] {self.frame = 50;}
void() PAnim_Melee2 	=[	3,		PAnim_Melee3	  	] {self.frame = 51;}
void() PAnim_Melee3 	=[	4,		PAnim_Melee4	  	] {self.frame = 52;}
void() PAnim_Melee4 	=[	5,		PAnim_Melee5	  	] {self.frame = 53;}
void() PAnim_Melee5 	=[	6,		PAnim_Melee6	  	] {self.frame = 54;}
void() PAnim_Melee6 	=[	7,		SUB_Null	  		] {self.frame = 55;}

// Weapon Swap
void() PAnim_Swap 		=[	1,		PAnim_Swap1	  		] {self.frame = 56; self.tp_anim_time = time + 1;}
void() PAnim_Swap1 		=[	2,		PAnim_Swap2	  		] {self.frame = 57;}
void() PAnim_Swap2 		=[	3,		PAnim_Swap3	  		] {self.frame = 58;}
void() PAnim_Swap3 		=[	4,		PAnim_Swap4	  		] {self.frame = 59;}
void() PAnim_Swap4 		=[	5,		PAnim_Swap5	  		] {self.frame = 60;}
void() PAnim_Swap5 		=[	6,		PAnim_Swap6	  		] {self.frame = 61;}
void() PAnim_Swap6 		=[	7,		PAnim_Swap7	  		] {self.frame = 62;}
void() PAnim_Swap7 		=[	8,		PAnim_Swap8	  		] {self.frame = 63;}
void() PAnim_Swap8 		=[	9,		SUB_Null	  		] {self.frame = 64;}

// Enter Dolphin Dive 
void() PAnim_EnterDive 	=[	1,		PAnim_EnterDive1	] {self.frame = 203; self.tp_anim_time = time + 5;}
void() PAnim_EnterDive1 =[	2,		PAnim_EnterDive2	] {self.frame = 204;}
void() PAnim_EnterDive2 =[	3,		PAnim_EnterDive3	] {self.frame = 205;}
void() PAnim_EnterDive3 =[	4,		PAnim_EnterDive4	] {self.frame = 206;}
void() PAnim_EnterDive4 =[	5,		SUB_Null			] {self.frame = 207;}

// Flop from Dive
void() PAnim_Flop 		=[	1,		PAnim_Flop1			] {self.frame = 208; self.tp_anim_time = time + 1;}
void() PAnim_Flop1 		=[	2,		PAnim_Flop2			] {self.frame = 209;}
void() PAnim_Flop2 		=[	3,		PAnim_Flop3			] {self.frame = 210;}
void() PAnim_Flop3 		=[	4,		SUB_Null			] {self.frame = 211;}

// Enter Stand
void() PAnim_Stand 		=[  1, 		PAnim_Stand1		] {self.frame = 114; self.tp_anim_time = time + 1;}
void() PAnim_Stand1 	=[  2, 		PAnim_Stand2		] {self.frame = 113;}
void() PAnim_Stand2 	=[  3, 		SUB_Null			] {self.frame = 0;}

// Enter Crouch
void() PAnim_Crouch 	=[  1, 		PAnim_Crouch1		] {self.frame = 113; self.tp_anim_time = time + 0.5;}
void() PAnim_Crouch1 	=[  2, 		PAnim_Crouch2		] {self.frame = 114;}
void() PAnim_Crouch2 	=[  3, 		SUB_Null			] {self.frame = 115;}

// Walking, while Crouch
void() PAnim_CrouchWalk =[  1, 		PAnim_CrouchWalk1	] {self.frame = 116; self.tp_anim_time = time + 0.5;}
void() PAnim_CrouchWalk1=[  2, 		PAnim_CrouchWalk2	] {self.frame = 117;}
void() PAnim_CrouchWalk2=[  3, 		PAnim_CrouchWalk3	] {self.frame = 118;}
void() PAnim_CrouchWalk3=[  4, 		PAnim_CrouchWalk4	] {self.frame = 119;}
void() PAnim_CrouchWalk4=[  5, 		PAnim_CrouchWalk5	] {self.frame = 120;}
void() PAnim_CrouchWalk5=[  6, 		PAnim_CrouchWalk6	] {self.frame = 121;}
void() PAnim_CrouchWalk6=[  7, 		PAnim_CrouchWalk7	] {self.frame = 122;}
void() PAnim_CrouchWalk7=[  8, 		PAnim_CrouchWalk8	] {self.frame = 123;}
void() PAnim_CrouchWalk8=[  9, 		SUB_Null			] {self.frame = 124;}

// Reloading, while Crouch
void() PAnim_CrReload   =[	1,		PAnim_CrReload1	  	] {self.frame = 128; self.tp_anim_time = time + 1;}
void() PAnim_CrReload1  =[	2,		PAnim_CrReload2	  	] {self.frame = 129;}
void() PAnim_CrReload2  =[	3,		PAnim_CrReload3	  	] {self.frame = 130;}
void() PAnim_CrReload3  =[	4,		PAnim_CrReload4	  	] {self.frame = 131;}
void() PAnim_CrReload4  =[	5,		PAnim_CrReload5	  	] {self.frame = 132;}
void() PAnim_CrReload5  =[	6,		PAnim_CrReload6	  	] {self.frame = 133;}
void() PAnim_CrReload6  =[	7,		PAnim_CrReload7	  	] {self.frame = 134;}
void() PAnim_CrReload7  =[	8,		PAnim_CrReload8	 	] {self.frame = 135;}
void() PAnim_CrReload8  =[	9,		PAnim_CrReload9 	] {self.frame = 136;}
void() PAnim_CrReload9  =[	10,		SUB_Null			] {self.frame = 115;}

// Firing, while Crouch
void() PAnim_CrouchFire =[	1,		PAnim_CrouchFire1	] {self.frame = 126; self.tp_anim_time = time + 0.25;}
void() PAnim_CrouchFire1=[	2,		SUB_Null	  		] {self.frame = 127;}

// Enter Prone
void() PAnim_Prone 		=[  1, 		PAnim_Prone1		] {self.frame = 154; self.tp_anim_time = time + 1.5;}
void() PAnim_Prone1 	=[  2, 		PAnim_Prone2		] {self.frame = 155;}
void() PAnim_Prone2 	=[  3, 		PAnim_Prone3		] {self.frame = 156;}
void() PAnim_Prone3 	=[  4, 		PAnim_Prone4		] {self.frame = 157;}
void() PAnim_Prone4 	=[  5, 		PAnim_Prone5		] {self.frame = 158;}
void() PAnim_Prone5 	=[  6, 		PAnim_Prone6		] {self.frame = 159;}
void() PAnim_Prone6 	=[  7, 		PAnim_Prone7		] {self.frame = 160;}
void() PAnim_Prone7 	=[  8, 		PAnim_Prone8		] {self.frame = 161;}
void() PAnim_Prone8 	=[  9, 		SUB_Null			] {self.frame = 162;}

// Walking, while Prone
void() PAnim_ProneWalk	=[  1, 		PAnim_ProneWalk1	] {self.frame = 162; self.tp_anim_time = time + 1.5;}
void() PAnim_ProneWalk1	=[  2, 		PAnim_ProneWalk2	] {self.frame = 163;}
void() PAnim_ProneWalk2	=[  3, 		PAnim_ProneWalk3	] {self.frame = 164;}
void() PAnim_ProneWalk3	=[  4, 		PAnim_ProneWalk4	] {self.frame = 165;}
void() PAnim_ProneWalk4	=[  5, 		PAnim_ProneWalk5	] {self.frame = 166;}
void() PAnim_ProneWalk5	=[  6, 		PAnim_ProneWalk6	] {self.frame = 167;}
void() PAnim_ProneWalk6	=[  7, 		PAnim_ProneWalk7	] {self.frame = 168;}
void() PAnim_ProneWalk7	=[  8, 		PAnim_ProneWalk8	] {self.frame = 169;}
void() PAnim_ProneWalk8	=[  9, 		PAnim_ProneWalk9	] {self.frame = 170;}
void() PAnim_ProneWalk9	=[  10, 	PAnim_ProneWalk10	] {self.frame = 171;}
void() PAnim_ProneWalk10=[  11, 	PAnim_ProneWalk11	] {self.frame = 172;}
void() PAnim_ProneWalk11=[  12, 	PAnim_ProneWalk12	] {self.frame = 173;}
void() PAnim_ProneWalk12=[  13, 	SUB_Null			] {self.frame = 174;}

// Reloading, while Prone
void() PAnim_PrReload   =[	1,		PAnim_PrReload1	  	] {self.frame = 176; self.tp_anim_time = time + 1;}
void() PAnim_PrReload1  =[	2,		PAnim_PrReload2	  	] {self.frame = 177;}
void() PAnim_PrReload2  =[	3,		PAnim_PrReload3	  	] {self.frame = 178;}
void() PAnim_PrReload3  =[	4,		PAnim_PrReload4	  	] {self.frame = 179;}
void() PAnim_PrReload4  =[	5,		PAnim_PrReload5	  	] {self.frame = 180;}
void() PAnim_PrReload5  =[	6,		PAnim_PrReload6	  	] {self.frame = 181;}
void() PAnim_PrReload6  =[	7,		SUB_Null	  		] {self.frame = 162;}

// Enter Crouch, from Prone
void() PAnim_UpCrouch 	=[  1, 		PAnim_UpCrouch1		] {self.frame = 161; self.tp_anim_time = time + 1;}
void() PAnim_UpCrouch1 	=[  2, 		PAnim_UpCrouch2		] {self.frame = 160;}
void() PAnim_UpCrouch2 	=[  3, 		PAnim_UpCrouch3		] {self.frame = 159;}
void() PAnim_UpCrouch3 	=[  4, 		PAnim_UpCrouch4		] {self.frame = 158;}
void() PAnim_UpCrouch4 	=[  5, 		PAnim_UpCrouch5		] {self.frame = 157;}
void() PAnim_UpCrouch5 	=[  6, 		PAnim_UpCrouch6		] {self.frame = 156;}
void() PAnim_UpCrouch6 	=[  7, 		PAnim_UpCrouch7		] {self.frame = 155;}
void() PAnim_UpCrouch7 	=[  8, 		PAnim_UpCrouch8		] {self.frame = 154;}
void() PAnim_UpCrouch8 	=[  9, 		SUB_Null			] {self.frame = 115;}

// Enter Last Stand
void() PAnim_GetDown	=[	1, 		PAnim_GetDown1		] {self.frame = 32; self.tp_anim_time = time + 1;};
void() PAnim_GetDown1	=[	2, 		PAnim_GetDown2		] {self.frame = 33;};
void() PAnim_GetDown2	=[	3, 		PAnim_GetDown3		] {self.frame = 34;};
void() PAnim_GetDown3	=[	4, 		PAnim_GetDown4		] {self.frame = 35;};
void() PAnim_GetDown4	=[	5, 		PAnim_GetDown5		] {self.frame = 36;};
void() PAnim_GetDown5	=[	6, 		SUB_Null			] {self.frame = 37; rec_downed();};

// Firing, while in Last Stand
void() PAnim_LastFire 	=[	1,		PAnim_LastFire1		] {self.frame = 36; self.tp_anim_time = time + 0.25;}
void() PAnim_LastFire1  =[	2,		SUB_Null			] {self.frame = 37;} 

// Leave Last Stand
void() PAnim_GetUp 		=[	1,		PAnim_GetUp1		] {self.frame = 39; self.tp_anim_time = time + 1;}
void() PAnim_GetUp1		=[	2,		PAnim_GetUp2		] {self.frame = 40;}
void() PAnim_GetUp2		=[	3,		PAnim_GetUp3		] {self.frame = 41;}
void() PAnim_GetUp3		=[	4,		PAnim_GetUp4		] {self.frame = 42;}
void() PAnim_GetUp4		=[	5,		PAnim_GetUp5		] {self.frame = 43;}
void() PAnim_GetUp5		=[	6,		PAnim_GetUp6		] {self.frame = 44;}
void() PAnim_GetUp6		=[	7,		PAnim_GetUp7		] {self.frame = 45;}
void() PAnim_GetUp7		=[	8,		PAnim_GetUp8		] {self.frame = 46;}
void() PAnim_GetUp8		=[	9,		PAnim_GetUp9		] {self.frame = 47;}
void() PAnim_GetUp9		=[	10,		SUB_Null			] {self.frame = 48;}


#define forward 	0
#define backward 	1
#define left 		2
#define right 		3
#define all_move    -1

float(float dir) checkMovement =
{	
	switch(dir) {
		case forward:
			if (self.movement_x > 0)
				return 1;
		break;
		case backward:
			if (self.movement_x < 0)
				return 1;
		break;
		case right:
			if (self.movement_y > 0)
				return 1;
		break;
		case left:
			if (self.movement_y < 0)
				return 1;
		break;
		case all_move:
			if (self.movement_x || self.movement_y)
				return 1;
		break;
		default:
			return 0;
	}
}

//
// Player_CanStandHere
// Performs a tracebox and will return true
// if the player can stance in their current
// space.
//
float(entity who) Player_CanStandHere =
{
	/*
	// There shouldn't be any real reason we'd care about this since beta maps don't support
	// stance changing impacting the bbox, but still, consistency..
	if (map_compatibility_mode == MAP_COMPAT_BETA)
		tracebox(who.origin, PLAYER_MINS_QUAKE, PLAYER_MAXS_QUAKE, who.origin, true, who);
	else
		tracebox(who.origin, PLAYER_MINS_STANDING, PLAYER_MAXS_STANDING, who.origin, true, who);

	return !trace_startsolid;
	*/
}

//
// Player_SetStance(who, preferred_stance, play_animation)
// Lowers the camera height as needed, registers
// preferred stance, plays animation, and sets 
// bounding box (if applicable).
//
void(entity who, float preferred_stance, float play_animation) Player_SetStance =
{
	// Don't bother if we're already the desired stance, or if it wasn't valid
	if (who.stance == preferred_stance || preferred_stance < 0 || preferred_stance > 2)
		return;

	// First check -- if we want to stand, only crouch if there
	// is no space for it.
	if (preferred_stance == PLAYER_STANCE_STAND && !Player_CanStandHere(who))
		preferred_stance = PLAYER_STANCE_CROUCH;

	// Set the bounding box
	if (map_compatibility_mode != MAP_COMPAT_BETA) {
		if (preferred_stance != PLAYER_STANCE_STAND)
			setsize(self, PLAYER_MINS_CROUCHING, PLAYER_MAXS_CROUCHING);
		else
			setsize(self, PLAYER_MINS_STANDING, PLAYER_MAXS_STANDING);
	}

	// NZ:P Beta should change the stances by a different amount,
	// to avoid looking like you're in the ground..
	float height_diff_crouch, height_diff_prone;
	if (map_compatibility_mode == MAP_COMPAT_BETA) {
		height_diff_crouch = PLAYER_CROUCH_DIFFERENCE_QK;
		height_diff_prone = PLAYER_PRONE_DIFFERENCE_QK;
	} else {
		height_diff_crouch = PLAYER_CROUCH_DIFFERENCE_HL;
		height_diff_prone = PLAYER_PRONE_DIFFERENCE_HL;
	}

	// Prone while standing? Lower to crouch + prone height.
	if (who.stance == PLAYER_STANCE_STAND && preferred_stance == PLAYER_STANCE_PRONE)
		who.new_ofs_z = who.view_ofs_z - (height_diff_crouch + height_diff_prone);

	// Prone while crouching? Lower to prone height.
	else if (who.stance == PLAYER_STANCE_CROUCH && preferred_stance == PLAYER_STANCE_PRONE)
		who.new_ofs_z = who.view_ofs_z - height_diff_prone;

	// Crouch while proning? Raise to crouch height/take away prone difference.
	else if (who.stance == PLAYER_STANCE_PRONE && preferred_stance == PLAYER_STANCE_CROUCH)
		who.new_ofs_z = who.view_ofs_z + height_diff_prone;

	// Crouch while standing? Lower to crouch height.
	else if (who.stance == PLAYER_STANCE_STAND && preferred_stance == PLAYER_STANCE_CROUCH)
		who.new_ofs_z = who.view_ofs_z - height_diff_crouch;

	// Stand while crouching? Raise to stand height/take away crouch difference.
	else if (who.stance == PLAYER_STANCE_CROUCH && preferred_stance == PLAYER_STANCE_STAND)
		who.new_ofs_z = who.view_ofs_z + height_diff_crouch;

	// Stand while proning? Raise to stand height/take away crouch + prone difference.
	else if (who.stance == PLAYER_STANCE_PRONE && preferred_stance == PLAYER_STANCE_STAND)
		who.new_ofs_z = who.view_ofs_z + (height_diff_crouch + height_diff_prone);

	// Set the stance value
	who.stance = preferred_stance;

	// Animation playback
	if (play_animation == true) {
		entity tempe = self;
		self = who;

		switch(who.stance) {
			case PLAYER_STANCE_STAND: PAnim_Stand(); break;
			case PLAYER_STANCE_CROUCH: PAnim_Crouch(); break;
			case PLAYER_STANCE_PRONE: PAnim_Prone(); break;
			default: break;
		}

		self = tempe;
	}
}

void() PlayerJump =
{
	if (!(self.flags & FL_ONGROUND) 
	    || !(self.flags & FL_JUMPRELEASED)
		|| self.downed 
		|| self.dive ) {
		return;
	}
			
	self.flags = self.flags - (self.flags & FL_JUMPRELEASED);

	if (self.button2)
		self.button2 = 0;
	
	self.oldz = self.origin_z;

	self.velocity_z = 230;
}

void(float override) JumpCheck =
{

#ifndef FTE

	override = 0;

#endif // FTE

	if(self.button2 || override) {
		if (self.downed)
			return;
			
		if (self.stance == PLAYER_STANCE_STAND) {
			PlayerJump();
		} else if (self.view_ofs_z == self.new_ofs_z && (self.flags & FL_ONGROUND)) {
			Player_SetStance(self, PLAYER_STANCE_STAND, true);
		}
	} else
		self.flags = self.flags | FL_JUMPRELEASED;
}

void() PlayerPreThink = 
{

	

};


void() PlayerPostThink = 
{

	

};

void() ClientKill = 
{

	
	
};


void() ClientConnect = 
{

	

};


void() ClientDisconnect = 
{

	

};

void() SpectatorSpawn =
{
	local entity spawnpoint;
	spawnpoint = find(world, classname, "info_player_1_spawn");
	
	self.isspec = TRUE;
	self.health = 420;
	self.classname = "spectator";
	self.solid = SOLID_CORPSE;
	setmodel(self, "models/sprites/null.spr");
	self.movetype = MOVETYPE_FLY;
	self.origin = spawnpoint.origin + [0,0,1];
	self.fixangle = TRUE;
	setsize(self, PLAYER_MINS_STANDING, PLAYER_MAXS_STANDING);
	self.view_ofs = '0 0 22';
	self.aiment = world;
};

//called when a client loads a map
float spawns_initialized;
void() PutClientInServer = 
{

	local entity spawn_spot;
	spawn_spot = find(world, classname, "info_player_start");
	
	self.classname = "player";
	self.health = self.max_health = 100;
	self.takedamage = DAMAGE_AIM;
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_WALK;
	self.flags = FL_CLIENT;
	
	self.origin = spawn_spot.origin + '0 0 1';
	self.angles = spawn_spot.angles;
	self.fixangle = TRUE;
	
	//self.weapon = IT_PEPPERBOX;
	//self.items = 64;
	
	setmodel (self, "progs/player.mdl");
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
	
	self.view_ofs = VIEW_OFS_HL;
	self.velocity = '0 0 0';

};

