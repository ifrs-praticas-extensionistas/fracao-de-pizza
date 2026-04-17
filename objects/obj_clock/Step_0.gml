if (!acabou) {
    dt = delta_time / 1000000;

    time_left -= dt;

    if (time_left <= 0) {
        time_left = 0;
        acabou = true;

        // fim da fase
        show_message("Tempo esgotado!");
        room_restart();
    }
}