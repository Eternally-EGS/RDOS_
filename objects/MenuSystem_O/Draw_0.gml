var _x = camera_get_view_width(view_camera[0]) / 2;
var _y = camera_get_view_height(view_camera[0]) / 2;
var scale = 2.855;
flash_amount = 0.5; 
shader_set(Menu_SH);
shader_set_uniform_f(u_intensity_handle, flash_amount);
shader_set_uniform_f(u_time_handle, tim);
shader_set_uniform_f(u_mode_handle, shader_mode);

draw_sprite_ext(MenuBack_S, 0, _x, _y, 3, 3, 0, c_white, 1);
shader_reset();

draw_sprite_ext(Menulogo_S, 0, _x, _y - 300, 2, 2, sin(tim) * 10, c_white, 1);



draw_set_font(Base_F);
var text = "press Enter to start";
draw_text_ext_colour(_x - string_width(text) / 2, _y + 300, text, 1000, 1000, c_black, c_black, c_black, c_black, 1);
draw_set_font(-1);