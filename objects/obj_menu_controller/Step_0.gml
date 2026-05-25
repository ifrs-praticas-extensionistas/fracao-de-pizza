if(!music_started)
{
    if(mouse_check_button_pressed(mb_left))
    {
        global.musica_menu =
        audio_play_sound(mus_menu, 1, true);

        audio_master_gain(global.volume);

        music_started = true;
    }
}