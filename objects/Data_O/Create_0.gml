randomise();

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

vawe = 1;                
enemies_per_wave = 1;  
wave_delay = 120;     
wave_timer = 0;
Wave_perk = 0;

perkAnim = 0;
perkAnim0 = 0;
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

vaweTimeOutM = 5;
VaweStart = 0;

VaweStatus = 0;

vaweTimeOut = 5;

CursorUse = 0;

inMenuF = 0;

PerkHUDDelay = vaweTimeOutM / 3;
PerkHUDDelayC = 0;


/*

function StartNextWave() {
	
    vawe += 1;

    if (vawe > 1 && instance_exists(Player_O)) {
		Player_O.CurrentHP = Player_O.MaxHP;
		if (enemies_per_wave < 10) { enemies_per_wave ++; } else { enemies_per_wave = enemies_per_wave * 2 }
    }
	
}

StartNextWave();

*/
