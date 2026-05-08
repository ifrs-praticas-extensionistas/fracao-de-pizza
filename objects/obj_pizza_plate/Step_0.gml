if (anim_state == "serving") {
    x += anim_speed;
    if (x > room_width + 200) {
        anim_state = "returning";
        x = original_x;
        y = room_height + 200;
        
        // Limpar o prato (resetar fatias da pizza que estavam onplate)
        with (obj_pizza) {
            for (var j = 0; j < array_length(slices); j++) {
                if (slices[j].onplate) {
                    slices[j].onplate = false;
                }
            }
        }
    }
} else if (anim_state == "returning") {
    y -= anim_speed;
    if (y <= original_y) {
        y = original_y;
        anim_state = "idle";
    }
}