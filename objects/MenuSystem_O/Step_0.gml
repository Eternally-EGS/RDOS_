
if keyboard_check_pressed(vk_enter) or mouse_check_button(mb_left) {
	room_goto(Epilog) 
	}


tim += 0.01;

PeriodC += delta_time / 1000000;

if (PeriodC >= period) {
    instance_create_depth(2112, 453, 1, MenuVisual_O);
    PeriodC -= period; 
}

