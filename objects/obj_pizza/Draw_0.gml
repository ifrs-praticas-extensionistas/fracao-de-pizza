// Centro da pizza
var cx = x;
var cy = y;

var _num_slices = array_length(slices);

for (var i = 0; i < _num_slices; i++)
{
	// Se o pedaço tiver escondido, não desenha ele
    if (!slices[i].visible) continue;

	// Pega os ângulos de início e fim do pedaço
    var ang1 = i * slice_size;
    var ang2 = (i + 1) * slice_size;

    shader_set(sh_slice);

	// Envia para o shader os ângulos inicial e final do pedaço, junto com as coordenadas do centro da pizza
    shader_set_uniform_f(u_angle_start, ang1);
    shader_set_uniform_f(u_angle_end, ang2);
    shader_set_uniform_f(u_center_x, cx);
    shader_set_uniform_f(u_center_y, cy);
	
    draw_sprite(sprite_index, image_index, cx, cy);

    shader_reset();
}

draw_set_color(c_black);

var radius = sprite_width * 0.5;

for (var i = 0; i < _num_slices; i++)
{
	
	var _prev_i = i == 0 ? (_num_slices - 1) : i - 1;
	
	if (!slices[i].visible && !slices[_prev_i].visible) continue;
	
    var ang = i * slice_size;

    var x2 = cx + lengthdir_x(radius, ang);
    var y2 = cy + lengthdir_y(radius, ang);
	
	// Desenha os cortes na pizza
    draw_line(cx, cy, x2, y2);
}