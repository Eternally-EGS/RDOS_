function Draw_HP_Bar(val,maxV,Bx,By,W,H) constructor {
	width = W;
    height = H;
	Cx = Bx;
	Cy = By;
	Cval = val;
	Cmax = maxV;
static Draw = function() {
	draw_sprite_ext(HPBarMask_S,0,Cx,Cy,width,height,0,c_white,1)
	
	var frame = 0
	if (Cval < Cval / 2) {frame = 1}
	if (Cval < Cval / 3) {frame = 2}
	
    if (Cval <= Cmax / 2) { frame = 1; } 
    if (Cval <= Cmax / 4) { frame = 2; }
        
    var hp_percentage = clamp(Cval / Cmax, 0, 1);
    var current_hp_width = width * hp_percentage;
        
    if (current_hp_width > 0) {
        draw_sprite_ext(HPVal_S, frame, Cx - 7 * width, Cy, current_hp_width, height,0,c_white,1);
    }
		
	draw_sprite_ext(HPIcon_S,0,Cx - 10 * width ,Cy,width,height,0,c_white,1)
}


}