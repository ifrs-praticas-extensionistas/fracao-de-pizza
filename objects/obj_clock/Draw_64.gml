draw_set_font(font_clock);
text_color = c_red;

total_sec = floor(time_left);
minutes = total_sec div 60;
secconds = total_sec mod 60;

// formatação 00:00
text = string_format(minutes, 2, 0) + ":" + string_format(secconds, 2, 0);

draw_text(0, 20, text);
draw_text_color(200, 200, text, text_color, text_color, text_color, text_color, 1)