if(!music_started)
{
    if(mouse_check_button_pressed(mb_left))
    {
        musica_menu = audio_play_sound(mus_menu, 1, true);

        music_started = true;
    }
}