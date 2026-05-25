// Detecta os números (0–9)
for (var i = 0; i <= 9; i++) {
    if (keyboard_check_pressed(ord(string(i)))) {
        slice_count = i;
    }
}

slice_count = clamp(slice_count, 2, 9);

// Refaz o array se o count mudou
if (slice_count != last_slice_count) {
	slice_size = 360 / slice_count
    slices = [];
    
    for (var i = 0; i < slice_count; i++) {
        slices[i] = { 
            visible: true,
            animated: false,
            onplate: false
        };
    }

    last_slice_count = slice_count;
}