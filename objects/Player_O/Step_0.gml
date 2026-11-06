// Animation Pack
var WalkDown = [0,1,2,3]
var WalkUp = [4,5,6,7]
var WalkLeft = [10,11]
var WalkRight = [8,9]

var RapidDown = [0,1,2,3,4]
var RapidUp = [5,6,7,8,9]
var RapidLeft = [15,16,17,18,19]
var RapidRight = [10,11,12,13,14]

var kickRight = [0]
var kickLeft = [1]

function PlayAnimation(Anim,Loop,AnimSpeed,IsUpdate) {
	if(IsUpdate == 0) {
		EAnimPlay = 1;
		EAnim = Anim;
		EAnimSpeed = AnimSpeed;
		EAnimLoop = Loop;
		image_index = Anim[0]; 
	} else { 	
		var LastIndex = Anim[array_length(Anim) - 1];	
		image_index += AnimSpeed;
		if image_index < Anim[0] { image_index = Anim[0] }
		if image_index >= LastIndex + 1 { image_index = Anim[0]; } 
	}
}

function StopAnimation() {
	EBaseAnim = 0;
	EAnimPlay = 0;
	image_index = 0;
}

// AnimUpdate 
if (EAnimPlay == 1) {
	var LastIndex = EAnim[array_length(EAnim) - 1];	
	
	if (EAnimLoop == 0) {  
		image_index += EAnimSpeed;
		if image_index < EAnim[0] { image_index = EAnim[0] }
		if image_index >= LastIndex + 1 { image_index = EBaseAnim; EAnimPlay = 0; }
	} else {
		image_index += EAnimSpeed;
		if image_index < EAnim[0] { image_index = EAnim[0] }
		if image_index >= LastIndex + 1 { image_index = EAnim[0]; }
	}
}



// Walk
if (Rapid == 0) { 
	var _left = keyboard_check_direct(ord("A"))
	var _right = keyboard_check(ord("D"));
	var _up = keyboard_check(ord("W"));
	var _down = keyboard_check(ord("S"));

	var _hspd = _right - _left;
	var _vspd = _down - _up;

	if (_hspd != 0 || _vspd != 0) {
	    if (_vspd > 0) {
	        PlayAnimation(WalkDown, 1, BaseAnimSpeed, 1);
	    } else if (_vspd < 0) {
	        PlayAnimation(WalkUp, 1, BaseAnimSpeed, 1);
	    }
	    else if (_hspd > 0) {
	        PlayAnimation(WalkRight, 1, BaseAnimSpeed, 1);
	    } else if (_hspd < 0) {
	        PlayAnimation(WalkLeft, 1, BaseAnimSpeed, 1);
	    }
	} else {
		StopAnimation();
	}

	if (Directionx != 0 || Directiony != 0) {
		var _dir = point_direction(0, 0, Directionx, Directiony);
		var _xadd = lengthdir_x(Current_Speed, _dir);
		var _yadd = lengthdir_y(Current_Speed, _dir);
		if !place_meeting(x + _xadd,y,AllWall_O){ x = x + _xadd }
		if !place_meeting(x,y + _yadd,AllWall_O){ y = y + _yadd }
	}

	if (_left || _right || _up || _down) { 
		Directionx = _hspd;
		Directiony = _vspd;
		if Current_Speed < Max_Speed { Current_Speed += Inertia; }
	} else { if Current_Speed > 0 { Current_Speed -= Inertia; } }
}

// Shot

if (ShotBlock > 0) { ShotBlock -- }

if (ShotBlock == 0) then
if (mouse_check_button_pressed(mb_left) && instance_number(Bullet_O) < MaxBulletCounte) {
	var Bul = instance_create_depth(x,y,0,Bullet_O);
	BulletFrame ++;
	Bul.Form = BulletFrame;
	Bul.Damage = Damage;
	Bul.DeadMaxDelay = DeadMaxDelay;
	ShotDel = 1;
} 

if (ShotDel == 1) { sprite_index = PlayerKick_S; if (x < mouse_x) { image_index = 0 } if (x > mouse_x) { image_index = 1 } ShotCDel += 0.1; }
if (ShotCDel > 1) { ShotCDel = 0; ShotDel = 0; sprite_index = Player_S; image_index = 0; }

if (BulletFrame > sprite_get_number(Bullet_S) - 1) { BulletFrame = 0; }

// Rapid
if (RapidCurrentDelay > 0) { RapidCurrentDelay -= 1 / fps }

