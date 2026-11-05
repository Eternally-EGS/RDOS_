image_alpha = alphys
if (dir == 0){
	alphys += 0.02
}else alphys -= 0.02

if alphys >= 1{
	timer += 1/60
	if timer >= 1.5{
		dir = 1
	}
}
if (dir == 1) and (alphys == 0){
	room_goto(Main_Menu)
}