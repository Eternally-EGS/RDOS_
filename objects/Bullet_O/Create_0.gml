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

// Вызывается в Step при ударе — запускает анимацию
function TriggerGrade(Text, _xx = x, _yy = y) {
    // Если передали число (угол) — округляем и переводим в текст, если уже текст — оставляем как есть
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

// Вызывается каждый кадр в Draw — рисует и двигает анимацию

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

// Флаги, чтобы бонус за фигуру сработал один раз за выстрел
got_45 = false;
got_triangle = false;
got_square = false;

// Функция проверки углов и фигур
function CheckAngleBonuses() {
    if (!instance_exists(Player_O)) return;

    var _len = array_length(gradas);
    if (_len == 0) return;

    // 1. БОНУС ЗА УГОЛ 45° (с допуском ±5 градусов, чтобы было реально попасть)
    var _last_angle = gradas[_len - 1];
    if (!got_45 && abs(angle_difference(_last_angle, 45)) <= 5) {
        got_45 = true;
        Player_O.buff_speed_timer = 180; // Бафф на 3 секунды (180 кадров при 60 FPS)
        TriggerGrade("45! SPEED UP!", x, y - 30);
    }

    // 2. БОНУС ЗА ТРЕУГОЛЬНИК (3 рикошета, где сумма поворотов примерно 180° или просто 3 разных угла)
    if (!got_triangle && _len >= 3) {
        // Проверяем, что последние 3 угла заметно отличаются друг от друга (образуют треугольник)
        var _a1 = gradas[_len - 3];
        var _a2 = gradas[_len - 2];
        var _a3 = gradas[_len - 1];
        
        if (abs(angle_difference(_a1, _a2)) > 20 && abs(angle_difference(_a2, _a3)) > 20 && abs(angle_difference(_a1, _a3)) > 20) {
            got_triangle = true;
            Player_O.buff_rapid_timer = 240; // Ускорение рывка (Rapid) на 4 секунды
            TriggerGrade("TRIANGLE! RAPID+", x, y - 30);
        }
    }

    // 3. БОНУС ЗА КВАДРАТ (4 рикошета подряд под углами ~90° друг к другу, например 45 -> 135 -> 225 -> 315)
    if (!got_square && _len >= 4) {
        var _is_square = true;
        for (var i = _len - 3; i < _len; i++) {
            var _diff = abs(angle_difference(gradas[i - 1], gradas[i]));
            // Разница между соседними ударами должна быть около 90 градусов (±15°)
            if (abs(_diff - 90) > 15) {
                _is_square = false;
                break;
            }
        }
        
        if (_is_square) {
            got_square = true;
            Player_O.buff_god_timer = 300; // Мощный бафф (скорость + доп. пули + лечение) на 5 секунд
            Player_O.CurrentHP = min(Player_O.MaxHP, Player_O.CurrentHP + 2); // +2 HP сразу
            TriggerGrade("SQUARE! OVERDRIVE!", x, y - 30);
        }
    }
}

bounce_delay_max = 1; // Задержка в кадрах (6 кадров = 0.1 сек при 60 FPS; поставь нужное число)
bounce_timer = 0;     // Текущий счетчик задержки
saved_speed = 0;      // Запоминаем скорость пули до удара
next_dir = 0;  