######################################################################################################################################
# PROJETO DE ARQUITETURA DE COMPUTADORES 2021/2022 - UAL
# TEMA: Calculadora Cient�fica
# Fase: 1
# GRUPO:
# 30002232 Paulo Correia
# 30008290 Eduardo Araujo
# 30008215 Jo�o Lucas
# 30008241 Pedro Amaral
#####################################################################################################################################
.data
operacoes: .asciiz "\nOla bem vindo a nossa calculadora\n\nEscolha uma das op��es:\n 1-Opera��es b�sicas \n 2-Convers�es \n 0-Sair do programa\n"
msg_op: .asciiz ">"

.text

main: 
li $v0, 4  #Comando para imprimir uma string
la $a0,operacoes #Imprime as op��es da calculadora
syscall #chamada do sistema

switch:  #Escolher opera��o
li $v0, 4  
la $a0,msg_op
syscall
li $v0,5 # input de inteiro
syscall 
beq $v0, 1, basics
beq $v0, 2, conversoes
beq, $v0, 0, Sair

.data
msg_basicas: .asciiz "\n 1 - Soma \n 2 - Subtracao \n 3 - Multiplicacao \n 4 - Divisao \n 5 - Fatorial \n 6 - M�dia \n 0 - Voltar para o menu anterior\n"
.text
basics:
la $a0, msg_basicas
li $v0,4
syscall
li $v0,5
syscall
beq, $v0,1, Soma
beq, $v0,2, Subtracao
beq, $v0,3,Multiplicacao
beq, $v0,4,Divisao
beq, $v0,5,fatorial
beq, $v0,6,media
beq, $v0,0,main

.data
volt_str: .asciiz"\n 1 - Voltar para o menu principal \n 2 - Voltar para o menu das opera��es b�sicas \n 0 - Sair do Programa\n"
.text
voltar:
la $a0,volt_str
li $v0,4
syscall
li $v0,5
syscall
beq, $v0,1,main
beq $v0,2,basics
beq $v0,0,Sair



Soma:
li $v0, 6 # comando para leitura do numero
syscall
mov.s $f1, $f0 

syscall
mov.s $f2, $f0

add.s $f1, $f1,$f2 # Para somar os numeros
mov.s $f12, $f1

li $v0, 2
syscall
j voltar

#----------------------------------------------------------------------------------------

Subtracao:
li $v0, 6 # comando para leitura do numero
syscall
mov.s $f1, $f0 

syscall
mov.s $f2, $f0

sub.s $f1, $f1,$f2 # Para subtrair os numeros
mov.s $f12, $f1

li $v0, 2
syscall
j voltar

#----------------------------------------------------------------------------------------

Multiplicacao:
li $v0, 6 # comando para leitura do numero
syscall
mov.s $f1, $f0 

syscall
mov.s $f2, $f0

mul.s $f1, $f1,$f2 # Para multiplicar os numeros
mov.s $f12, $f1

li $v0, 2
syscall
j voltar

#----------------------------------------------------------------------------------------

Divisao:
li $v0, 6 # comando para leitura do numero
syscall
mov.s $f1, $f0 

syscall
mov.s $f2, $f0

div.s $f1, $f1,$f2 # Para dividir os numeros
mov.s $f12, $f1
li $v0, 2
syscall
j voltar

.data
volt2_str: .asciiz"\n 1-Voltar para o menu principal \n 2-Voltar para o menu das conversoes \n 0-Sair do programa\n"
.text
voltar2:
la $a0,volt2_str
li $v0,4
syscall
li $v0,5
syscall
beq, $v0,1,main
beq $v0,2,conversoes
beq $v0,0,Sair

