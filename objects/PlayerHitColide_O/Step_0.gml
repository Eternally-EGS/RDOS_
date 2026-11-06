if (instance_exists(Player_O)) {
var _enemy = instance_place(x, y, EnemyBase_O);

if (_enemy != noone) {
	var knock_dir = point_direction(_enemy.x, _enemy.y, x, y);
        
    Player_O.knock_speed_x = lengthdir_x(_enemy.Knock_force, knock_dir);
    Player_O.knock_speed_y = lengthdir_y(_enemy.Knock_force, knock_dir);
}

// Hit
if (Player_O.HitCDelay <= 0) {
    Player_O.Hit = 0;
    
    if (_enemy != noone) {
        Player_O.Hit = 1;
        Player_O.HitCDelay = Player_O.HitMaxDelay;
        
        Player_O.CurrentHP -= _enemy.Damage; 
    }
}

x = Player_O.x
y = Player_O.y

}

