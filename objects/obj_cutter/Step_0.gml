// Open wheel

if (mouse_check_button_pressed(hold_button))
{
    if (position_meeting(mouse_x, mouse_y, id))
    {
        menu_open = true;

        center_x = x;
        center_y = y;

        selected = -1;
    }
}

// Update selection

if (menu_open)
{
    var dist = point_distance(
        center_x,
        center_y,
        mouse_x,
        mouse_y
    );

    if (dist < deadzone)
    {
        selected = -1;
    }
    else
    {
        var angle = point_direction(
            center_x,
            center_y,
            mouse_x,
            mouse_y
        );

        var slice = 360 / option_count;

        selected = floor(((angle + slice * 0.5) mod 360) / slice);
    }
}

// Confirm selection

if (menu_open && mouse_check_button_released(hold_button))
{
    menu_open = false;

    if (selected != -1)
		obj_pizza.slice_count = selected + 2;

    selected = -1;
}