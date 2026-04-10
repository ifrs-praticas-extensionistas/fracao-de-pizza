// Centro da pizza
var cx = x;
var cy = y;

for (var i = 0; i < obj_pizza.slice_count; i++)
{
	// Se o pedaço estiver visível, não desenha ele no prato (ainda não selecionado)
    if (obj_pizza.slices[i].visible) continue;

	// Pega os ângulos de início e fim do pedaço
    var ang1 = i *  obj_pizza.slice_size;
    var ang2 = (i + 1) *  obj_pizza.slice_size;
	
    shader_set(sh_slice);

	// Envia para o shader os ângulos inicial e final do pedaço, junto com as coordenadas do centro da pizza
    shader_set_uniform_f(u_angle_start, ang1);
    shader_set_uniform_f(u_angle_end, ang2);
    shader_set_uniform_f(u_center_x, cx);
    shader_set_uniform_f(u_center_y, cy);
	
    draw_sprite(sprite_index, image_index, cx, cy);

    shader_reset();
}