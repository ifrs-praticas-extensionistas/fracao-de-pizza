if (entrando) {
    x += (target_x - x) * 0.12;
    y += (target_y - y) * 0.12;
    if (abs(x - target_x) < 2 && abs(y - target_y) < 2) {
        x = target_x;
        y = target_y;
        entrando = false;
    }
    exit;
}

if (caindo) {
    vy    += 1.5;
    y     += vy;
    rot   += rot_vel;
    alpha -= 0.03;
    if (alpha <= 0) instance_destroy();
    exit;
}

// Flash verde ao acertar
if (flash_timer > 0) {
    flash_timer--;
    if (flash_timer <= 0) {
        caindo = true;
    }
    exit;
}

tempo_restante -= delta_time / 1000000;
if (tempo_restante <= 0) {
    tempo_restante = 0;
    falhado    = true;
    cor_flash  = c_red;
    caindo     = true;
    var _s = slot;
    with (obj_orderManager) { slots_ocupados[_s] = false; }
}