// obj_pause_menu - Create

var center_x = display_get_gui_width() * 0.5;
var start_y = 260;
var spacing = 100;

instance_create_layer(center_x, start_y, "Menu", obj_resume_button);

instance_create_layer(center_x, start_y + spacing, "Menu", obj_settings_button);

instance_create_layer(center_x, start_y + spacing * 2, "Menu", obj_quit_button);