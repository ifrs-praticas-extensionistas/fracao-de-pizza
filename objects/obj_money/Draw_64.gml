font_enable_effects(font_money, true, {
    outlineEnable: true,
    outlineDistance: 10,
    outlineColour: c_black
});

draw_set_font(font_money);
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_colour(c_white);

moneytext = "R$"+string(money);
draw_text(display_get_gui_width(), 0, moneytext);
draw_text_outline(display_get_gui_width(), 0, moneytext, c_white, c_black, 1.5, 1);