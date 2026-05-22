font_enable_effects(font_money, true, {
    outlineEnable: true,
    outlineDistance: 10,
    outlineColour: c_black
});

draw_set_font(font_money);
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_colour(c_white);

moneytext = "R$ " + string_format(money, 0, 2);

var draw_x = display_get_gui_width();
var draw_y = 0;

if (shake > 0) {
    draw_x += random_range(-shake, shake);
    draw_y += random_range(-shake, shake);
}

draw_text(draw_x, draw_y, moneytext);
draw_text_outline(draw_x, draw_y, moneytext, c_white, c_black, 1.5, 1);