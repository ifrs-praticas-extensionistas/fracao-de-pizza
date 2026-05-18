cursor_x = device_mouse_x_to_gui(0);
cursor_y = device_mouse_y_to_gui(0);

state = CURSOR_STATE.NORMAL;

if (instance_position(x, y, obj_button_parent))
{
    state = CURSOR_STATE.HOVER;
}

if (mouse_check_button(mb_left))
{
    state = CURSOR_STATE.CLICK;
}

switch(state)
{
    case CURSOR_STATE.NORMAL:
        cursor_sprite = spr_cursorNORMAL_pizza;
    break;

    case CURSOR_STATE.HOVER:
        cursor_sprite = spr_cursorHOVER_pizza;
    break;

    case CURSOR_STATE.CLICK:
        cursor_sprite = spr_cursorCLICK_pizza;
    break;
}