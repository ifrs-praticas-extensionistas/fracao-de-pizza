y_offset -= 0.5;   // move upward
alpha -= 0.03;     // fade out

if (alpha <= 0) {
    instance_destroy();
}