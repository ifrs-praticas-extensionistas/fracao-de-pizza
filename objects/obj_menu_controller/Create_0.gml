global.music_on = true;
global.volume = 1;

audio_master_gain(global.volume);

// controle musica
music_started = false;

// fonte
fonte = fonte_menu;

// estado menu
menu = "main";

// opções
opcoes_main = [
    "New Game",
    "Settings",
    "Exit"
];

op_main_max = array_length(opcoes_main);

// distancia entre itens
dist = 80;