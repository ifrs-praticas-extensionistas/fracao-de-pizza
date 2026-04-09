// When creating the slice (e.g. in obj_pizza Create or a controller object)
var pizza_w = sprite_get_width(spr_pizza);
var pizza_h = sprite_get_height(spr_pizza);

// 1. Draw pizza onto a surface
var surf = surface_create(pizza_w, pizza_h);
surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    draw_sprite(spr_pizza, 0, 0, 0);
surface_reset_target();

// 2. Create a new sprite from a rectangular region of that surface
//    sprite_add_from_surface(surface, x, y, w, h, removeback, smooth)
var slice_sprite = sprite_add_from_surface(spr_pizza, surf, 32, 0, 64, 64, false, false);

// 3. Free the surface — you don't need it anymore
surface_free(surf);

// 4. Instance the slice object and assign the sprite
var inst = instance_create_layer(x, y, "Instances", obj_pizza_slice);
inst.sprite_index = slice_sprite;