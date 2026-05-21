draw_set_font(fonte_menu);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if(hover)
{
    draw_set_color(c_orange);
}
else
{
    draw_set_color(c_white);
}

draw_text(x,y,texto);