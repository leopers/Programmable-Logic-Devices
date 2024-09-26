.data
menu:      .asciiz "\n1. Cafe R$ 2,00\n2. Refrigerante R$ 4,00\n3. Pao de Queijo R$ 5,00\n4. Coxinha R$ 6,00\nEscolha o item (0 para finalizar): "
quant_msg: .asciiz "\nQuantidade: "
total_msg: .asciiz "\nTotal da compra: R$ "
pay_msg:   .asciiz "\nQuanto o cliente pagou? R$ "
change_msg:.asciiz "\nTroco: R$ "
beep:      .asciiz "\n*BIP* Compra finalizada!\n"
newline:   .asciiz "\n"
invalid:   .asciiz "\nOpcao invalida!\n"

# Preços dos itens
price_cafe:        .word 2
price_refrigerante:.word 4
price_pao:         .word 5
price_coxinha:     .word 6

.text

# Procedimento principal
main:
    move $t6, $zero     # Zera o total acumulado ($t6)
item_loop:              # Início do loop para vários itens
    jal print_menu      # Exibe o menu
    jal get_item        # Obtém o item escolhido

    beq $t0, $zero, finalize_purchase  # Se o item for 0, finaliza a compra

    jal get_quantity    # Obtém a quantidade escolhida
    jal calculate_total # Calcula o total da compra atual e acumula no total geral
    j item_loop         # Retorna ao início do loop para o próximo item

finalize_purchase:
    jal display_total   # Exibe o total da compra
    jal get_payment     # Obtém o valor pago pelo cliente
    jal calculate_change # Calcula o troco
    jal display_change  # Exibe o troco
    jal beep_sound      # Emite o som de beep

    j main              # Reinicia para nova compra

# Procedimento para exibir o menu
print_menu:
    li $v0, 4
    la $a0, menu
    syscall
    jr $ra

# Procedimento para obter o item
get_item:
    li $v0, 5
    syscall
    move $t0, $v0        # Armazena a escolha do item em $t0
    jr $ra

# Procedimento para obter a quantidade
get_quantity:
    li $v0, 4
    la $a0, quant_msg
    syscall

    li $v0, 5
    syscall
    move $t1, $v0        # Armazena a quantidade em $t1
    jr $ra

# Procedimento para calcular o total acumulado
calculate_total:
    beq $t0, 1, cafe
    beq $t0, 2, refrigerante
    beq $t0, 3, pao
    beq $t0, 4, coxinha

    j invalid_option     # Caso a opção não seja válida

cafe:
    lw $t3, price_cafe
    mul $t4, $t3, $t1    # Multiplica o preço pela quantidade
    add $t6, $t6, $t4    # Acumula o valor total em $t6
    jr $ra

refrigerante:
    lw $t3, price_refrigerante
    mul $t4, $t3, $t1
    add $t6, $t6, $t4
    jr $ra

pao:
    lw $t3, price_pao
    mul $t4, $t3, $t1
    add $t6, $t6, $t4
    jr $ra

coxinha:
    lw $t3, price_coxinha
    mul $t4, $t3, $t1
    add $t6, $t6, $t4
    jr $ra

invalid_option:
    li $v0, 4
    la $a0, invalid
    syscall
    jr $ra

# Procedimento para exibir o total
display_total:
    li $v0, 4
    la $a0, total_msg
    syscall

    li $v0, 1
    move $a0, $t6        # Exibe o valor total acumulado
    syscall
    jr $ra

# Procedimento para obter o pagamento
get_payment:
    li $v0, 4
    la $a0, pay_msg
    syscall

    li $v0, 5
    syscall
    move $t7, $v0        # Armazena o valor pago em $t7
    jr $ra

# Procedimento para calcular o troco
calculate_change:
    sub $t5, $t7, $t6    # Calcula o troco (valor pago - total)
    jr $ra

# Procedimento para exibir o troco
display_change:
    li $v0, 4
    la $a0, change_msg
    syscall

    li $v0, 1
    move $a0, $t5        # Exibe o troco
    syscall
    jr $ra

# Procedimento para emitir o som de beep
beep_sound:
    li $v0, 31         # Syscall 31 for MIDI out
    li $a0, 60         # Define the pitch (e.g., middle C is 60)
    li $a1, 500        # Duration in milliseconds (e.g., 500 ms)
    li $a2, 0          # Instrument (0 is default, piano)
    li $a3, 100        # Volume (e.g., 100 out of 127)
    syscall
    jr $ra