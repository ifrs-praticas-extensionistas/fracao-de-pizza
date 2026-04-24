show_debug_message(obj_pizza.slices)
show_debug_message(obj_pizza.slice_count)
show_debug_message(obj_pizza.slice_size)

if (!obj_pizza.slices[slice_index].onplate) { x += a_speed; }
else {x -= a_speed}
a_speed += 5

if(x >= obj_pizza_plate.x && !obj_pizza.slices[slice_index].onplate){
	instance_destroy()
	obj_pizza.slices[slice_index].onplate = true
	obj_pizza.slices[slice_index].animated = false
} 

else if (x <= obj_pizza.x && obj_pizza.slices[slice_index].onplate) {
	instance_destroy()
	obj_pizza.slices[slice_index].onplate = false
	obj_pizza.slices[slice_index].animated = false
}