// HUD
var _x = camera_get_view_width(view_camera[0]) / 2
var _y = camera_get_view_height(view_camera[0]) / 2
var scale = 2.855

var _gui_h = display_get_gui_height();
var _player_screen_y = Player_O.y - camera_get_view_y(view_camera[0]);
var _hud_top_y = _gui_h * 0.70; 

if (_player_screen_y > _hud_top_y) {
    HUDalpha = lerp(HUDalpha, 0.3, 0.1);
} else {
    HUDalpha = lerp(HUDalpha, 1, 0.1);
}

var BX = _x + 44;
var BY = _y + 23;

draw_sprite_ext(BaseHUD_S,0,BX,BY,scale,scale,0,c_white,HUDalpha)

var DropX = 0;
var DropY = 320;

draw_sprite_ext(HUDHPB_S,0,BX - DropX,BY + DropY,3,3,0,c_white,HUDalpha)
draw_sprite_ext(HUDHPIcon_S,0,BX - DropX - 320,BY + DropY,HUDIconscale,HUDIconscale,0,c_white,HUDalpha)

var hp_percentage = clamp(Player_O.CurrentHP / Player_O.MaxHP, 0, 1);
var current_hp_width = 3 * hp_percentage;

HUDVal = current_hp_width;

draw_sprite_ext(HUDHPV_S,0,BX - DropX - 276,BY + DropY,HUDVal,3,0,c_white,HUDalpha)

if (Player_O.CurrentHP == Player_O.MaxHP) {
HUDCAnim += HUDAnimSpeed;
draw_sprite_ext(HUDHPAnim_S,HUDCAnim,BX - DropX - 276,BY + DropY,HUDVal,3,0,c_white,HUDalpha)
}

// ruler
draw_sprite_ext(HUDRuler_S,0,BX - DropX + 540,BY + DropY,4,4,0,c_white,HUDalpha)


var Value = Player_O.MaxBulletCounte - instance_number(Bullet_O);
var Value1 = "";

if (instance_exists(Player_O)) {
    var _fps = game_get_speed(gamespeed_fps);

    if (Player_O.buff_speed_timer > 0)    Value1 += "SPEED UP: "  + string_format(Player_O.buff_speed_timer / _fps, 1, 1) + "s\n";
    if (Player_O.buff_rapid_timer > 0)    Value1 += "RAPID+: "    + string_format(Player_O.buff_rapid_timer / _fps, 1, 1) + "s\n";
	if (Player_O.buff_damage_timer > 0)    Value1 += "DAMAGE+: "    + string_format(Player_O.buff_damage_timer / _fps, 1, 1) + "s\n";
	if (Player_O.buff_invinibALL_timer > 0)    Value1 += "INVULNERABLE+: "    + string_format(Player_O.buff_invinibALL_timer / _fps, 1, 1) + "s\n";
	if (Player_O.buff_range_timer > 0)    Value1 += "RANGE+: "    + string_format(Player_O.buff_range_timer / _fps, 1, 1) + "s\n";
	if (Player_O.buff_BulletCount_timer > 0)    Value1 += "RULER+: "    + string_format(Player_O.buff_BulletCount_timer / _fps, 1, 1) + "s\n";
}

if (Value != "") {
    draw_text_colour(BX - DropX + 300, BY + DropY - 10, Value1, c_white, c_white, c_white, c_white, HUDalpha);
}

draw_set_font(Base_F)

draw_text_colour(BX - DropX + 560,BY + DropY - 10, Value,c_white,c_white,c_white,c_white,HUDalpha)

draw_text_colour(BX - DropX,BY + DropY - 660, vawe,c_white,c_white,c_white,c_white,HUDalpha)
draw_set_font(-1);

if (Wave_perk == 1) {
	
	var Maxy = 350;
	if (perkAnim > Maxy) { perkAnim -= 30 }
	draw_sprite_ext(PerkHUD_S,0,BX - DropX,BY + DropY - perkAnim,3,3,0,c_white,HUDalpha)
	draw_sprite_ext(PerkIcon_S,perk1Ico,BX - DropX - 200,BY + DropY - perkAnim - 30,5,5,0,c_white,HUDalpha)
	draw_sprite_ext(PerkIcon_S,perk2Ico,BX - DropX + 200,BY + DropY - perkAnim - 30,5,5,0,c_white,HUDalpha)
	
	draw_text_colour(BX - DropX - 230,BY + DropY - perkAnim + 80, perk1Text,c_white,c_white,c_white,c_white,HUDalpha)
	draw_text_colour(BX - DropX + 190,BY + DropY - perkAnim + 80, perk2Text,c_white,c_white,c_white,c_white,HUDalpha)

} else { perkAnim = 1000; }


var _combo_text = string_join_ext("\n", Combo);

draw_set_font(Base_F_Small)

draw_text_ext_colour(100, 650, _combo_text, -1, 10000, c_white, c_white, c_white, c_white, HUDalpha);

draw_set_font(-1)

if (ComboCTime > 0) { ComboCTime -= 1 / fps } else { if (array_length(Combo) - 1 > 0) array_delete(Combo, array_length(Combo) - 1, 1);  ComboCTime = ComboTime; }












































