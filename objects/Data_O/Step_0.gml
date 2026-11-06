
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

if (vaweTimeOut <= 0 && VaweStatus == 0) {  
	SpawnEnemy();
	vaweTimeOut = -1;
	VaweStatus = 1;
}

if (VaweStatus == 1 && instance_number(EnemyBase_O) == 0) {
	wave_timer += 1;
	
    if (wave_timer >= wave_delay) {
		
		vaweTimeOut = vaweTimeOutM;
		
		vawe ++;
		
		if (instance_exists(Player_O)) { Player_O.CurrentHP = Player_O.MaxHP }
		
		if (enemies_per_wave < 10) { enemies_per_wave ++; } else { enemies_per_wave = enemies_per_wave * 0.5 }
       
	   wave_timer = 0;
	
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
	
		PerkHUDDelayC = 1
		VaweStatus = 0;
		
	}
}

if (PerkHUDDelayC > 0 && PerkHUDDelayC < PerkHUDDelay) { PerkHUDDelayC += 1 / fps  }

if ( PerkHUDDelayC >= PerkHUDDelay ) { 
ShowPerk();
Wave_perk = 1;
PerkHUDDelayC = 0
 }


if (vaweTimeOut > 0) {vaweTimeOut -= 1 / fps }

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
	Player_O.ShotBlock = 5;
	

        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);

        var x1 = BX - DropX - 200;
        var y1 = BY + DropY - 350 - 30;
        var l1 = x1 - sprite_get_xoffset(PerkIcon_S) * 5;
        var t1 = y1 - sprite_get_yoffset(PerkIcon_S) * 5;
        var r1 = l1 + sprite_get_width(PerkIcon_S) * 5;
        var b1 = t1 + sprite_get_height(PerkIcon_S) * 5;

        if (point_in_rectangle(mx, my, l1, t1, r1, b1)) {
			
			SetCursor();
			
            if (mouse_check_button_pressed(mb_left)) {
				perk2Type = -1;
				Wave_perk = 0;
				SetPerk();
			}
        }

        var x2 = BX - DropX + 200;
        var y2 = BY + DropY - 350 - 30;
        var l2 = x2 - sprite_get_xoffset(PerkIcon_S) * 5;
        var t2 = y2 - sprite_get_yoffset(PerkIcon_S) * 5;
        var r2 = l2 + sprite_get_width(PerkIcon_S) * 5;
        var b2 = t2 + sprite_get_height(PerkIcon_S) * 5;

        if (point_in_rectangle(mx, my, l2, t2, r2, b2)) {
			
			SetCursor();
			
            if (mouse_check_button_pressed(mb_left)) {
				perk1Type = -1;
				Wave_perk = 0;
				SetPerk();
			}
        }
    
}




function SetPerk () {
	if (instance_exists(Player_O)) {
	// Perk Type
	switch (perk1Type) {
		case 0: Player_O.MaxBulletCounte += 1			                    break;	
		case 1: Player_O.MaxBulletCounte += 2			                    break;	
		case 2: Player_O.Max_Speed += clamp(Player_O.Max_Speed * 0.03,4,9);			break;
		case 3: Player_O.MaxHP += Player_O.MaxHP * 0.15; Player_O.CurrentHP = Player_O.MaxHP;	 break;
		case 4: Player_O.Damage += Player_O.Damage * 0.30;					 break;
		case 5: Player_O.DeadMaxDelay += Player_O.DeadMaxDelay * 0.10;      break;
		case 6: Player_O.BoomPerk = 1										break;
		case 7: Player_O.FierPerk = 1										 break;
		case 8: Player_O.RegenPerk = 1										 break;
	}

	switch (perk2Type) {
		case 0: Player_O.MaxBulletCounte += 1			                   break;	
		case 1: Player_O.MaxBulletCounte += 2			                    break;	
		case 2: Player_O.Max_Speed += Player_O.Max_Speed * 0.03			 break;
		case 3: Player_O.MaxHP += Player_O.MaxHP * 0.15; Player_O.CurrentHP = Player_O.MaxHP;	 break;
		case 4: Player_O.Damage += Player_O.Damage * 0.30;				 break;
		case 5: Player_O.DeadMaxDelay += Player_O.DeadMaxDelay * 0.10;     break;
		case 6: Player_O.BoomPerk = 1										 break;
		case 7: Player_O.FierPerk = 1										 break;
		case 8: Player_O.RegenPerk = 1									 break;
	}

	Player_O.BaseStats();
	}
}

