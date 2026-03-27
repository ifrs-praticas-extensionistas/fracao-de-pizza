slice_count = 4;
slice_size = 360 / slice_count
last_slice_count = slice_count;
slices = [];
for (var i = 0; i < slice_count; i++) {
    slices[i] = {
        visible: true
    };
}

u_angle_start = shader_get_uniform(sh_slice, "u_angle_start");
u_angle_end   = shader_get_uniform(sh_slice, "u_angle_end");
u_center_x    = shader_get_uniform(sh_slice, "u_center_x");
u_center_y    = shader_get_uniform(sh_slice, "u_center_y");
