hover = point_in_rectangle(
    mouse_x,
    mouse_y,
    bbox_left,
    bbox_top,
    bbox_right,
    bbox_bottom
);

if (hover)
{
    image_xscale = lerp(image_xscale, hover_scale, hover_speed);
    image_yscale = lerp(image_yscale, hover_scale, hover_speed);

    if (mouse_check_button_pressed(mb_left))
    {
        event_user(0);
    }
}
else
{
    image_xscale = lerp(image_xscale, normal_scale, hover_speed);
    image_yscale = lerp(image_yscale, normal_scale, hover_speed);
}