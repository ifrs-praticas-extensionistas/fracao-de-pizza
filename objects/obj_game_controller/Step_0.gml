if (global.game_state != GAME_STATE.PLAYING)
{
    exit;
}

if (keyboard_check_pressed(vk_space))
{
    if (global.game_state == GAME_STATE.PLAYING)
    {
        global.game_state = GAME_STATE.PAUSED;

        if (!instance_exists(obj_pause_menu))
        {
            instance_create_layer(0, 0, "Menu", obj_pause_menu);
        }
    }
} 