
// Ignora clicks fora da pizza
var _dist = point_distance(x, y, mouse_x, mouse_y);
if (_dist > sprite_width / 2) exit;

// Encontra a direção do clique com relação ao centro da pizza
var _ang = point_direction(x, y, mouse_x, mouse_y);

// Pega o indice do pedaço
var _slice_index = floor(_ang / slice_size);

// Esconde o pedaço
slices[_slice_index].visible = false;