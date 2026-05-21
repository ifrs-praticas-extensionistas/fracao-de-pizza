x = device_mouse_x_to_gui(0);
y = device_mouse_y_to_gui(0);

state = CURSOR_STATE.NORMAL;

// hover
if (instance_position(x, y, obj_menu_controller))
{
    state = CURSOR_STATE.HOVER;
}

// click
if (
    global.menu_hover != -1
    && mouse_check_button_pressed(mb_left)
)
{
    state = CURSOR_STATE.CLICK;
}

// troca sprite
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