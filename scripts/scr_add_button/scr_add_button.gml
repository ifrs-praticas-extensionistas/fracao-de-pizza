menu_container = instance_create_layer(0,0,"GUI",obj_menu_container);

array_push(menu_container.buttons,
    instance_create_layer(0,0,"GUI",obj_resume_button)
);

array_push(menu_container.buttons,
    instance_create_layer(0,0,"GUI",obj_settings_button)
);

array_push(menu_container.buttons,
    instance_create_layer(0,0,"GUI",obj_quit_button)
);