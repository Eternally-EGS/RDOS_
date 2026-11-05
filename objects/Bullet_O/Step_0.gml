Current_Life_Time += 1 / fps;

if (Current_Life_Time >= Life_Time && Broke == 0) {
    Broke = 1;
    DeadDelay = DeadMaxDelay;
}

if (Broke == 1) {
    speed = 0;
    image_angle = 0;
    depth = 2;
    sprite_index = BulletB_S;
    DeadDelay -= 1 / fps;
    
    if (DeadDelay < DeadMaxDelay / 4) {
        DeadAlpha -= 0.05;
    }
}

image_alpha = DeadAlpha;

if (Broke == 0) {
    if (bounce_timer > 0) {
        bounce_timer -= 1;
        if (bounce_timer <= 0) {
            direction = next_dir;
            speed = saved_speed;
            StartLine();
        }
    } else {
        image_angle += Animation_Speed;

        var _hit_x = place_meeting(x + hspeed, y, AllWall_O);
        var _hit_y = place_meeting(x, y + vspeed, AllWall_O);

        if (_hit_x || _hit_y) {
            next_dir = direction;
            if (_hit_x) next_dir = 180 - next_dir;
            if (_hit_y) next_dir = 360 - next_dir;

            saved_speed = speed;
            speed = 0;
            bounce_timer = bounce_delay_max;
        }
    }

    if (instance_exists(_cut)) {
        _cut.sizeX = point_distance(x, y, _cut.x, _cut.y);
    }
}

if (DeadAlpha <= 0) {
    for (var i = 0; i < array_length(my_cuts); i++) {
        if (instance_exists(my_cuts[i])) {
            instance_destroy(my_cuts[i]);
        }
    }
    instance_destroy();
}

image_index = Form;
