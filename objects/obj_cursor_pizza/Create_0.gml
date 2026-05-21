persistent = true;

// sprite inicial
cursor_sprite = spr_cursorNORMAL_pizza;

// esconde cursor do sistema
window_set_cursor(cr_none);

// estado inicial
state = CURSOR_STATE.NORMAL;

// posição
x = device_mouse_x_to_gui(0);
y = device_mouse_y_to_gui(0); 