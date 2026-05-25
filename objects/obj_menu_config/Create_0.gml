var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;

var espacamento = 90;

var b;

b = instance_create_layer(cx, cy - espacamento * 1.5,"GUI",obj_btn);
b.texto = "Music ON/OFF";
b.acao = 3;

b = instance_create_layer(cx, cy - espacamento * 0.5,"GUI",obj_btn);
b.texto = "Volume +";
b.acao = 4;

b = instance_create_layer(cx, cy + espacamento * 0.5,"GUI",obj_btn);
b.texto = "Volume -";
b.acao = 5;

b = instance_create_layer(cx, cy + espacamento * 1.5,"GUI",obj_btn);
b.texto = "Back";
b.acao = 6;