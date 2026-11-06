
if (EAnimPlay == 1) {
    var _last_index = EAnim[array_length(EAnim) - 1];
    image_index += EAnimSpeed;
    
    if (image_index < EAnim[0]) {
        image_index = EAnim[0];
    }
    
    if (image_index >= _last_index + 1) {
        if (EAnimLoop == 0) {
            image_index = EBaseAnim;
            EAnimPlay = 0;
        } else {
            image_index = EAnim[0];
        }
    }
}

if (instance_exists(Player_O)) {
    var _dist = point_distance(x, y, Player_O.x, Player_O.y);
    
    if (_dist > 64) {
        mp_potential_step_object(Player_O.x, Player_O.y, Speed, AllWall_O);
    } else {
        var _dir = point_direction(x, y, Player_O.x, Player_O.y);
        var _mx  = lengthdir_x(Speed, _dir);
        var _my  = lengthdir_y(Speed, _dir);
        
        if (!place_meeting(x + _mx, y, AllWall_O)) x += _mx;
        if (!place_meeting(x, y + _my, AllWall_O)) y += _my;
    }
}

if (x != xprevious || y != yprevious) {
    var _abs_dx = abs(x - xprevious);
    var _abs_dy = abs(y - yprevious);
    
    if (_abs_dx >= _abs_dy) {
        if (x < xprevious) {
            PlayAnimation(WalkLeft, 1, BaseAnimSpeed);
        } else {
            PlayAnimation(WalkRight, 1, BaseAnimSpeed);
        }
    } else {
        if (y < yprevious) {
            PlayAnimation(WalkUp, 1, BaseAnimSpeed);
        } else {
            PlayAnimation(WalkDown, 1, BaseAnimSpeed);
        }
    }
} else {
    StopAnimation();
}


if (CurrentHP <= 0) {
    instance_destroy();
}

if (instance_exists(Colide)) {
Colide.X = x
Colide.Y = y
Colide.OBJ = self;
}

var _other_enemy = instance_place(x, y, AllWall_O);

if (_other_enemy != noone) {
    var _push_dir = point_direction(_other_enemy.x, _other_enemy.y, x, y);
    
    if (x == _other_enemy.x && y == _other_enemy.y) {
        _push_dir = irandom_range(-359,359);
    }
    
    var _push_speed = 1.5;
    x += lengthdir_x(_push_speed, _push_dir);
    y += lengthdir_y(_push_speed, _push_dir);
}

if (x > room_width) { instance_destroy(); }
if (x < 0) { instance_destroy(); }

if (y > room_height) { instance_destroy(); }
if (y < 0) { instance_destroy(); }