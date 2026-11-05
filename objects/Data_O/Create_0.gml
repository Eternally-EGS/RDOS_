

CameraXC = 0;
CameraYC = 0;
CameraX = 0;
CameraY = 0;
CameraBorder = 40;
CameraW = 320*4; // 1280
CameraH = 180*4; // 720
HUDalpha = 0;
HUDIconscale = 3;
HUDVal = 3;

HUDAnimSpeed = 0.2;
HUDCAnim = 0;

HUDIconAnimTime = 10;
HUDIconCAnimTime = 0;

HUDIconAnimTime0 = 3;
HUDIconCAnimTime0 = 0;
HUDIconAnim = 0;
hud_scale_timer = 0;

CameraSpeed = 0.04;

vawe = 0;                
enemies_per_wave = 10;  
wave_delay = 120;     
wave_timer = 0;
Wave_perk = 0;

perkAnim = 1000;
perkSpawn = 0;

perk1 = 0;
perk2 = 0;

perk1Ico = 0;
perk2Ico = 0;

perk1Type = -1;
perk2Type = -1;

perk1Text = 0;
perk2Text = 0;

PerkClick = 0;

Combo = [];
ComboTime = 1;
ComboCTime = 2;

function SpawnEnemy() {
  for (var i = 0; i < enemies_per_wave; i++) {
        var _sx = 0;
        var _sy = 0;
        var _tries = 0;

        do {
            _sx = irandom_range(120, room_width - 120);
            _sy = irandom_range(420, room_height - 420);
            _tries += 1;
        } until (
            (!place_meeting(_sx, _sy, AllWall_O) && 
            (!instance_exists(Player_O) || point_distance(_sx, _sy, Player_O.x, Player_O.y) > 200)) 
            || _tries > 50
        );

        var _enemy = instance_create_depth(_sx, _sy, 0, EnemyBase_O);
        var _bonus_lvl = vawe - 1;
        _enemy.MaxHP     += _bonus_lvl * 2;   
        _enemy.CurrentHP  = _enemy.MaxHP;
        _enemy.Speed     += _bonus_lvl * 0.25; 
        _enemy.Damage    += floor(_bonus_lvl / 2);
    }
}
SpawnEnemy();

function StartNextWave() {
	
    vawe += 1;

    if (vawe > 1 && instance_exists(Player_O)) {
        Player_O.BaseBulletCount += 1;
		Player_O.CurrentHP = Player_O.MaxHP;
    }
	
}

StartNextWave();

