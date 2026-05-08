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

function check_and_complete_order() {
    if (!instance_exists(obj_pizza)) return;
    
    // 1. Identificar fraçao no prato
    var total_slices = obj_pizza.slice_count;
    var slices_on_plate = 0;
    for (var i = 0; i < array_length(obj_pizza.slices); i++) {
        if (obj_pizza.slices[i].onplate) {
            slices_on_plate++;
        }
    }
    
    if (slices_on_plate == 0) return; // Nada no prato
    
    var found = false;
    // 2. Validar com os pedidos ativos
    with (obj_orderNote) {
        if (concluido || falhado || caindo) continue;
        
        // Multiplicação cruzada: a/b == c/d => a*d == c*b
        // Nosso pedido: numerador/denominador
        // No prato: slices_on_plate/total_slices
        if (numerador * total_slices == slices_on_plate * denominador) {
            // Entrega correta!
            concluido = true;
            cor_flash = c_lime;
            flash_timer = 60; // 1 segundo de flash
            money_add(5.00, true);
            found = true;
            
            // Limpar prato automaticamente
            with (obj_pizza) {
                for (var j = 0; j < array_length(slices); j++) {
                    if (slices[j].onplate) {
                        slices[j].onplate = false;
                        // O pedaço some do jogo (visible já era false)
                    }
                }
            }
            
            // Liberar slot no manager
            var _s = slot;
            with (obj_orderManager) { slots_ocupados[_s] = false; }
            
            break; // Sair do loop with após encontrar o primeiro pedido compatível
        }
    }
}