.data
msg_con: .asciiz"\n 1-Bin�rio para decimal \n 2-Decimal para Bin�rio \n 3-Decimal para hexadecimal \n 4-Hexadecimal para Decimal \n 5-Entre Bin�rio e Hexadecimal \n 0-Voltar para o menu anterior \n"
.text
conversoes:
la $a0,msg_con
li $v0, 4
syscall
li $v0, 5
syscall
beq $v0,1,bin_dec
beq $v0,2,decimal_binario
beq $v0,3,dec_hex
beq $v0,4,mainHex_Dec
beq $v0,5,mainB2H
beq $v0,6,Sair
beq $v0,0,main
.data 
	binToHexPrompt: .asciiz "\n Binario para hexadecimal ('b'), hexadecimal para binario ('h'): "
	choice: .space 3
	choiceError: .asciiz  "Escolha errada\n"
	str_bin2dec:	.asciiz		"\nBinario: "
	str_dec2bin:	.asciiz		"\ndecimal: "
	inputNumberArray5: .space 100
	str5: .asciiz "\nIntroduza : "
	ansHexa5: .asciiz "Hexadecimal: " 
	ansBin: .asciiz "\nBinario: "
	result5: .space 8 
	buffer5:	.space 32

.text 

.globl mainB2H

mainB2H:
	
        la $a0, binToHexPrompt  #Carregar a mensagem no $a0
  	li $v0, 4
   	syscall
   	
   	
   	la $a0, choice
   	li $v0, 8
	la $a1, 3
	syscall
   	
  	lb $t1, 0($a0)
	beq $t1, 'b', binToHex	
	beq $t1, 'B', binToHex
	beq $t1, 'h', hexToBin	
	beq $t1, 'H', hexToBin
	
	
	la $a0, choiceError	
	la $v0, 4
	syscall
	
	b mainB2H
	
binToHex:	
bin2dec:
	
	li $v0, 4		
	la $a0, str_bin2dec         
	syscall
	
	la $a0, buffer5		
	li $a1, 32              
	li $v0, 8               
	syscall
	li $t4, 0               
	la $t1, buffer5	
	li $t9, 32		
loop_b2d:
	lb $a0, ($t1)      	
	blt $a0, 48, result_b2d
	addi $t1, $t1, 1        
	subi $a0, $a0, 48       
	subi $t9, $t9, 1        
	beq $a0, 0, zeroBit	
	beq $a0, 1, oneBit	
	j result_b2d     	
	zeroBit:
	j loop_b2d
			
	oneBit:                 
	li $t8, 1      
	        
	sllv $t5, $t8, $t9    	
	add $t4, $t4, $t5       
	j loop_b2d
result_b2d:
	srlv $t4, $t4, $t9	
	
	move $t2, $t4      
	


	li $t0, 8 
	la $t3, result5 
Loop5: 
    	beqz $t0, Exit5 
    	
     	rol $t2, $t2, 4 
     	and $t4, $t2, 0xf
     	ble $t4, 9, Sum5 
     	addi $t4, $t4, 55 
     	b End5

Sum5: 
       	addi $t4, $t4, 48 

End5: 
       	sb $t4, 0($t3) 
       	addi $t3, $t3, 1
       	addi $t0, $t0, -1
       	
       	j Loop5 

Exit5: 	
	li $t4, 0
	sb $t4, 0($t3) 
       	la $a0, ansHexa5 
	li $v0, 4 
   	syscall 
   	
        la $a0, result5
	li $v0, 4 
       	syscall
       	
       	b mainB2H

hexToBin:	


	la $a0, str5
	li $v0, 4
	syscall

	li $v0, 8
	la $a0, inputNumberArray5
	li $a1, 100
	syscall
	
	j fromHexaStringToDecimal5

	b dec2bin5	
fromHexaStringToDecimal5:
   
    la   $t2, inputNumberArray5      
    li   $t8, 1                     
    li   $a0, 0                      
    j    hexaStringToDecimalLoop5

hexaStringToDecimalLoop5:
    lb   $t7, 0($t2)
    ble  $t7, '9', inputSub48_      
    addi $t7, $t7, -55             
    j    inputHexaNormalized5

