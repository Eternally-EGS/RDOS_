
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
		perk1Type = irandom(8);
		perk2Type = irandom(8);
		if (perk1Type == perk2Type) { perk2Type = irandom(8); } 
		ShowPerk()
    }
} 

function ShowPerk () {
	switch (perk1Type) {
		case 0: Player_O.MaxBulletCounte += 1			                    perk1Text = "+1 Projectile"; perk1Ico = 0; break;	
		case 1: Player_O.MaxBulletCounte += 2			                    perk1Text = "+2 Projectile"; perk1Ico = 0; break;	
		case 2: Player_O.Max_Speed += Player_O.Max_Speed * 0.05;			perk1Text = "+5% Movement Speed"; perk1Ico = 1; break;
		case 3: Player_O.MaxHP += Player_O.MaxHP * 0.15;					perk1Text = "+15% Bonus HP"; perk1Ico = 1; break;
		case 4: Player_O.Damage += Player_O.Damage * 0.30;					perk1Text = "+30% Extra Damage"; perk1Ico = 1; break;
		case 5: Player_O.DeadMaxDelay += Player_O.DeadMaxDelay * 0.10;      perk1Text = "+10% Projectile Range"; perk1Ico = 1; break;
		case 6: Player_O.BoomPerk = 1										perk1Text = "Combo = Bob!"; perk1Ico = 2; break;
		case 7: Player_O.FierPerk = 1										perk1Text = "Burn their house down!"; perk1Ico = 2; break;
		case 8: Player_O.RegenPerk = 1										perk1Text = "Solar panel!"; perk1Ico = 2; break;
	}

	switch (perk2Type) {
		case 0: Player_O.MaxBulletCounte += 1			                    perk2Text = "+1 Projectile"; perk2Ico = 0; break;	
		case 1: Player_O.MaxBulletCounte += 2			                    perk2Text = "+2 Projectile"; perk2Ico = 0; break;	
		case 2: Player_O.Max_Speed += Player_O.Max_Speed * 0.05;			perk2Text = "+5% Movement Speed"; perk2Ico = 1; break;
		case 3: Player_O.MaxHP += Player_O.MaxHP * 0.15;					perk2Text = "+15% Bonus HP"; perk2Ico = 1; break;
		case 4: Player_O.Damage += Player_O.Damage * 0.30;					perk2Text = "+30% Extra Damage"; perk2Ico = 1; break;
		case 5: Player_O.DeadMaxDelay += Player_O.DeadMaxDelay * 0.10;      perk2Text = "+10% Projectile Range"; perk2Ico = 1; break;
		case 6: Player_O.BoomPerk = 1										perk2Text = "Combo = Bob!"; perk2Ico = 2; break;
		case 7: Player_O.FierPerk = 1										perk2Text = "Burn their house down!"; perk2Ico = 2; break;
		case 8: Player_O.RegenPerk = 1										perk2Text = "Solar panel!"; perk2Ico = 2; break;
	}
}















