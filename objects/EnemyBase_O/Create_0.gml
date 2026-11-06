Speed = 1;
image_xscale = 4;
image_yscale = 4;
MaxHP = 3;
CurrentHP = MaxHP;
HitMaxDelay = 0.1;
HitCDelay = 0;

Hit = 0;
CFlash = 0;
MaxFlashTime = 0.1;
FlashSpeed = 0.1;
Knock_force = 10;

Start_colide = 1;

EBaseAnim = 0;
EAnimPlay = 0;
EAnim = 0;
EAnimLoop = 0;
EAnimSpeed = 0;
BaseAnimSpeed = 0.1;

Damage = 1;
HitCDelay = 0;

WalkDown = [0,1,2,3]
WalkUp = [4,5,6,7]
WalkLeft = [10,11]
WalkRight = [8,9]

EBaseAnim  = 0;
EAnimPlay  = 0;
EAnim      = WalkDown;
EAnimSpeed = 0;
EAnimLoop  = 1

function PlayAnimation(_anim, _loop, _anim_speed) {
    // Запускаем заново, только если включилась новая анимация или она еще не играла
    if (EAnim != _anim || EAnimPlay == 0) {
        EAnimPlay   = 1;
        EAnim       = _anim;
        EAnimSpeed  = _anim_speed;
        EAnimLoop   = _loop;
        image_index = _anim[0];
    }
}

function StopAnimation() {
    EBaseAnim   = 0;
    EAnimPlay   = 0;
    image_index = 0;
}
// Мгновенно разъединяем при спауне, если попали друг в друга
var _tries = 0;
while (place_meeting(x, y, EnemyBase_O) && _tries < 60) {
    var _other = instance_place(x, y, EnemyBase_O);
    var _dir = random(360);
    
    if (_other != noone && (x != _other.x || y != _other.y)) {
        _dir = point_direction(_other.x, _other.y, x, y);
    }
    
    var _px = lengthdir_x(4, _dir);
    var _py = lengthdir_y(4, _dir);
    
    if (!place_meeting(x + _px, y, AllWall_O)) x += _px;
    if (!place_meeting(x, y + _py, AllWall_O)) y += _py;
    
    _tries += 1;
}