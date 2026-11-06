draw_self();
if (Timer < MaxTimer) { Timer += 1 / fps; } else {
Boom --;
}

if (Boom == 5) {
draw_set_color(c_white);
var _cam = view_camera[0];
var _cx = camera_get_view_x(_cam);
var _cy = camera_get_view_y(_cam);
var _cw = camera_get_view_width(_cam);
var _ch = camera_get_view_height(_cam);

draw_set_color(c_white);
draw_rectangle(_cx, _cy, _cx + _cw, _cy + _ch, false);
Colider = instance_create_depth(x,y,depth,BoomColide_O)
Colider.image_xscale = Radius;
Colider.image_yscale = Radius;	
}


if (Boom <= 0) {
instance_destroy(self)
instance_destroy(Colider)
}





image_index = Timer * 10;
