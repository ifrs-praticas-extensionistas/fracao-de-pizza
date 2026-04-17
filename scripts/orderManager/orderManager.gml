/// _garantir_botao(numerador, denominador)
function _garantir_botao(num, den) {
    // Verifica se botão já existe
    with (obj_answerButton) {
        if (numerador == num && denominador == den) exit;
    }
    // Cria botão em posição aleatória no rodapé
    var bx = 100 + irandom(room_width - 200);
    var by = room_height - 80;
    var b = instance_create_layer(bx, by, "Instances", obj_answerButton);
    b.numerador   = num;
    b.denominador = den;
}