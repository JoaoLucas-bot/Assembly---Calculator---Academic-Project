####################################################################################################################################
# PROJETO DE ARQUITETURA DE COMPUTADORES 2021/2022 - UAL
# TEMA: Calculadora Científica
# Fase: 2
# GRUPO:
# 30002232 Paulo Correia
# 30008290 Eduardo Araujo
# 30008215 João Lucas
# 30008241 Pedro Amaral
#####################################################################################################################################

.data
operacoes: .asciiz "\n\nEscolha uma operação: \n 1-Potência \n 2-Raíz \n 3-Logaritmo \n 4-Trigonométrica \n 0-Sair do programa\n"
msg_op: .asciiz ">"
resultado: .asciiz "O resultado da sua operação é: "

.text

main: 
li $v0, 4  #Comando para imprimir uma string
la $a0,operacoes #Imprime as opções da calculadora
syscall #chamada do sistema

escolhas:
li $v0, 4
la $a0,msg_op
syscall
li $v0,5 # input de inteiro
syscall 
beq $v0, 1, potencia
beq $v0, 2, raiz
beq $v0, 3, logaritmo
beq $v0, 4, trig
beq $v0, 0, Sair


.data
msg_resultado:.asciiz "Resultado: "
msg_potencia:.asciiz "\nIntroduza primeiro a base e depois o expoente\n"
.text

# t0=numero atual, t1=base, t2= expoente

potencia:
li $v0, 4
la $a0, msg_potencia
syscall
li $v0, 5		#leitura de inteiro
syscall			#chamada do sistema
move $t1, $v0		#move o input de v0 para t1
li $v0, 5		#leitura de inteiro
syscall			#chamada do sistema
move $t2, $v0		#copia v0 em t2
move $t0, $t1		#copia t1 no t0
	
potencia_loop:	
beq $t2, 1, potencia_fim	# se t2 for maior que 1, ele realiza a multiplicacao, senão, ele pula para o fim da rotina
mul $t0, $t0, $t1	#mulltiplica t2 vezes t1/ t0= t0 * t1
sub $t2, $t2, 1 	#t2 diminui
j potencia_loop		#pula para o inicio da operaçaao
	
potencia_fim:	
la $a0, msg_resultado
li $v0, 4
syscall
move $a0, $t0		#copia t0 (resultado) em a0
li $v0, 1		#comando para impressao de um inteiro
syscall			#chamada do sistema
j main			#pula de volta para a main


###############################################################################

#metodo de newton para a obtencao de raizes quadradas sqrt(a)= (a+x^2)/2x
#t0 = a, t7=x^2, t9=x
.data
msg_raiz: .asciiz "\n Introduza um numero:\n"
msg_result: .asciiz "\nResultado: \n"
.text
raiz:	
la $a0, msg_raiz
li $v0, 4
syscall
li $v0, 5		#leitura de inteiro
syscall			#chamada do sistema
move $t0, $v0		#move o input de v0 para t0
li $t7, 0		#auxiliar para a função get x
li $t8, 1		#auxiliar para a função get x
li $t9, 0		#contador para a função get x

#get x: encontra a raiz perfeita mais proxima de a atraves da soma dos a primeiros impares

getx:	
la $a0,msg_result
li $v0, 4
syscall
add $t7, $t7, $t8	#adiciona o impar na soma total em t7
add $t9, $t9, 1		#incrementa o contador
add $t8, $t8, 2		#leva t8 para o proximo impar, adicionando 2
bgt $t0, $t7, getx	#caso t0 seja maior que t7, a funcao recomeça
	
add $t7, $t7, $t0	#t7 = t7 + t0 = x^2 + a
mul $t9, $t9, 2		#t9 = t9*2 = 2x
	
mtc1 $t7, $f12		#move t0 para f12 (integer to float)
cvt.s.w $f12, $f12	# converte de inteiro para float
	
mtc1 $t9, $f13 		#move t7 para f13
cvt.s.w $f13, $f13	#converte int para float
	
div.s $f12, $f12, $f13	#f12 = f12/f13 = sqrt(a)
	
li $v0, 2   		#comando para imprimir float
syscall			#chamada do sistema
j main			#jump para o label 
#######################################################################################################################################
.data

