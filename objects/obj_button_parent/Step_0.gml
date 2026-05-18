hover = position_meeting(mouse_x, mouse_y, id);

if (hover)
{
    target_scale = 1.1;
}
else
{
    target_scale = 1;
}

image_xscale = lerp(image_xscale, target_scale, 0.2);
image_yscale = image_xscale;

if (hover && mouse_check_button_pressed(mb_left))
{
    on_click();
}