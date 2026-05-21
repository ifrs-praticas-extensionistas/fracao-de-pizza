draw_set_font(fonte);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// centro tela
var x1 = display_get_gui_width() / 2;
var y1 = display_get_gui_height() / 2 - 80;

// mouse
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);


/// MENU PRINCIPAL
if(menu == "main")
{
    for(var i = 0; i < op_main_max; i++)
    {
        var yy = y1 + (i * dist);

        var txt = opcoes_main[i];

        var tw = string_width(txt);
        var th = string_height(txt);

        var hover =
        mx > x1 - tw/2 &&
        mx < x1 + tw/2 &&
        my > yy - th/2 &&
        my < yy + th/2;

        // cor
        if(hover)
        {
            draw_set_color(c_orange);
        }
        else
        {
            draw_set_color(c_white);
        }

        // desenha
        draw_text(x1, yy, txt);

        // clique
        if(hover && mouse_check_button_pressed(mb_left))
        {
            switch(i)
            {
                case 0:
                    room_goto(SandboxPizza);
                break;

                case 1:
                    menu = "config";
                break;

                case 2:
                    game_end();
                break;
            }
        }
    }
}


/// MENU CONFIG
if(menu == "config")
{
    draw_set_color(c_white);

    draw_text(x1, y1, "Musica: " + string(global.music_on));

    draw_text(x1, y1 + dist, "Volume: " + string(round(global.volume * 100)));

    draw_text(x1, y1 + dist * 2, "Voltar");

    // hover voltar
    var yy = y1 + dist * 2;

    var txt = "Voltar";

    var tw = string_width(txt);
    var th = string_height(txt);

    var hover =
    mx > x1 - tw/2 &&
    mx < x1 + tw/2 &&
    my > yy - th/2 &&
    my < yy + th/2;

    if(hover)
    {
        draw_set_color(c_orange);

        draw_text(x1, yy, txt);

        if(mouse_check_button_pressed(mb_left))
        {
            menu = "main";
        }
    }
}