if (stopincutscene == 0){
// Animation Pack
var WalkDown = [0,1,2,3]
var WalkUp = [4,5,6,7]
var WalkLeft = [10,11]
var WalkRight = [8,9]

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
if (help == 0){
	if PlayerEpilog_obj.y < 288{
		PlayerEpilog_obj.y += 0.2
		PlayerEpilog_obj.image_index += 0.07
		if PlayerEpilog_obj.image_index >= 4{
		PlayerEpilog_obj.image_index = 0
		}
	}else{ 
		stopincutscene = 0
		help = 1
	}
}
