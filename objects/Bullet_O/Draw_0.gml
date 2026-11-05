function DrawGrade() {
    if (grade_alpha <= 0) return;

    if (grade_scale < 1.5) {
        grade_scale += 0.05;
    } else {
        grade_alpha -= 0.04;
    }

    draw_set_alpha(grade_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
	draw_set_font(Base_F);

    draw_text_transformed(grade_x, grade_y, grade_text, grade_scale, grade_scale, 0);

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
	draw_set_font(-1);
}

draw_self();
DrawGrade(); 