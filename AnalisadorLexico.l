%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
    #include "AnalisadorSintatico.h"
%}


%%
numero [0-9]   /* consertar */
abreC "{"
abreP "("
enquanto "while"
escreva "-"">""out"
fechaC "}"
fechaP ")"
fimComando "."
funcao "function"
leia  "<""-""i"|"r"|"c""in"
letra [a-zA-Z]
opAtribuicao "="
opDivisao "/"
opLogico ","|";"
opMod "%"
opMultiplicacao "*"
opNegacao "~"
opComparacao ":"
opMenorIgual "<:"
opMaiorIgual ">:"
opMenor "<"
opMaior ">"
opDiferente "~:"
opSoma "+"
opSubtracao "-"
pipe "|"
real {numero}+"."{numero}+
returrn "send"
se "if"
variavel {letra}({letra}|{numero}){0,7}
tipoInt  i
tipoReal  r
tipoCaractere  c



%%

{tipoInt}                { printf("Tipo Inteiro: %s\n", yytext); return TIPOINT; }
{tipoReal}               { printf("Tipo Real: %s\n", yytext); return TIPOREAL; }
{tipoCaractere}          { printf("Tipo Caractere: %s\n", yytext); return TIPOCARACTERE; }
{funcao}                 { printf("Funcao: %s\n", yytext); return FUNCTION; }
{abreP}                  { printf("Parenteses: %s\n", yytext); return ABREP; }
{fechaP}                 { printf("Parenteses: %s\n", yytext); return FECHAP; }
{abreC}                  { printf("Chaves: %s\n", yytext); return ABREC; }
{enquanto}	         { printf("Comando: %s\n", yytext); return WHILE; }
{escreva}                { printf("Comando: %s\n", yytext); return ESCREVA; }
{fimComando}             { printf("Fim de comando: %s\n", yytext); return FIMCOMANDO; }
{leia}                   { printf("Comando: %s\n", yytext); return LEIA; }
{opAtribuicao}           { printf("Operador Atribuicao: %s\n", yytext); return OPATRIBUICAO; }
{opDivisao}              { printf("Operador Divisao: %s\n", yytext); return OPDIVISAO; }
{opLogico}               { printf("Operador Logico: %s\n", yytext); return OPLOGICO; }
{opMod}                  { printf("Operador Resto Divisao: %s\n", yytext); return OPMOD; }
{opMultiplicacao}        { printf("Operador Multiplicacao: %s\n", yytext); return OPMULTIPLICACAO; }
{opNegacao}              { printf("Operador Negacao: %s\n", yytext); return OPNEGACAO; }
{opComparacao}           { printf("Operador Comparacao: %s\n", yytext); return OPCOMPARACAO; }
{opMenorIgual}           { printf("Operador Menor Igual: %s\n", yytext); return OPMENORIGUAL; }
{opMaiorIgual}           { printf("Operador Maior Igual: %s\n", yytext); return OPMAIORIGUAL; }
{opMenor}                { printf("Operador Menor: %s\n", yytext); return OPMENOR; }
{opMaior}                { printf("Operador Maior: %s\n", yytext); return OPMAIOR; }
{opDiferente}            { printf("Operador Diferente de: %s\n", yytext); return OPDIFERENTE; }
{opSoma}                 { printf("Operador Soma: %s\n", yytext); return OPSOMA; }
{opSubtracao}            { printf("Operador Subtracao: %s\n", yytext); return OPSUBTRACAO; }
{pipe}                   { printf("Pipe: %s\n", yytext); return PIPE; }
{real}          	 { printf("Real: %s\n", yytext); return REAL; }
{returrn}                { printf("Comando: %s\n", yytext); return SEND; }
{se}		         { printf("Comando: %s\n", yytext); return IF; }
{variavel}               { printf("Variavel: %s\n", yytext); return VARIAVEL; }
{numero}+ 	         { printf("Numero Inteiro: %s\n", yytext); return INTEIRO; }
{fechaC}                 { printf("Chaves: %s\n", yytext); return FECHAC; }
{letra}                  { printf("Caractere: %s\n", yytext); return CARACTERE; }
%%

/*
int yywrap (void) {
	return 1;
}
*/
