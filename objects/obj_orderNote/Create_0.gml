slot       = -1;
numerador  = 1;
denominador = 2;
target_x   = x;
target_y   = y;
entrando   = true;

tempo_total    = 10.0;
tempo_restante = tempo_total;

concluido = false;
falhado   = false;
caindo    = false;

vy      = 0;
rot     = 0;
rot_vel = choose(-1, 1) * (2 + random(2));
alpha   = 1.0;

cor_flash  = c_white;
flash_timer = 0;