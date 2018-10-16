%{
	#include <stdio.h>
    #include "AnalisadorSintatico.h"
%}


numero [0-9]
abreC "{"
abreP "("
enquanto "while"
escreva "-"">""out"
exit "quit"
fechaC "}"
fechaP ")"
fimComando "."
funcao "function"
leia  "<""-""i"|"r"|"c""in"
letra [a-zA-Z]
nomeFuncao {letra}+
opAtribuicao "="
opDivisao "/"
opLogico ","|";"
opMod "%"
opMultiplicacao "*"
opNegacao "~"
    /*  opRelacional ":"|"<:"|">:"|"<"|">"|"~:"  */
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
senao "else"
tipo "i"|"r"|"c"
variavel {letra}({letra}|{numero})/*{0,7}*/



%%

{funcao}                 { printf("Funcao: %s\n", yytext); return FUNCTION; }
{tipo}                   { printf("Tipo: %s\n", yytext); /*yylval = strdup(yytext);*/ return TIPO; }
{nomeFuncao}             { printf("Nome Funcao: %s\n", yytext); return NOMEFUNCAO; }
{abreP}                  { printf("Parenteses: %s\n", yytext); return ABREP; }
{fechaP}                 { printf("Parenteses: %s\n", yytext); return FECHAP; }
{abreC}                  { printf("Chaves: %s\n", yytext); return ABREC; }
{enquanto}	             { printf("Comando: %s\n", yytext); return WHILE; }
{escreva}                { printf("Comando: %s\n", yytext); return ESCREVA; }
{exit}		             { printf("Comando: %s\n", yytext); return QUIT; }
{fimComando}             { printf("Fim de comando: %s\n", yytext); return FIMCOMANDO; }
{leia}                   { printf("Comando: %s\n", yytext); return LEIA; }
{opAtribuicao}           { printf("Operador Atribuicao: %s\n", yytext); return OPATRIBUICAO; }
{opDivisao}              { printf("Operador Divisao: %s\n", yytext); /*yylval = strdup(yytext);*/ return OPDIVISAO; }
{opLogico}               { printf("Operador Logico: %s\n", yytext); /*yylval = strdup(yytext);*/ return OPLOGICO; }
{opMod}                  { printf("Operador Resto Divisao: %s\n", yytext); /*yylval = strdup(yytext);*/ return OPMOD; }
{opMultiplicacao}        { printf("Operador Multiplicacao: %s\n", yytext); /*yylval = strdup(yytext);*/ return OPMULTIPLICACAO; }
{opNegacao}              { printf("Operador Negacao: %s\n", yytext); return OPNEGACAO; }
/* {opRelacional}           { printf("Operador Relacional: %s\n", yytext); return OPRELACIONAL; } */
{opComparacao}           { printf("Operador Comparacao: %s\n", yytext); return OPCOMPARACAO; }
{opMenorIgual}           { printf("Operador Menor ou Igual: %s\n", yytext); return OPMENORIGUAL; }
{opMaiorIgual}           { printf("Operador Maior ou Igual: %s\n", yytext); return OPMAIORIGUAL; }
{opMenor}                { printf("Operador Menor Que: %s\n", yytext); return OPMENOR; }
{opMaior}                { printf("Operador Maior Que: %s\n", yytext); return OPMAIOR; }
{opDiferente}            { printf("Operador Diferente de: %s\n", yytext); return OPDIFERENTE; }
{opSoma}                 { printf("Operador Soma: %s\n", yytext); /*yylval = strdup(yytext);*/ return OPSOMA; }
{opSubtracao}            { printf("Operador Subtracao: %s\n", yytext); /*yylval = strdup(yytext);*/ return OPSUBTRACAO; }
{pipe}                   { printf("Pipe: %s\n", yytext); return PIPE; }
{real}          	     { printf("Real: %s\n", yytext); return REAL; }
{returrn}                { printf("Comando: %s\n", yytext); return SEND; }
{se}		             { printf("Comando: %s\n", yytext); return IF; }
{senao}		             { printf("Comando: %s\n", yytext); return ELSE; }
{variavel}               { printf("Variavel: %s\n", yytext); return VARIAVEL; }
{numero}+ 	             { printf("Numero Inteiro: %s\n", yytext); return INTEIRO; }
{fechaC}                 { printf("Chaves: %s\n", yytext); return FECHAC; }

%%
