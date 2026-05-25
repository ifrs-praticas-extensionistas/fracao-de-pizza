var cx = display_get_gui_width() / 2;
var cy = display_get_gui_height() / 2;
var b;

b = instance_create_layer(cx,cy -100,"Instancias",obj_btn);
b.texto = "New Game";
b.acao = 0;

b = instance_create_layer(cx,cy,"Instancias",obj_btn);
b.texto = "Settings"; 
b.acao = 1;
 
b = instance_create_layer(cx,cy +100,"Instancias",obj_btn);
b.texto = "Exit";
b.acao = 2;