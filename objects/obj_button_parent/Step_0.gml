hover = position_meeting(
    mouse_x,
    mouse_y,
    id
);

if (hover)
{
    image_xscale = lerp(image_xscale, 1.1, 0.2);
    image_yscale = lerp(image_yscale, 1.1, 0.2);

    if (mouse_check_button_pressed(mb_left))
    {
        event_user(0);
    }
}
else
{
    image_xscale = lerp(image_xscale, 1, 0.2);
    image_yscale = lerp(image_yscale, 1, 0.2);
}