%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>

	#include "AnalisadorSintatico.h"
    #include "AnalisadorSintatico.tab.h"
%}

%%
"{"                        { printf("Abre Chaves: %s\n", yytext); return ABREC; }
"("                        { printf("Abre Parenteses: %s\n", yytext); return ABREP; }   
"while"                    { printf("While: %s\n", yytext); return WHILE; }
"out"                      { printf("Out: %s\n", yytext); return ESCREVA; }
"}"                        { printf("Fecha Chaves: %s\n", yytext); return FECHAC; }
")"                        { printf("Fecha Parenteses: %s\n", yytext); return FECHAP; }
"."                        { printf("Fim de Comando: %s\n", yytext); return FIMCOMANDO; }
"function"                 { printf("Funcao: %s\n", yytext); return FUNCTION; }
"in"      				   { printf("Lê: %s\n", yytext); return LEIA; }
"="                        { printf("Atribuicao: %s\n", yytext); return OPATRIBUICAO; }
"/"                        { printf("Divisao: %s\n", yytext); return OPDIVISAO; }
","|";"                    { printf("Logica: %s\n", yytext); return OPLOGICO; }      /* Separar operadores lógicos e alterar (??) */
"%"                        { printf("Resto da Div: %s\n", yytext); return OPMOD; }
"*"                        { printf("Multiplicacao: %s\n", yytext); return OPMULTIPLICACAO; }
"~"                        { printf("Negacao: %s\n", yytext); return OPNEGACAO; }
":"                        { printf("Comparacao: %s\n", yytext); return OPCOMPARACAO; }
"<:"                       { printf("Menor Igual: %s\n", yytext); return OPMENORIGUAL; }
">:"                       { printf("Maior Igual: %s\n", yytext); return OPMAIORIGUAL; }
"<"                        { printf("Menor: %s\n", yytext); return OPMENOR; }
">"                        { printf("Maior: %s\n", yytext); return OPMAIOR; }
"~:"                       { printf("Diferente: %s\n", yytext); return OPDIFERENTE; }
"+"                        { printf("Soma: %s\n", yytext); return OPSOMA; }
"-"                        { printf("Subtracao: %s\n", yytext); return OPSUBTRACAO; }
"|"                        { printf("Pipe: %s\n", yytext); return PIPE; }
"send"                     { printf("Send: %s\n", yytext); return SEND; }
"if"                       { printf("Condicional: %s\n", yytext); return IF; }
"i"                        { printf("Tipo-Inteiro: %s\n", yytext); return TIPOINT; }
"r"                        { printf("Tipo-Real: %s\n", yytext); return TIPOREAL; }
"c"                        { printf("Tipo-Caractere: %s\n", yytext); return TIPOCARACTERE; }
[a-zA-Z]+([a-zA-Z][0-9])*  { printf("Tipo de Dado: %s\n", yytext); strncpy(yylval.pont->nome, yytext, 256); return VARIAVEL; }    
[0-9]+("."[0.9]+)?         { printf("Tipo de Dado: %s\n", yytext); yylval.pont->val = atof(yytext); return REAL; }                
[0-9]+                     { printf("Tipo de Dado: %s\n", yytext); yylval.pont->tokint = atoi(yytext); return INTEIRO; }          

%%

int yywrap (void) {
	return 1;
}
