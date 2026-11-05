Debug = 0;
tim = 0;
period = 0.5;
PeriodC = 0;
LifeTime = 400;
randomize();

u_intensity_handle = shader_get_uniform(Menu_SH, "u_intensity");
u_time_handle = shader_get_uniform(Menu_SH, "u_time");
u_mode_handle = shader_get_uniform(Menu_SH, "u_mode");

shader_mode = irandom(4);
flash_amount = 0.0;