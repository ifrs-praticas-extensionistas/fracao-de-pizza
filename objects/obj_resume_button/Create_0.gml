function on_click()
{
    global.game_state = GAME_STATE.PLAYING;

    with (obj_pause_menu)
    {
        instance_destroy();
    }

    with (obj_resume_button)
    {
        instance_destroy();
    }

    with (obj_settings_button)
    {
        instance_destroy();
    }

    with (obj_quit_button)
    {
        instance_destroy();
    }
} 