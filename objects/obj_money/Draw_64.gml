draw_set_font(font_money);
draw_set_halign(fa_right);
draw_set_valign(fa_top);

moneytext = "R$"+string(money);
draw_set_color(c_white);
draw_text(display_get_gui_width(), 0, moneytext);