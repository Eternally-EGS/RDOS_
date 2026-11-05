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
    if (Player_O.buff_megadash_timer > 0) Value1 += "MEGA DASH: " + string_format(Player_O.buff_megadash_timer / _fps, 1, 1) + "s\n";
    if (Player_O.buff_regen_timer > 0)    Value1 += "REGEN: "     + string_format(Player_O.buff_regen_timer / _fps, 1, 1) + "s\n";
    if (Player_O.buff_pierce_timer > 0)   Value1 += "PIERCE: "    + string_format(Player_O.buff_pierce_timer / _fps, 1, 1) + "s\n";
    if (Player_O.buff_giant_timer > 0)    Value1 += "GIANT SHOT: "+ string_format(Player_O.buff_giant_timer / _fps, 1, 1) + "s\n";
    if (Player_O.buff_god_timer > 0)      Value1 += "OVERDRIVE: " + string_format(Player_O.buff_god_timer / _fps, 1, 1) + "s\n";
    if (Player_O.buff_freeze_timer > 0)   Value1 += "FREEZE: "    + string_format(Player_O.buff_freeze_timer / _fps, 1, 1) + "s\n";
    if (Player_O.buff_inf_timer > 0)      Value1 += "INF AMMO: "  + string_format(Player_O.buff_inf_timer / _fps, 1, 1) + "s\n";
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

	
	if (mouse_check_button_pressed(mb_left)) {
		
    var half_w = (sprite_get_width(PerkIcon_S) * 5) / 2;
    var half_h = (sprite_get_height(PerkIcon_S) * 5) / 2;

    var x1 = BX - DropX - 200;
    var y1 = BY + DropY - perkAnim - 30;

    if (point_in_rectangle(mouse_x, mouse_y, x1 - half_w, y1 - half_h, x1 + half_w, y1 + half_h)) {
       StartWave();
	   perk2Type = -1;
    }

    var x2 = BX - DropX + 200;
    var y2 = BY + DropY - perkAnim - 30;

    if (point_in_rectangle(mouse_x, mouse_y, x2 - half_w, y2 - half_h, x2 + half_w, y2 + half_h)) {
        perk1Type = -1;
		StartWave();
    }
}
	
} else { perkAnim = 1000; }




function StartWave () {

	// Perk Type
	switch (perk1Type) {
		case 0: Player_O.MaxBulletCounte += 1			                    break;	
		case 1: Player_O.MaxBulletCounte += 2			                    break;	
		case 2: Player_O.Max_Speed += Player_O.Max_Speed * 0.05;			break;
		case 3: Player_O.MaxHP += Player_O.MaxHP * 0.15;				 break;
		case 4: Player_O.Damage += Player_O.Damage * 0.30;					 break;
		case 5: Player_O.DeadMaxDelay += Player_O.DeadMaxDelay * 0.10;      break;
		case 6: Player_O.BoomPerk = 1										break;
		case 7: Player_O.FierPerk = 1										 break;
		case 8: Player_O.RegenPerk = 1										 break;
	}

	switch (perk2Type) {
		case 0: Player_O.MaxBulletCounte += 1			                   break;	
		case 1: Player_O.MaxBulletCounte += 2			                    break;	
		case 2: Player_O.Max_Speed += Player_O.Max_Speed * 0.05;			 break;
		case 3: Player_O.MaxHP += Player_O.MaxHP * 0.15;					 break;
		case 4: Player_O.Damage += Player_O.Damage * 0.30;				 break;
		case 5: Player_O.DeadMaxDelay += Player_O.DeadMaxDelay * 0.10;     break;
		case 6: Player_O.BoomPerk = 1										 break;
		case 7: Player_O.FierPerk = 1										 break;
		case 8: Player_O.RegenPerk = 1									 break;
	}
	
	Wave_perk = 0
	perkSpawn = 0
	perk1Type = -1;
	perk2Type = -1;	
	SpawnEnemy();
}

draw_text(500,500,Wave_perk)





































