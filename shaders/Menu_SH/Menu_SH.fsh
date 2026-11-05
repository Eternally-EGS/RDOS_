varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float u_intensity;
uniform float u_time;
uniform float u_mode; // Режим от 0 до 9

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

void main()
{
    vec2 uv = v_vTexcoord;
    vec2 pixel_res = vec2(240.0, 135.0);
    vec2 p_uv = floor(uv * pixel_res) / pixel_res;
    
    vec3 dark_green = vec3(0.18, 0.30, 0.25); // Цвет ёлок
    vec3 light_lime = vec3(0.96, 1.0, 0.78);  // Светлый блик
    vec3 pink_logo  = vec3(0.95, 0.32, 0.55); // Розовый акцент в цвет логотипа ROOS
    
    int mode = int(floor(u_mode + 0.5));
    
    // 0: Пиксельные солнечные лучи из центра (Sunburst)
    if (mode == 0) {
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        vec2 center = p_uv - vec2(0.5, 0.45);
        float angle = atan(center.y, center.x);
        float rays = step(0.0, sin(angle * 10.0 + u_time * 1.2));
        vec3 final_rgb = mix(base_col.rgb, light_lime, rays * u_intensity * 0.22);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
    // 1: Падающие пиксельные листья / конфетти
    else if (mode == 1) {
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        vec2 grid = p_uv * vec2(20.0, 11.0);
        grid.y -= u_time * 0.8;
        grid.x += sin(grid.y * 1.5 + u_time) * 0.4;
        vec2 id = floor(grid);
        vec2 pos = fract(grid) - 0.5;
        float leaf = step(0.65, hash(id)) * step(abs(pos.x), 0.14) * step(abs(pos.y), 0.08);
        vec3 final_rgb = mix(base_col.rgb, dark_green, leaf * u_intensity * 0.55);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
    // 2: Пиксельный телевизионный шум / статика (VHS)
    else if (mode == 2) {
        float glitch_line = step(0.92, hash(vec2(floor(p_uv.y * 40.0), floor(u_time * 12.0))));
        uv.x = clamp(uv.x + glitch_line * 0.02 * u_intensity, 0.002, 0.998);
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        float speck = step(0.85, hash(p_uv * 100.0 + fract(u_time * 15.0)));
        vec3 final_rgb = mix(base_col.rgb, light_lime, speck * u_intensity * 0.25);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
    // 3: Расходящиеся круги на воде
    else if (mode == 3) {
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        float dist = length(p_uv - vec2(0.5, 0.55));
        float ripple = step(0.65, sin(dist * 45.0 - u_time * 3.0));
        vec3 final_rgb = mix(base_col.rgb, dark_green, ripple * u_intensity * 0.2);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
    // 4: Пиксельные искры вверх
    else if (mode == 4) {
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        vec2 grid = p_uv * vec2(28.0, 16.0);
        grid.y += u_time * (1.2 + hash(vec2(floor(grid.x), 1.0)));
        vec2 id = floor(grid);
        vec2 pos = fract(grid) - 0.5;
        float spark = step(0.75, hash(id)) * step(max(abs(pos.x), abs(pos.y)), 0.12);
        vec3 final_rgb = mix(base_col.rgb, light_lime, spark * u_intensity * 0.6);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
    // --- НОВЫЕ РЕЖИМЫ (5 - 9) ---
    // 5: Цифровой дождь как в «Матрице» (в темно-зеленом цвете ёлок)
    else if (mode == 5) {
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        vec2 grid = p_uv * vec2(32.0, 18.0);
        float col_id = floor(grid.x);
        float speed = 2.0 + hash(vec2(col_id, 2.0)) * 3.0;
        float y_pos = fract(grid.y * 0.15 - u_time * speed * 0.15 + hash(vec2(col_id, 5.0)));
        float drop = smoothstep(0.4, 1.0, y_pos) * step(0.7, hash(floor(grid + vec2(0.0, floor(u_time * speed)))));
        vec3 final_rgb = mix(base_col.rgb, dark_green, drop * u_intensity * 0.5);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
    // 6: Хроматическая аберрация (RGB-сдвиг с розовым и зеленым шлейфом)
    else if (mode == 6) {
        float shift = sin(u_time * 3.0) * 0.008 * u_intensity;
        float r = texture2D(gm_BaseTexture, clamp(uv + vec2(shift, 0.0), 0.002, 0.998)).r;
        float g = texture2D(gm_BaseTexture, uv).g;
        float b = texture2D(gm_BaseTexture, clamp(uv - vec2(shift, 0.0), 0.002, 0.998)).b;
        gl_FragColor = vec4(r, g, b, 1.0);
    }
    // 7: Пульсирующие пиксельные плюсики (+)
    else if (mode == 7) {
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        vec2 grid = (p_uv + vec2(u_time * 0.05, -u_time * 0.05)) * vec2(14.0, 8.0);
        vec2 id = floor(grid);
        vec2 pos = abs(fract(grid) - 0.5);
        float pulse = step(0.3, sin(u_time * 3.0 + hash(id) * 10.0));
        float cross_shape = max(step(pos.x, 0.06) * step(pos.y, 0.22), step(pos.y, 0.06) * step(pos.x, 0.22));
        vec3 final_rgb = mix(base_col.rgb, pink_logo, cross_shape * pulse * u_intensity * 0.45);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
    // 8: Бегущие ретро-шевроны / стрелки (>>>) по горизонтали
    else if (mode == 8) {
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        float chevron = sin((p_uv.x - abs(p_uv.y - 0.5) * 1.4 - u_time * 0.25) * 40.0);
        float stripe = step(0.6, chevron);
        vec3 final_rgb = mix(base_col.rgb, light_lime, stripe * u_intensity * 0.25);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
    // 9: Мигающие пиксельные звезды (Twinkle)
    else {
        vec4 base_col = v_vColour * texture2D(gm_BaseTexture, uv);
        vec2 grid = p_uv * vec2(24.0, 14.0);
        vec2 id = floor(grid);
        vec2 pos = abs(fract(grid) - 0.5);
        float rnd = hash(id);
        float blink = sin(u_time * 4.0 + rnd * 20.0);
        float star = step(0.75, rnd) * step(0.5, blink) * step(pos.x + pos.y, 0.22);
        vec3 final_rgb = mix(base_col.rgb, light_lime, star * u_intensity * 0.75);
        gl_FragColor = vec4(final_rgb, base_col.a);
    }
}
