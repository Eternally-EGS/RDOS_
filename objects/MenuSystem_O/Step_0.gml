
if keyboard_check_pressed(vk_enter) or keyboard_check_pressed(ord("E")) {
	room_goto(Epilog) 
	}


tim += 0.01;

PeriodC += delta_time / 1000000;

if (PeriodC >= period) {
    instance_create_depth(2112, 453, 1, MenuVisual_O);
    PeriodC -= period; 
}

color += 0.05
if color >= 2{
color = 0
}