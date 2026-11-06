draw_self();
draw_set_font(Base_F)
//draw_text(600,500, tutor)
//draw_text(600,400, help)
//draw_text(600,300, tutorzakrep)

if (tuterhelp == 1){
	//draw_text(600,600, PlayerEpilog_obj.y)
	draw_text_ext_colour(355,600,"WASD - Walk, USE - E",10000,10000,c_white,c_white,c_white,c_white,helperalpha)
}
if (book == 1){
	draw_sprite_ext(Furnt9_sp,0,1280/2,390,4,4,0,c_white,1)
	
	draw_text_ext_colour(355,600,"123456789",10000,10000,c_white,c_white,c_white,c_white,1)
}