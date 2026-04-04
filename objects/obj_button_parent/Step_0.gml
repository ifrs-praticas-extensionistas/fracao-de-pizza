hover = point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom); 

  if(hover && mouse_check_button_pressed(mb_left)) {
	on_click(); 
}
  if(hover){
  window_set_cursor(cr_handpoint);
  } else{
	window_set_cursor(cr_default); 
  }
      