inputHexaNormalized5:
    blt  $t7, $zero, dec2bin5 	
    li   $t6, 16                    
    mul  $a0, $a0, $t6             
    add  $a0, $a0, $t7             
    addi $t2, $t2, 1               
    j    hexaStringToDecimalLoop5

inputSub48_:
    addi $t7, $t7, -48              
    j    inputHexaNormalized5


dec2bin5:			
	
	add $t0, $0, $a0 	
	add $t1, $0, $0 	
	addi $t3, $0, 1 	
	sll $t3, $t3, 31 	
	addi $t4, $0, 32 	
	
	li $v0, 4		
	la $a0, ansBin 
	syscall
	li $t5, 0		
loop_d2b:
	and $t1, $t0, $t3 	
	beq $t1, $0, result_d2b	
	add $t1, $0, $0 	
	addi $t1, $0, 1 	

result_d2b:
	bge $t5, 1, print5	
	beq $t1, 0, skip_print	
	addiu $t5, $t5, 1	
	print5:
	li $v0, 1
	move $a0, $t1
	syscall
	skip_print:
	srl $t3, $t3, 1		 
	addi $t4, $t4, -1	
	bne $t4, $0, loop_d2b	
	b voltar2
        
.data
binario: .asciiz "Digite o numero Bin�rio: "
binary: .space 32  # Reserva espa�o na memoria
nova_linha: .asciiz "\n"
decimal: .space 16
Result1: .asciiz "Numero Binario introduzido: "
Result2: .asciiz "Resultado em Decimal: "
# Fun��o principal
.text
.globl bin_dec
bin_dec:
#Pedir o numero binario
li $v0,4  # codigo para immprimir string
la $a0,binario # carregar a string no $a0
syscall
# ler como string no $a0
la $a0, binary
li $a1, 16           
li $v0,8  # Ler a string   
syscall
#Imprimir o numero binario introduzido
la $a0,Result1
li $v0,4
syscall
la $a0,binary
li $v0, 4             
syscall
# chamar a fun��o para a convers�o
jal BtoD
#Fim do programa
exit:
li $v0, 10 # encerrao programa principal
syscall
BtoD:
# Obter o resultado
li $s0, 0            
#Acessar o valor binario em $t0
move $t0,$a0

li $t1, 16         
# Pegar cada byte
.globl Loop
Loop:
lb $a0, 0($t0)
blt $a0, 48, print
addi $t0, $t0, 1       
subi $a0, $a0, 48      
subi $t1, $t1, 1       
beq $a0, 0, Zero
beq $a0, 1, UM

Zero:
   j Loop
#Se for 1, ent�o desvio para esquerda e adicionamos no $5
UM:                 
   li $t2, 1             
   sllv $t3, $t2, $t1
   add $s0, $s0, $t3     
   j Loop
#Mostrar o resultado
print:
   srlv $s0, $s0, $t1
# Imprime o valor do Result2
    la $a0, Result2
    li $v0, 4
    syscall
#Imprimir decimal
    move $a0, $s0   
    li $v0, 1    #imprimir inteiro
    syscall
#return
   j voltar2

.data
msg: .asciiz "Digite o numero decimal: "
.text
decimal_binario:
li $v0, 4
la $a0, msg
syscall
li $v0, 5
syscall
add $t0, $zero, $v0
li $t1,7

ciclo:
blt $t1,0, ciclo_fim
srlv $t2, $t0, $t1
and $t2, 1

li $v0, 1
move $a0, $t2
syscall

sub $t1,$t1, 1
b ciclo

ciclo_fim:
li $v0, 10
j voltar2
syscall

# Convers�o decimal / Hexadecimal

