.data
    array: .space 40            
    msg_input: .asciiz "Digite um valor: "
    msg_sorted: .asciiz "Vetor ordenado: "
    newline: .asciiz "\n"

.text
    .globl main

main:
    li $t0, 0                    # $t0 índice do vetor
    la $t1, array                # $t1 ponteiro para o vetor array

input_loop:
    bge $t0, 10, sort            

    
    li $v0, 4                    
    la $a0, msg_input            
    syscall

    li $v0, 5                    
    syscall
    sw $v0, 0($t1)               

    addi $t0, $t0, 1             
    addi $t1, $t1, 4            
    j input_loop                 

sort:
    li $t0, 1                   
    
outer_loop:
    bge $t0, 10, print_sorted    
    
    mul $t2, $t0, 4             
    la $t3, array                
    add $t3, $t3, $t2            
    lw $t4, 0($t3)               

    add $t5, $t0, -1

inner_loop:
    blt $t5, 0, insert_element   
    mul $t6, $t5, 4              
    la $t7, array                
    add $t7, $t7, $t6            
    lw $t8, 0($t7)              

    ble $t8, $t4, insert_element 

    sw $t8, 4($t7)
    
    addi $t5, $t5, -1           
    j inner_loop

insert_element:
    mul $t6, $t5, 4              
    la $t7, array                
    add $t7, $t7, $t6            
    sw $t4, 4($t7)               

    addi $t0, $t0, 1             
    j outer_loop                 

print_sorted:
    li $v0, 4                    
    la $a0, msg_sorted           
    syscall

    li $t0, 0                   
    la $t1, array                

print_loop:
    bge $t0, 10, exit            

    lw $a0, 0($t1)               
    li $v0, 1                    
    syscall

    
    li $v0, 4
    la $a0, newline
    syscall

    addi $t0, $t0, 1            
    addi $t1, $t1, 4             
    j print_loop                 
 
exit:
    li $v0, 10                   
    syscall