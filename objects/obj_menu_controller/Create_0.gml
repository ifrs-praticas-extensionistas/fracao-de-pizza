instance_create_layer(0, 0, "Instances", obj_cursor_pizza);

global.game_paused = true;

if (mouse_check_button_pressed(mb_left))
{
    audio_play_sound(mus_menu, 1, true);
}  