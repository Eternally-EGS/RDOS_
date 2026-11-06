x= X;
y = Y;

var AllHit = [Bullet_O,Fier_O,BoomColide_O,Kill_O]

if (OBJ.HitCDelay > 0) {
    OBJ.HitCDelay -= 1 / fps;
} else {
    OBJ.Hit = 0;
    var _bullet = instance_place(x, y, AllHit);
    
    if (_bullet != noone) {
        if (_bullet.Broke == 0) {
		OBJ.Hit = 1;
        OBJ.HitCDelay = OBJ.HitMaxDelay;
        OBJ.CurrentHP -= _bullet.Damage;
		}
        
    }
}