pedido: .asciiz "Introduza o numero: "
result_2: .asciiz "\nlog2(x): "
result_10: .asciiz "\nlog10(x):  "

.text

logaritmo:

#Input do pedido
li $v0, 4
la $a0, pedido
syscall

#Carrega o float
li $v0, 6
syscall
mov.s $f12, $f0
mov.s $f3, $f0

# Chamada da função
jal log2

# Imprimir o resultado
li $v0, 4
la $a0, result_2
syscall

# Imprimir log2(x)
li $v0, 2
mov.s $f12, $f0
syscall


mov.s $f12, $f3
# Chamada da função
jal log10

# Imprimir resultado
li $v0, 4
la $a0, result_10
syscall

# Imprimir log10(x)
li $v0, 2
mov.s $f12, $f0
syscall


# Código de saída
li $v0, 10
j main
syscall

lnx:

#Inicio dos registos
li $t1, 1000

# converter 1 para float
li $t5, 1
mtc1 $t5, $f5
cvt.s.w $f5, $f5

#Guardar o valor introduzido
mov.s $f4, $f12	#x
sub.s $f4, $f4, $f5
add.s $f6, $f12, $f5
div.s $f4, $f4, $f6	#t = (x-1)/(x+1)

mul.s $f9, $f4, $f4 #n = t*t

mov.s $f10, $f4	#sum = t


#Counter
li $t0, 3

#Loop
Ciclo:

# Verificar a condição
bge $t0, $t1, Ciclo_S


# t = t * n
mul.s $f4, $f4, $f9

# converter $t0 para float
mtc1 $t0, $f7
cvt.s.w $f7, $f7

# atualizar a soma em  ($f10)
div.s $f6, $f4, $f7	#t/i
add.s $f10, $f10, $f6

addi $t0, $t0, 2


# Voltar para o inicio do ciclo
j Ciclo

#Sair do Loop
Ciclo_S:

#Passar valor
add.s $f10, $f10, $f10
mov.s $f0, $f10

#Voltar para a função principal
jr $ra
syscall


log2:
addi $sp, $sp, -4
sw $ra, 0($sp)

jal lnx		#chamar função ln (x)
mov.s $f1, $f0	#Guardar ln(x) em $f1

lw $ra, 0($sp)
addi $sp, $sp, 4

# converter 2 para float
li $t5, 2		
mtc1 $t5, $f12
cvt.s.w $f12, $f12	

addi $sp, $sp, -4
sw $ra, 0($sp)

jal lnx		#chamar função para calcular ln(2)
mov.s $f2, $f0	#Guardar ln(2) em $f2

lw $ra, 0($sp)
addi $sp, $sp, 4

div.s $f0, $f1, $f2	#log2(x) = ln(x)/ln(2)
jr $ra

log10:

addi $sp, $sp, -4
sw $ra, 0($sp)

jal lnx		#Chamar a função ln (x)
mov.s $f1, $f0	#Guardar ln(x) em $f1

lw $ra, 0($sp)
addi $sp, $sp, 4

# converter 2 para float
li $t5, 10		
mtc1 $t5, $f12
cvt.s.w $f12, $f12	

addi $sp, $sp, -4
sw $ra, 0($sp)

jal lnx		#chamar função para calcular ln(2)
mov.s $f2, $f0	#Guardar ln(10) in $f2

lw $ra, 0($sp)
addi $sp, $sp, 4

div.s $f0, $f1, $f2	#log10(x) = ln(x)/ln(10)
jr $ra
syscall


#######################################################################################################################
.data
msg_trig:.asciiz "\n 1-Seno 2-Cosseno\n"
.text
trig:
la $a0, msg_trig
li $v0, 4
syscall
li $v0, 5
syscall
beq $v0,1,sen
beq $v0,2,cos


# Calculo de senos
.data
prompt1: .asciiz "Programa que calcula sen(x) em radianos até 2PI. \n\Insira o valor de x!\n\n Ângulo = "
float1: .float 0.000001

