
// Camera system
if (instance_exists(Player_O)) {
    var Camera = view_camera[0];
    
    camera_set_view_size(Camera, CameraW, CameraH);
    
    var Dirx = Player_O.Directionx; 
    var Diry = Player_O.Directiony; 
    
    var PX = Player_O.x - CameraW / 2;
    var PY = Player_O.y - CameraH / 2;

    CameraX = PX + (Dirx * CameraBorder);
    CameraY = PY + (Diry * CameraBorder);

    CameraXC = lerp(CameraXC, CameraX, CameraSpeed);
    CameraYC = lerp(CameraYC, CameraY, CameraSpeed);

    CameraXC = clamp(CameraXC, 0, room_width - CameraW);
    CameraYC = clamp(CameraYC, 0, room_height - CameraH);

    camera_set_view_pos(Camera, CameraXC, CameraYC);
}


// Hud
HUDIconCAnimTime += 1 /fps

if (HUDIconCAnimTime >= HUDIconAnimTime) {
	HUDIconCAnimTime = 0;
	HUDIconAnim = 1;
}

if (HUDIconAnim == 1) {
	HUDIconCAnimTime0 += 1 / fps
	if (HUDIconCAnimTime0 >= HUDIconAnimTime0) { HUDIconAnim = 0 HUDIconCAnimTime0 = 0 } 

	hud_scale_timer += 0.05; 
	var _base_scale = 3;  
	var _amplitude = 0.2; 
	HUDIconscale = _base_scale + sin(hud_scale_timer) * _amplitude;
}

// vawe

if (instance_number(EnemyBase_O) == 0 && Wave_perk == 0) {
    wave_timer += 1;
    if (wave_timer >= wave_delay) {
        wave_timer = 0;
        StartNextWave();
        Wave_perk = 1;
        perkSpawn = 1;

        var _weights = [30,15,45,55,45,65,10,10,10];
        var _total = 285; 

        var _rnd = irandom_range(1, _total);
        var _sum = 0;
        for (var i = 0; i < 9; i++) {
            _sum += _weights[i];
            if (_rnd <= _sum) {
                perk1Type = i;
                break;
            }
        }

        do {
            var _rnd1 = irandom_range(1, _total);
            _sum = 0;
            for (var i = 0; i < 9; i++) {
                _sum += _weights[i];
                if (_rnd1 <= _sum) {
                    perk2Type = i;
                    break;
                }
            }
        } until (perk2Type != perk1Type);

        ShowPerk();
    }
}


function ShowPerk () {
	switch (perk1Type) {
		case 0: 		                    perk1Text = "+1 Projectile"; perk1Ico = 0; break;	
		case 1: 	                    perk1Text = "+2 Projectile"; perk1Ico = 0; break;	
		case 2: 			perk1Text = "+5% Movement Speed"; perk1Ico = 1; break;
		case 3: 					perk1Text = "+15% Bonus HP"; perk1Ico = 1; break;
		case 4: 				perk1Text = "+30% Extra Damage"; perk1Ico = 1; break;
		case 5:     perk1Text = "+10% Projectile Range"; perk1Ico = 1; break;
		case 6:									perk1Text = "Combo = Bob!"; perk1Ico = 2; break;
		case 7:									perk1Text = "Burn their house down!"; perk1Ico = 2; break;
		case 8: 									perk1Text = "Solar panel!"; perk1Ico = 2; break;
	}

	switch (perk2Type) {
		case 0: 		                    perk2Text = "+1 Projectile"; perk2Ico = 0; break;	
		case 1: 		                    perk2Text = "+2 Projectile"; perk2Ico = 0; break;	
		case 2: 		perk2Text = "+5% Movement Speed"; perk2Ico = 1; break;
		case 3: 					perk2Text = "+15% Bonus HP"; perk2Ico = 1; break;
		case 4: 				perk2Text = "+30% Extra Damage"; perk2Ico = 1; break;
		case 5:     perk2Text = "+10% Projectile Range"; perk2Ico = 1; break;
		case 6: 									perk2Text = "Combo = Bob!"; perk2Ico = 2; break;
		case 7:									perk2Text = "Burn their house down!"; perk2Ico = 2; break;
		case 8: 									perk2Text = "Solar panel!"; perk2Ico = 2; break;
	}
}

var _x = camera_get_view_width(view_camera[0]) / 2
var _y = camera_get_view_height(view_camera[0]) / 2
var scale = 2.855

var BX = _x + 44;
var BY = _y + 23;

var DropX = 0;
var DropY = 320;


if (Wave_perk == 1) {
	if (instance_exists(Player_O)) then
	Player_O.ShotBlock = 1;
	
    if (mouse_check_button_pressed(mb_left)) {
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);

        var x1 = BX - DropX - 200;
        var y1 = BY + DropY - 350 - 30;
        var l1 = x1 - sprite_get_xoffset(PerkIcon_S) * 5;
        var t1 = y1 - sprite_get_yoffset(PerkIcon_S) * 5;
        var r1 = l1 + sprite_get_width(PerkIcon_S) * 5;
        var b1 = t1 + sprite_get_height(PerkIcon_S) * 5;

        if (point_in_rectangle(mx, my, l1, t1, r1, b1)) {
            perk2Type = -1;
			StartWave();
        }

        var x2 = BX - DropX + 200;
        var y2 = BY + DropY - 350 - 30;
        var l2 = x2 - sprite_get_xoffset(PerkIcon_S) * 5;
        var t2 = y2 - sprite_get_yoffset(PerkIcon_S) * 5;
        var r2 = l2 + sprite_get_width(PerkIcon_S) * 5;
        var b2 = t2 + sprite_get_height(PerkIcon_S) * 5;

        if (point_in_rectangle(mx, my, l2, t2, r2, b2)) {
            perk1Type = -1;
            StartWave();
        }
    }
}


function StartWave () {

	// Perk Type
	switch (perk1Type) {
		case 0: Player_O.MaxBulletCounte += 1			                    break;	
		case 1: Player_O.MaxBulletCounte += 2			                    break;	
		case 2: Player_O.Max_Speed += Player_O.Max_Speed * 0.15;			break;
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
		case 2: Player_O.Max_Speed += Player_O.Max_Speed * 0.15;			 break;
		case 3: Player_O.MaxHP += Player_O.MaxHP * 0.15;					 break;
		case 4: Player_O.Damage += Player_O.Damage * 0.30;				 break;
		case 5: Player_O.DeadMaxDelay += Player_O.DeadMaxDelay * 0.10;     break;
		case 6: Player_O.BoomPerk = 1										 break;
		case 7: Player_O.FierPerk = 1										 break;
		case 8: Player_O.RegenPerk = 1									 break;
	}
	
	Wave_perk = 0
	perkSpawn = 0
	SpawnEnemy();
	Player_O.BaseStats();
	if (instance_exists(Player_O)) then
		Player_O.ShotBlock = 0;
}








