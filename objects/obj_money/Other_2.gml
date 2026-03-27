money = 0.00;

function add(val, mk_popup){
	if mk_popup {
		var inst = instance_create_layer(display_get_gui_width() - 10, 30, "Instances", obj_money_popup);
		inst.text = "+" + string(val);
	}
	
	money += val;
}

function remove(val, mk_popup){
	if mk_popup = true {
		var inst = instance_create_layer(display_get_gui_width() - 10, 30, "Instances", obj_money_popup)
		inst.text = "-" + string(val);
	}
	
	money -= val;
}