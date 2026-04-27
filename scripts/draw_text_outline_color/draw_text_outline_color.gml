function draw_text_outline(
    _x, _y, _text,
    _col_text, _col_outline,
    _thickness, _alpha
)
{
    // 8 clean directions
    var dirs = [
        [-1, 0], [1, 0], [0, -1], [0, 1],
        [-1, -1], [-1, 1], [1, -1], [1, 1]
    ];

    //fill thickness smoothly
    for (var t = 1; t <= _thickness; t++)
    {
        for (var k = 0; k < array_length(dirs); k++)
        {
            var dx = dirs[k][0] * t;
            var dy = dirs[k][1] * t;

            draw_text_color(
                _x + dx, _y + dy,
                _text,
                _col_outline, _col_outline, _col_outline, _col_outline,
                _alpha
            );
        }
    }

    // main text
	draw_text_color(
        _x, _y,
        _text,
        _col_text, _col_text, _col_text, _col_text,
        _alpha
    );
}