var b;

b = instance_create_layer(960,400,"GUI",obj_btn);
b.texto = "New Game";
b.acao = 0;

b = instance_create_layer(960,500,"GUI",obj_btn);
b.texto = "Configuracoes";
b.acao = 1;

b = instance_create_layer(960,600,"GUI",obj_btn);
b.texto = "Exit";
b.acao = 2;