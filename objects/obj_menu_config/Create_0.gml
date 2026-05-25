var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;
var b;

b = instance_create_layer(960,400,"GUI",obj_btn);
b.texto = "Music ON/OFF";
b.acao = 3;

b = instance_create_layer(960,500,"GUI",obj_btn);
b.texto = "Volume +";
b.acao = 4;

b = instance_create_layer(960,600,"GUI",obj_btn);
b.texto = "Volume -";
b.acao = 5;

b = instance_create_layer(960,700,"GUI",obj_btn);
b.texto = "Back";
b.acao = 6;