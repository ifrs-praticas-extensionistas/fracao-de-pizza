draw_self();
if (menu_open)
{
    var slice = 360 / option_count;

    for (var i = 0; i < option_count; i++)
    {
        var angle = i * slice;

        var ox = center_x + lengthdir_x(radius, angle);
        var oy = center_y + lengthdir_y(radius, angle);

        if (i == selected)
        {
            draw_circle(ox, oy, 20, false);
        }
		draw_text_outline(ox - string_width(string(i + 2)) * 0.5, oy - 8, string(i + 2), c_white, c_black, 1.5, 1)
	}
}