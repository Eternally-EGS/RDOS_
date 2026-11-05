new Draw_HP_Bar(CurrentHP, MaxHP, x, y - 50, 3,3).Draw();


// Hit
if (Hit == 1) { 
	CFlash += FlashSpeed;
	if (CFlash > MaxFlashTime) { CFlash = 0 }
	if (CFlash <= 0) {
	gpu_set_fog(true, c_white, 0, 0);
	} else {
	gpu_set_fog(false, c_white, 0, 0);
	}
	if HitCDelay > 0 { HitCDelay -= 1 / fps }
} 

draw_self();

gpu_set_fog(false, c_white, 0, 0);