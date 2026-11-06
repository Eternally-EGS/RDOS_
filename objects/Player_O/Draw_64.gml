draw_text(10,10,$"HP {CurrentHP}")
//draw_text(10,30,$"HitCDelay {HitCDelay}")
//draw_text(10,50,$"Hit {Hit}")
draw_text(10,30,$"Speed {Max_Speed}")
draw_text(10,50,$"Damage {Damage}")
if instance_exists(EnemyBase_O){
draw_text(10,70,$"EnemyBase_O.MaxHP {EnemyBase_O.MaxHP}")
draw_text(10,90,$"EnemyBase_O.Speed {EnemyBase_O.Speed}")
draw_text(10,110,$"EnemyBase_O.Damage {EnemyBase_O.Damage}")
}