function SpawnEnemy() {
	if (vawe > 0){
		if instance_exists(Player_O){
			Player_O.MaxHP += Player_O.MaxHP * 0.10
			Player_O.CurrentHP = Player_O.MaxHP
			Player_O.Damage += Player_O.Damage * 0.10
			
			Player_O.Max_Speed += Player_O.Max_Speed * 0.08
		}
	}
	
  for (var i = 0; i < enemies_per_wave; i++) {
        var _sx = 0;
        var _sy = 0;
        var _tries = 0;

        do {
           var _cam = view_camera[0];
			var _cx = camera_get_view_x(_cam);
			var _cy = camera_get_view_y(_cam);
			var _cw = camera_get_view_width(_cam);
			var _ch = camera_get_view_height(_cam);

			var _margin = 64;
			var _sx = 0;
			var _sy = 0;

			var _side = irandom(3);

			switch (_side) {
			    case 0: 
			        _sx = irandom_range(_cx - _margin, _cx + _cw + _margin);
			        _sy = _cy - _margin;
			        break;
			    case 1: 
			        _sx = irandom_range(_cx - _margin, _cx + _cw + _margin);
			        _sy = _cy + _ch + _margin;
			        break;
			    case 2: 
			        _sx = _cx - _margin;
			        _sy = irandom_range(_cy - _margin, _cy + _ch + _margin);
			        break;
			    case 3:
			        _sx = _cx + _cw + _margin;
			        _sy = irandom_range(_cy - _margin, _cy + _ch + _margin);
			        break;
			}

			_sx = clamp(_sx, 120, room_width - 120);
			_sy = clamp(_sy, 420, room_height - 420);
            _tries += 1;
        } until (
            (!place_meeting(_sx, _sy, AllWall_O) && 
            (!instance_exists(Player_O) || point_distance(_sx, _sy, Player_O.x, Player_O.y) > 200)) 
            || _tries > 50
        );



        var _enemy = instance_create_depth(_sx, _sy, 0, EnemyBase_O);
		_enemy.MaxHP     = 3 * power(1.15, vawe)  
        _enemy.CurrentHP = _enemy.MaxHP;
        _enemy.Damage    = 1 * power(1.15, vawe)
		
        _enemy.Speed     +=_enemy.Speed * (0.02 * vawe)
		_enemy.Speed = clamp(_enemy.Speed, 1, 4)
    }
}



function SetCursor() {
	CursorUse = 1;
	window_set_cursor(cr_handpoint);
} 
		var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
		var x2 = BX - DropX - 500;
        var y2 = BY + DropY;
        var l2 = x2 - sprite_get_xoffset(InMenu_S) * 4;
        var t2 = y2 - sprite_get_yoffset(InMenu_S) * 4;
        var r2 = l2 + sprite_get_width(InMenu_S) * 4;
        var b2 = t2 + sprite_get_height(InMenu_S) * 4;

        if (point_in_rectangle(mx, my, l2, t2, r2, b2)) {
			SetCursor();
			if (mouse_check_button_pressed(mb_left)) { window_set_cursor(cr_default); room_goto(Main_Menu) }
			inMenuF = 1;
		} else { inMenuF = 0; }


if (!instance_exists(Player_O) && keyboard_check_pressed(ord("R"))) { room_restart(); }