if (Rapid == 0 && RapidCurrentDelay <= 0) { 
	if (mouse_check_button_pressed(mb_right)) {
		Rapid = 1;
		speed = RapidSpeed;
		RapidTime = RapidMaxTime;
		RapidCurrentDelay = RapidDelay;
		
		var _rapid_anim = RapidRight;
				
		if (Directiony == -1 && Directionx == 1) { _rapid_anim = RapidUp;         direction = 45;  }
		else if (Directiony == -1 && Directionx == -1) { _rapid_anim = RapidUp;   direction = 135;  } 
		else if (Directiony == 1  && Directionx == -1) { _rapid_anim = RapidDown; direction = 225;  }
		else if (Directiony == 1  && Directionx == 1) { _rapid_anim = RapidDown;  direction = 315;  }		

		else if (Directionx == 1)  { _rapid_anim = RapidRight; direction = 0;   } 
		else if (Directiony == -1) { _rapid_anim = RapidUp;	   direction = 90; 	}   
		else if (Directionx == -1) { _rapid_anim = RapidLeft;  direction = 180;  } 
		else if (Directiony == 1)  { _rapid_anim = RapidDown;  direction =  270; }  
		
		PlayAnimation(_rapid_anim, 0, RapidAnimSpeed, 0);
	}
}

if (Rapid == 1) {
	sprite_index = PlayerRapid_S;
	if (RapidTime > 0) { RapidTime -= 1 / fps }
	
	if (RapidTime <= 0) { 
		Rapid = 0; 
		speed = 0;
		sprite_index = Player_S;
		StopAnimation(); 
	}
	
	if (place_meeting(x + lengthdir_x(speed, direction), y + lengthdir_y(speed, direction), Wall_O)) { 
		Rapid = 0; 
		speed = 0; 
		sprite_index = Player_S;
		StopAnimation();
	}
}

var _enemy = instance_place(x, y, EnemyBase_O);

if (_enemy != noone) {
	var knock_dir = point_direction(_enemy.x, _enemy.y, x, y);
        
    knock_speed_x = lengthdir_x(_enemy.Knock_force, knock_dir);
    knock_speed_y = lengthdir_y(_enemy.Knock_force, knock_dir);
}

// Hit

if (CurrentHP <= 0) { instance_destroy(self) }

if (place_meeting(x + knock_speed_x, y, Wall_O)) {
    knock_speed_x = 0; 
}
x += knock_speed_x;

if (place_meeting(x, y + knock_speed_y, Wall_O)) {
	knock_speed_y = 0;
}
y += knock_speed_y;

knock_speed_x = lerp(knock_speed_x, 0, 0.15);
knock_speed_y = lerp(knock_speed_y, 0, 0.15);

x += knock_speed_x;
y += knock_speed_y;

if (buff_speed_timer > 0)       { buff_speed_timer -= 1;       Max_Speed = saveSpeed * 1.05; }      else { Max_Speed = saveSpeed; }
if (buff_rapid_timer > 0)       { buff_rapid_timer -= 1;       RapidMaxTime = saveRapid * 1.35; }   else { RapidMaxTime = saveRapid; }
if (buff_damage_timer > 0)      { buff_damage_timer -= 1;      Damage = saveDamage * 1.35; }        else { Damage = saveDamage; }
if (buff_invinibALL_timer > 0)  { buff_invinibALL_timer -= 1;  HitCDelay = HitMaxDelay; Hit = 1; }         
if (buff_range_timer > 0)       { buff_range_timer -= 1;       DeadMaxDelay = saverange * 1.35; }   else { DeadMaxDelay = saverange; }
if (buff_BulletCount_timer > 0) { buff_BulletCount_timer -= 1; MaxBulletCounte = 999; }             else { MaxBulletCounte = saveBulletCount; BaseBulletCount = saveBulletCount; }

function BaseStats () {
	saveSpeed = Max_Speed;
	saveRapid = RapidMaxTime;
	saveDamage = Damage;
	saverange = DeadMaxDelay;
	saveBulletCount = MaxBulletCounte;
}

if (RegenPerk == 1) {
RegenDelayC += 1 / fps 

if (RegenDelayC >= RegenDelay) {

RegenDelayC0 += 1/ fps
if (RegenDelayC0 >= RegenDelay0) {  if (CurrentHP < MaxHP) { CurrentHP += CurrentHP * RegenStrange / 100 } RegenDelayC0 = 0;  }

}

}


