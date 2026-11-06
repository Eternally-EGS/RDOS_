// HUD
var _x = camera_get_view_width(view_camera[0]) / 2
var _y = camera_get_view_height(view_camera[0]) / 2
var scale = 2.855

var _gui_h = display_get_gui_height();
var _player_screen_y = camera_get_view_y(view_camera[0]);
if (instance_exists(Player_O)) {
 _player_screen_y = Player_O.y - camera_get_view_y(view_camera[0]);
}
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
var hp_percentage = 0;
if (instance_exists(Player_O)) {
hp_percentage = clamp(Player_O.CurrentHP / Player_O.MaxHP, 0, 1);
}
var current_hp_width = 3 * hp_percentage;

HUDVal = current_hp_width;

draw_sprite_ext(HUDHPV_S,0,BX - DropX - 276,BY + DropY,HUDVal,3,0,c_white,HUDalpha)

if (instance_exists(Player_O)) {
if (Player_O.CurrentHP == Player_O.MaxHP) {
HUDCAnim += HUDAnimSpeed;
draw_sprite_ext(HUDHPAnim_S,HUDCAnim,BX - DropX - 276,BY + DropY,HUDVal,3,0,c_white,HUDalpha)
} }

// ruler
draw_sprite_ext(HUDRuler_S,0,BX - DropX + 540,BY + DropY,4,4,0,c_white,HUDalpha)
var FValue = 0;
var Value = 0;
if (instance_exists(Player_O)) {
Value = Player_O.MaxBulletCounte - instance_number(Bullet_O);
FValue = clamp(Value,0,999)
}

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
	draw_set_font(Base_F_very_Small)
    draw_text_colour(BX - DropX + 300, BY + DropY - 10, Value1, c_white, c_white, c_white, c_white, HUDalpha);
	draw_set_font(-1);
}

draw_set_font(Base_F)

draw_text_colour(BX - DropX + 560,BY + DropY - 10, FValue,c_white,c_white,c_white,c_white,HUDalpha)
var TimeC = "";

if (instance_exists(Player_O)) {
if (vaweTimeOut<= 0) {
	TimeC = "GO" 
} else { TimeC = vaweTimeOut } 
} else { TimeC = @"
You Died :/
R to restart" }

var finelText = $"vawe:{vawe}"

draw_text_colour(BX - DropX - string_width(finelText) / 2,BY + DropY - 660, finelText,c_white,c_white,c_white,c_white,HUDalpha)
draw_text_colour(BX - DropX - string_width(TimeC) / 2,BY + DropY - 630, TimeC,c_white,c_white,c_white,c_white,HUDalpha)

draw_set_font(-1);

if (Wave_perk == 1) {
	
	var Maxy = 3;
	if (perkAnim < Maxy) { perkAnim += 0.3 }
	var Maxy0 = 5;
	if (perkAnim0 < Maxy0) { perkAnim0 += 0.3 }
	draw_sprite_ext(PerkHUD_S,0,BX - DropX,BY + DropY - 350,perkAnim,perkAnim,0,c_white,HUDalpha)
	draw_sprite_ext(PerkIcon_S,perk1Ico,BX - DropX - 200,BY + DropY - 350 - 30,perkAnim0,perkAnim0,0,c_white,HUDalpha)
	draw_sprite_ext(PerkIcon_S,perk2Ico,BX - DropX + 200,BY + DropY - 350 - 30,perkAnim0,perkAnim0,0,c_white,HUDalpha)
	draw_set_font(Base_F_Small)
	draw_text_colour((BX - DropX - 200) - string_width(perk1Text) / 2 ,BY + DropY - 320 + 80, perk1Text,c_white,c_white,c_white,c_white,HUDalpha)
	draw_text_colour((BX - DropX + 200) - string_width(perk2Text) / 2,BY + DropY - 320 + 80, perk2Text,c_white,c_white,c_white,c_white,HUDalpha)
	draw_set_font(-1)
} else { perkAnim = 0; }


var _combo_text = string_join_ext("\n", Combo);

draw_set_font(Base_F_Small)

//draw_text_ext_colour(100, 650, Wave_perk, -1, 10000, c_white, c_white, c_white, c_white, HUDalpha);

draw_set_font(-1)

if (ComboCTime > 0) { ComboCTime -= 1 / fps } else { if (array_length(Combo) - 1 > 0) array_delete(Combo, array_length(Combo) - 1, 1);  ComboCTime = ComboTime; }


if (mouse_check_button_pressed(mb_middle)) { instance_create_depth(mouse_x,mouse_y,0,Fier_O); Player_O.RegenPerk = 1 }

draw_sprite_ext(InMenu_S,inMenuF,BX - DropX - 500,BY + DropY,4,4,0,c_white,HUDalpha)





























