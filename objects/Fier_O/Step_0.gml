image_index += 0.1;
if (lifeTime > 0) { lifeTime -= 1/fps } else { instance_destroy(self) }

tim += delta_time / 1000000; 

if (tim >= 0.5) {
    tim -= 0.5;
if (instance_exists(Player_O)) {
Damage = 0.33 * Player_O.Damage;
}
} else { Damage = 0; }