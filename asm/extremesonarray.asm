.data 

v: .space 20                      # Espaço para 5 inteiros (5 * 4 = 20 bytes)
string: .asciiz "Digite o valor: " # Mensagem para o usuário
maior: .asciiz "O maior valor eh: " 
menor: .asciiz "O menor valor eh: " 

.text

# Inicializações
la $s0, v          # Carrega o endereço base do vetor em $s0
li $s1, 0          # Inicializa o contador $s1 em 0
li $s2, 0x80000000 # Inicializa $s2 com o menor valor possível para o maior valor
li $s3, 0x7fffffff # Inicializa $s3 com o maior valor possível para o menor valor

LOOP:
    beq $s1, 5, LOOP_END          # Se $s1 == 5, fim do loop
    
    sll $t1, $s1, 2               # Calcula o índice do vetor (multiplica $s1 por 4)
    add $t1, $t1, $s0             # Adiciona o deslocamento ao endereço base do vetor
    
    # Exibe a mensagem "Digite o valor:"
    li $v0, 4
    la $a0, string
    syscall
    
    # Lê um valor inteiro do usuário
    li $v0, 5
    syscall
    move $t0, $v0                 # Armazena o valor lido em $t0
    sw $t0, 0($t1)                # Armazena o valor no vetor

    # Comparação para o maior valor
    slt $t2, $s2, $t0             # $t2 = 1 se $s2 < $t0 (atual maior valor < valor lido)
    bne $t2, 1, check_min         # Se não for maior, vá para a verificação de menor valor
    move $s2, $t0                 # Atualiza o maior valor para $t0 se for maior

check_min:
    # Comparação para o menor valor
    slt $t2, $t0, $s3             # $t2 = 1 se $t0 < $s3 (valor lido < atual menor valor)
    bne $t2, 1, increment_counter # Se não for menor, vá para o incremento do contador
    move $s3, $t0                 # Atualiza o menor valor para $t0 se for menor

increment_counter:
    addi $s1, $s1, 1              # Incrementa o contador $s1
    j LOOP                        # Retorna para o início do loop

LOOP_END:
    # Exibe o maior valor
    la $a0, maior
    li $v0, 4
    syscall
    move $a0, $s2
    li $v0, 1                     # Imprime o maior valor
    syscall

    # Exibe o menor valor
    la $a0, menor
    li $v0, 4
    syscall
    move $a0, $s3
    li $v0, 1                     # Imprime o menor valor
    syscall

