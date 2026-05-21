hover =
point_in_rectangle(
    device_mouse_x_to_gui(0),
    device_mouse_y_to_gui(0),
    x - string_width(texto)/2,
    y - string_height(texto)/2,
    x + string_width(texto)/2,
    y + string_height(texto)/2
);

if(hover && mouse_check_button_pressed(mb_left))
{
    switch(acao)
    {
        case 0:
            room_goto(SandboxPizza);
        break;

        case 1:
          with(obj_btn){
			instance_destroy();
}

			instance_create_layer(0,0,"GUI",obj_menu_config);
        break;

        case 2:
            game_end();
        break;

        case 3:
            global.music_on = !global.music_on;

            if(global.music_on)
            {
                audio_resume_all();
            }
            else
            {
                audio_pause_all();
            }
        break;

        case 4:
            global.volume += 0.1;

            if(global.volume > 1)
            {
                global.volume = 1;
            }

            audio_master_gain(global.volume);
        break;

        case 5:
            global.volume -= 0.1;

            if(global.volume < 0)
            {
                global.volume = 0;
            }
 
            audio_master_gain(global.volume);
        break;

        case 6:
           with(obj_btn)
    {
        instance_destroy();
    }

		instance_create_layer(0,0,"GUI",obj_menu_main);
        break;
    }
}