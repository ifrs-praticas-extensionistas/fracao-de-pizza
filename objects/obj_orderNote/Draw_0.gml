var _m = matrix_get(matrix_world);
matrix_set(matrix_world, matrix_build(x, y, 0, 0, 0, rot, 1, 1, 1));

var progresso = (tempo_total > 0) ? (tempo_restante / tempo_total) : 0;

// Cor do flash sobreposta ao sprite
var _blend = c_white;
if (flash_timer > 0) {
    // Pisca alternando entre branco e verde
    _blend = (flash_timer mod 4 < 2) ? c_lime : c_white;
} else if (caindo && falhado) {
    _blend = c_red;
}

draw_sprite_stretched_ext(background_sticker, 0, -50, -50, 100, 100, _blend, alpha);

// Fração
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_fracao);
draw_text(0, -20, string(numerador));
draw_line_width(-18, -2, 18, -2, 2);
draw_text(0, 14, string(denominador));

// Timer circular
var cx   = 0;
var cy   = 58;
var raio = 14;

var cor_timer;
if (progresso > 0.5)
    cor_timer = merge_colour(c_yellow, c_lime, (progresso - 0.5) * 2);
else if (progresso > 0.25)
    cor_timer = merge_colour(c_red, c_yellow, (progresso - 0.25) * 4);
else
    cor_timer = c_red;

draw_set_color(c_ltgray);
draw_set_alpha(alpha * 0.6);
draw_circle(cx, cy, raio, false);

draw_set_alpha(alpha);
draw_set_color(cor_timer);
var passos = 48;
for (var i = 0; i < passos; i++) {
    var ang1 = 90 - (i / passos) * 360 * progresso;
    var ang2 = 90 - ((i + 1) / passos) * 360 * progresso;
    draw_triangle(
        cx, cy,
        cx + dcos(ang1) * raio, cy - dsin(ang1) * raio,
        cx + dcos(ang2) * raio, cy - dsin(ang2) * raio,
        false
    );
}

draw_set_color(c_white);
draw_circle(cx, cy, raio * 0.58, false);

draw_set_color(cor_timer);
draw_set_alpha(alpha);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(cx, cy, string(ceil(tempo_restante)));

draw_set_alpha(1);
matrix_set(matrix_world, _m);