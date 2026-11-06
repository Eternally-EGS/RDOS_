
// 1. Обновление анимации
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


if (HitCDelay > 0) {
    HitCDelay -= 1 / fps;
} else {
    Hit = 0;
    var _bullet = instance_place(x, y, Bullet_O);
    
    if (_bullet != noone) {
        if (_bullet.Broke == 0) {
		Hit = 1;
        HitCDelay = HitMaxDelay;
        CurrentHP -= _bullet.Damage;
		}
        
    }
}

var _list = ds_list_create();
var _count = instance_place_list(x, y, EnemyBase_O, _list, false);

if (_count > 0) {
    var _total_px = 0;
    var _total_py = 0;
    
    for (var i = 0; i < _count; i++) {
        var _bro = _list[| i];
        var _push_dir = (x == _bro.x && y == _bro.y) 
                        ? random(360) 
                        : point_direction(_bro.x, _bro.y, x, y);
        
        _total_px += lengthdir_x(4, _push_dir);
        _total_py += lengthdir_y(4, _push_dir);
    }
    
    var _push_len = point_distance(0, 0, _total_px, _total_py);
    if (_push_len > 4) {
        _total_px = (_total_px / _push_len) * 4;
        _total_py = (_total_py / _push_len) * 4;
    }
    
    if (!place_meeting(x + _total_px, y, AllWall_O)) x += _total_px;
    if (!place_meeting(x, y + _total_py, AllWall_O)) y += _total_py;
}

ds_list_destroy(_list);


if (CurrentHP <= 0) {
    instance_destroy();
}
