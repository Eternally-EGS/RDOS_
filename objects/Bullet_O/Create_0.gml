Start_Speed = 10;
Life_Time = 1;
Current_Life_Time = 0;
Animation_Speed = 10;
Damage = 0.1;
Form = 0;
Thro = 0;

Broke = 0;
DeadDelay = 0;
DeadMaxDelay = 1;
DeadAlpha = 1;

gold_sys = part_system_create();

gold_part = part_type_create();
part_type_shape(gold_part, pt_shape_pixel);
part_type_color1(gold_part, $41b5f0); 
part_type_size(gold_part, 1, 10, 0, 0);
part_type_life(gold_part, 30, 60);
part_type_direction(gold_part, 270, 270, 0, 0);
part_type_speed(gold_part, 0.5, 1.5, 0, 0);
part_type_gravity(gold_part, 0.05, 270);
part_type_alpha2(gold_part, 1, 0);
part_type_blend(gold_part, true);

var Dir = point_direction(x, y, mouse_x, mouse_y);

_cut = instance_create_depth(x,y,1,Cut_O);
_cut.Dir = Dir

direction = Dir;
image_angle = Dir;
speed = Start_Speed;
image_xscale = 3;
image_yscale = 3;

grade_text = "";
grade_x = 0;
grade_y = 0;
grade_scale = 6;
grade_alpha = 0;
gradas = [];

function TriggerGrade(Text, _xx = x, _yy = y) {
    if (is_real(Text)) {
        grade_text = string(round(Text));
    } else {
        grade_text = string(Text);
    }
    
    grade_x = _xx;
    grade_y = _yy;
    grade_scale = 2;
    grade_alpha = 1.0;
}


my_cuts = [];
_cut = noone;

function StartLine() {
    direction = (direction mod 360 + 360) mod 360;
    var _clean_dir = (round(direction) mod 360 + 360) mod 360;

    _cut = instance_create_depth(x, y, 1, Cut_O);
    _cut.Dir = direction;
    var _cuts = instance_create_depth(x, y, 0, CutS_O);
    array_push(my_cuts, _cut, _cuts);
    
    TriggerGrade(_clean_dir, x, y);
    array_push(gradas, _clean_dir);
    
    CheckAngleBonuses();
}




gradas = [];

got_45 = false;
got_pingpong = false;
got_triangle = false;
got_zigzag = false;
got_diamond = false;
got_square = false;
got_star = false;
got_chaos = false;


function CheckAngleBonuses() {
    if (!instance_exists(Player_O)) return;

    var _len = array_length(gradas);
    if (_len == 0) return;

    var _last_angle = gradas[_len - 1];

    if (!got_45 && abs(angle_difference(_last_angle, 45)) <= 5) {
        got_45 = true;
		Player_O.buff_speed_timer = 240;
        TriggerGrade("45! ", x, y - 30);
    }

    if (!got_pingpong && _len >= 2) {
        var _d1 = abs(angle_difference(gradas[_len - 2], gradas[_len - 1]));
        if (abs(_d1 - 180) <= 10) {
            got_pingpong = true;
            Player_O.buff_range_timer = 240;
            TriggerGrade("PING-PONG! 180!", x, y - 30);
        }
    }


    if (!got_triangle && _len >= 3) {
        var _a1 = gradas[_len - 3];
        var _a2 = gradas[_len - 2];
        var _a3 = gradas[_len - 1];
        
        if (abs(angle_difference(_a1, _a2)) > 20 && abs(angle_difference(_a2, _a3)) > 20 && abs(angle_difference(_a1, _a3)) > 20) {
            got_triangle = true;
			Player_O.buff_damage_timer = 240;
            TriggerGrade("TRIANGLE!", x, y - 30);
        }
    }

    if (!got_zigzag && _len >= 3) {
        var _diff1 = angle_difference(gradas[_len - 3], gradas[_len - 2]);
        var _diff2 = angle_difference(gradas[_len - 2], gradas[_len - 1]);
        
        if (sign(_diff1) != sign(_diff2) && abs(abs(_diff1) - 60) <= 20 && abs(abs(_diff2) - 60) <= 20) {
            got_zigzag = true;
            Player_O.buff_rapid_timer = 240; 
            TriggerGrade("ZIGZAG!", x, y - 30);
        }
    }

    if (!got_diamond && _len >= 4) {
        var _d1 = abs(angle_difference(gradas[_len - 4], gradas[_len - 3]));
        var _d2 = abs(angle_difference(gradas[_len - 3], gradas[_len - 2]));
        var _d3 = abs(angle_difference(gradas[_len - 2], gradas[_len - 1]));

        var _opp1 = abs(angle_difference(gradas[_len - 4], gradas[_len - 2]));
        var _opp2 = abs(angle_difference(gradas[_len - 3], gradas[_len - 1]));

        if (abs(_opp1 - 180) <= 15 && abs(_opp2 - 180) <= 15 && abs(_d1 - 90) > 15) {
            got_diamond = true;
			Player_O.buff_BulletCount_timer = 240; 
            TriggerGrade("DIAMOND!", x, y - 30);
        }
    }

    if (!got_square && _len >= 4) {
        var _is_square = true;
        for (var i = _len - 3; i < _len; i++) {
            var _diff = abs(angle_difference(gradas[i - 1], gradas[i]));
            if (abs(_diff - 90) > 15) {
                _is_square = false;
                break;
            }
        }
        
        if (_is_square) {
            got_square = true;
			Player_O.buff_invinibALL_timer = 240; 
            TriggerGrade("SQUARE!", x, y - 30);
        }
    }

    if (!got_star && _len >= 5) {
        var _is_star = true;
        for (var i = _len - 4; i < _len; i++) {
            var _diff = abs(angle_difference(gradas[i - 1], gradas[i]));
            if (abs(_diff - 144) > 20) {
                _is_star = false;
                break;
            }
        }

        if (_is_star) {
            got_star = true;
			Player_O.buff_invinibALL_timer = 240; 
			Player_O.buff_speed_timer = 240; 
            TriggerGrade("PENTAGRAM!", x, y - 30);
        }
    }

    if (!got_chaos && _len >= 6) {
        got_chaos = true;
		Player_O.buff_invinibALL_timer = 240; 
			Player_O.buff_speed_timer = 240; 
			Player_O.buff_rapid_timer = 240;
			Player_O.buff_damage_timer = 240;
        TriggerGrade("HEXAGON!", x, y - 30);
    }
}


bounce_delay_max = 1;
bounce_timer = 0;   
saved_speed = 0;      
next_dir = 0;  