.text
.globl sen
sen:
li $t0,3 # Initilizar n
l.s $f4,float1# precisão
li $v0,4 # syscall para imprimir string
la $a0, prompt1 # carregar endereço da prompt
syscall # imprimr a prompt
li $v0,6 # ler float do teclado para $f0
syscall
b seno
seno:
mul.s $f2,$f0,$f0 # x^2
mov.s $f12,$f0 # impressão de float deve estar em $f12
for:
abs.s $f1,$f0 # Compara com valor não negativo da série
c.lt.s $f1,$f4 # numero < que 0.000001?
bc1t endfor
subu $t1,$t0,1 # (n-1)
mul $t1,$t1,$t0 # n(n-1)
mtc1 $t1, $f3 # move n(n-1) para registo floating
cvt.s.w $f3, $f3 # converte n(n-1) num float
div.s $f3,$f2,$f3 # (x^2)/(n(n-1))
neg.s $f3,$f3 # -(x^2)/(n(n-1))
mul.s $f0,$f0,$f3 # (Serie*x^2)/(n(n-1))
add.s $f12,$f12,$f0 # resposta em $f12
addu $t0,$t0,2 # Incrementa n
b for # Gvai para início do loop for
endfor:
li $v0,2 # imprime resposta em $f12
syscall
li $v0,10 # codigo 10 == terminar
j main
syscall # termina

####################################################################################################################################

# Cálculo de cosenos pelo algoritmo dos senos
.data
prompt2: .asciiz "Programa que calcula cos(x) em radianos até 2PI. \n\Insira o valor de x!\n\n Ângulo = "
erro:.asciiz "\n\no valor tem de ser menor que 2PI\n"
resultadoo:.asciiz " Cosseno = " 
float: .float 0.000001
float_pi_2:.float 1.5708
float_pi:.float 3.14159
float_3pi_2:.float 4.71239
float_5pi_2:.float 7.85398
float_2pi:.float 6.28319
.text
.globl cos
cos:
li $t0,3 # Initilizar n
l.s $f4,float1# precisão
li $v0,4 # syscall para imprimir string
la $a0, prompt2 # carregar endereço da prompt
syscall # imprimr a prompt
li $v0,6 # ler float do teclado para $f0
syscall
l.s $f6,float_pi_2
c.le.s $f0,$f6
bc1t primeiro
l.s $f6,float_pi
c.le.s $f0,$f6
bc1t segundo
l.s $f6,float_3pi_2
c.le.s $f0,$f6
bc1t terceiro
l.s $f6,float_2pi
c.le.s $f0,$f6
bc1t quarto
la $a0,erro
li $v0,48
syscall
b end
quarto:
l.s $f6,float_5pi_2
sub.s $f0,$f6,$f0
b senoo
terceiro:
l.s $f6,float_5pi_2
sub.s $f0,$f6,$f0
b seno
segundo:
l.s $f6,float_pi_2
add.s $f0,$f6,$f0
b senoo
primeiro:
sub.s $f0,$f6,$f0
b senoo
senoo:
mul.s $f2,$f0,$f0 # x^2
mov.s $f12,$f0 # impressão de float deve estar em $f12
forr:
abs.s $f1,$f0 # Compara com valor não negativo da série
c.lt.s $f1,$f4 # numero < que 0.000001?
bc1t endforr
subu $t1,$t0,1 # (n-1)
mul $t1,$t1,$t0 # n(n-1)
mtc1 $t1, $f3 # move n(n-1) para registo floating
cvt.s.w $f3, $f3 # converte n(n-1) num float
div.s $f3,$f2,$f3 # (x^2)/(n(n-1))
neg.s $f3,$f3 # -(x^2)/(n(n-1))
mul.s $f0,$f0,$f3 # (Serie*x^2)/(n(n-1))
add.s $f12,$f12,$f0 # resposta em $f12
addu $t0,$t0,2 # Incrementa n
b forr # vai para início do loop for
endforr:
la $a0,resultadoo
li $v0,4
syscall
li $v0,2 # imprime resposta em $f12
syscall
b end
end:
li $v0,10 # codigo 10 == terminar
j main
syscall # termina

.data
SAÍDA: .ascii "A finalizar o programa"
.text
Sair:
la $a0,SAÍDA
li $v0, 4
#li $v0,10
syscall