# Pede numero decimal e converte para hexadecimal 
.data 
msg2: .asciiz "insira n�mero base 10 para converter em Hexadecimal: " 
resposta2: .asciiz "\n Equivalente Hexadecimal: " 
resultado2: .space 8 
.text 
.globl dec_hex
dec_hex: 
la $a0, msg2
li $v0, 4 
syscall 
li $v0, 5 
syscall 
move $t2, $v0 
la $a0, resposta2
li $v0, 4 
syscall 
li $t0, 8 # countador 
la $t3, resultado2
Loop3: 
beqz $t0, Exit3 # branch to exit se contador � igual a zero 
rol $t2, $t2, 4 # rodar 4 bits a esquerda 
and $t4, $t2, 0xf # mascara com 1111 
ble $t4, 9, Soma3 # se less than or equal to 9, branch tpara soma
addi $t4, $t4, 55 # se greater than 9, add 55 
b End 
Soma3: 
addi $t4, $t4, 48 # add 48 ao resultado 
End: 
sb $t4, 0($t3) # guarda o digito hexadecimal no resultado 
addi $t3, $t3, 1 # incrementa contador address 
addi $t0, $t0, -1 # decrementa contador loop 
j Loop3 
Exit3: 
la $a0, resultado2 
li $v0, 4 
syscall 
li $v0, 10 
j voltar2
syscall
.data
	tamanho_entrada: .space 100
	str1: .asciiz "Por favor introduza o seu valor hexadecimal em mai�sculas: "
	str2: .asciiz "O seu valor em decimal �: "
.text

.globl mainHex_Dec	# Fun��o global

mainHex_Dec:
la $a0, str1
li $v0, 4
syscall

li $v0, 8
la $a0, tamanho_entrada
li $a1, 100
syscall

j deHexStringParaDec

conversao_final: 

add $a1, $a0, $zero
la $a0, str2
li $v0, 4
syscall

add $a0, $a1, $zero
li $v0, 1
syscall

b voltar2

deHexStringParaDec:
    				
la   $t2, tamanho_entrada     
li   $t8, 1                     
li   $a0, 0                      
j    hexStringParaDecLoop

hexStringParaDecLoop:
lb   $t7, 0($t2)
ble  $t7, '9', inputSub48       
addi $t7, $t7, -55             
j    inputHexNormal

inputHexNormal:
blt  $t7, $zero, conversao_final 
li   $t6, 16                   
mul  $a0, $a0, $t6              
add  $a0, $a0, $t7              
addi $t2, $t2, 1                
j    hexStringParaDecLoop

inputSub48:
addi $t7, $t7, -48              
j    inputHexNormal


.data
mensagem: .asciiz "\nDigite um n�mero inteiro\n"
resposta: .asciiz "\nO n�mero fatorial do n�mero inserido �: "
.text


fatorial:
li $v0,4
la $a0,mensagem
syscall

li $v0,5
syscall
move $t0,$v0
li $t4,1 #Iniciar o t4 com 1
mult $t0,$t4 # n x 1
mflo $t3 # Guarda o resultado da multiplica��o
for:
ble $t0,1,imprime
sub $t0,$t0,1 #Decremento 1 a n
mult $t3,$t0 # Multiplica n decremento com o valor da ultima multiplica��o
mflo $t3 #guarda novamente o resultado em t3
b for

imprime:
li $v0,4
la $a0,resposta
syscall
li $v0,1
move $a0,$t3
syscall
j voltar

.data
frase:.asciiz "\n"
dois:.float 2 #2 com precis�o simples
.text

media:

li $v0,4# imprimir frase1
la $a0,frase
syscall

li $v0,6 # ler float do teclado
syscall

mov.s $f1,$f0 # guardar em $f1, n�mero com precis�o simples
li $v0, 4# imprimir frase2
la $a0,frase
syscall

li $v0,6 # ler o segundo float do teclado
syscall

add.s $f0, $f0,$f1 #somar os dois float's
l.s $f2, dois #carregar endere�o do numero 2 em float simples
div.s $f0,$f0,$f2 #divis�o por fp
li $v0,2 # imprimir float
mov.s $f12,$f0 # argumento de impress�o de float
syscall
j voltar


.data
SAÍDA: .ascii "\n A finalizar o programa"
.text
Sair:
la $a0,SAÍDA
li $v0, 4
#li $v0,10
syscall

