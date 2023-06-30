####################################################################################################################################
# PROJETO DE ARQUITETURA DE COMPUTADORES 2021/2022 - UAL
# TEMA: Calculadora Cient�fica
# Fase: 3
# GRUPO:
# 30002232 Paulo Correia
# 30008290 Eduardo Araujo
# 30008215 Jo�o Lucas
# 30008241 Pedro Amaral
#####################################################################################################################################
.data
Help: .asciiz "\nHELP: \n 1-Como realizar as opera��es b�sicas \n 2-Como realizar as convers�es \n 3-Como calcular logarimo \n 4-Como Calcular a potencia ou a Ra�z \n 5- Como calcular o seno e o cosseno\n"
.text 
main:
li $v0, 4
la $a0, Help
syscall
escolhas:
li $v0, 5
syscall
beq $v0, 1, basics
beq $v0, 2, conversoes
beq $v0, 3, logaritmo
beq $v0, 4, pot_raiz
beq $v0, 5, sen_cos
.data
nome_ficheiro: .asciiz "C:/Users/abdul/projeto ac/basics.txt"
palavra1: .space 1024
.text
basics:
#abrir o ficheiro
li $v0,13  # c�digo para abrir o ficheiro
la $a0,nome_ficheiro # carregar o nome do ficheiro
li $a1,0
syscall
move $s0, $v0

#ler o ficheiro


move $a0,$s0 
li $v0, 14  # codigo para ler o ficheiro
la $a1, palavra1
la $a2, 1024
syscall

#Imprimir o ficheiro
li $v0, 4  # codigp para ler sring
move $a0, $a1 
syscall 

#Fechar o ficheiro
li $v0, 16
move $a0,$s0
syscall

j main
###############################################################################################################
.data
nome_ficheiro2: .asciiz "C:/Users/abdul/projeto ac/conversoes.txt"
palavra2: .space 1024
.text
conversoes:
#abrir o ficheiro
li $v0,13  # c�digo para abrir o ficheiro
la $a0,nome_ficheiro2 # carregar o nome don ficheiro
li $a1,0
syscall
move $s0, $v0

#ler o ficheiro


move $a0,$s0 
li $v0, 14  # codigo para ler o ficheiro
la $a1, palavra2
la $a2, 1024
syscall

#Imprimir o ficheiro
li $v0, 4  # codigo para ler string
move $a0, $a1 
syscall 

#Fechar o ficheiro
li $v0, 16
move $a0,$s0
syscall
j main

####################################################################################################
.data
nome_ficheiro3: .asciiz "C:/Users/abdul/projeto ac/logaritmo.txt"
palavra3: .space 1024
.text
logaritmo:
#abrir o ficheiro
li $v0,13  # c�digo para abrir o ficheiro
la $a0,nome_ficheiro3 # carregar o nome don ficheiro
li $a1,0
syscall
move $s0, $v0

#ler o ficheiro


move $a0,$s0 
li $v0, 14  # codigo para ler o ficheiro
la $a1, palavra3
la $a2, 1024
syscall

#Imprimir o ficheiro
li $v0, 4  # codigo para ler string
move $a0, $a1 
syscall 

#Fechar o ficheiro
li $v0, 16
move $a0,$s0
syscall
j main

#################################################################################################################
.data
nome_ficheiro4: .asciiz "C:/Users/abdul/projeto ac/pot_raiz.txt"
palavra4: .space 1024
.text
pot_raiz:
#abrir o ficheiro
li $v0,13  # c�digo para abrir o ficheiro
la $a0,nome_ficheiro4 # carregar o nome don ficheiro
li $a1,0
syscall
move $s0, $v0

#ler o ficheiro


move $a0,$s0 
li $v0, 14  # codigo para ler o ficheiro
la $a1, palavra4
la $a2, 1024
syscall

#Imprimir o ficheiro
li $v0, 4  # codigo para ler string
move $a0, $a1 
syscall 

#Fechar o ficheiro
li $v0, 16
move $a0,$s0
syscall
j main
###################################################################################################################################
.data
nome_ficheiro5: .asciiz "C:/Users/abdul/projeto ac/sen_cos.txt"
palavra5: .space 1024
.text
sen_cos:
#abrir o ficheiro
li $v0,13  # c�digo para abrir o ficheiro
la $a0,nome_ficheiro5 # carregar o nome don ficheiro
li $a1,0
syscall
move $s0, $v0

#ler o ficheiro


move $a0,$s0 
li $v0, 14  # codigo para ler o ficheiro
la $a1, palavra5
la $a2, 1024
syscall

#Imprimir o ficheiro
li $v0, 4  # codigo para ler string
move $a0, $a1 
syscall 

#Fechar o ficheiro
li $v0, 16
move $a0,$s0
syscall
j main
