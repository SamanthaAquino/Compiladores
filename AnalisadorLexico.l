%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
    #include "AnalisadorSintatico.h"
%}


%%
"{"                        { return ABREC; }
"("                        { return ABREP; }   
"while"                    { return WHILE; }
"-"">""out"                { return ESCREVA; }
"}"                        { return FECHAC; }
")"                        { return FECHAP; }
"."                        { return FIMCOMANDO; }
"function"                 { return FUNCTION; }
"<""-""i"|"r"|"c""in"      { return LEIA; }
"="                        { return OPATRIBUICAO; }
"/"                        { return OPDIVISAO; }
","|";"                    { return OPLOGICO; }      /* Separar operadores lógicos e alterar (??) */
"%"                        { return OPMOD; }
"*"                        { return OPMULTIPLICACAO; }
"~"                        { return OPNEGACAO; }
":"                        { return OPCOMPARACAO; }
"<:"                       { return OPMENORIGUAL; }
">:"                       { return OPMAIORIGUAL; }
"<"                        { return OPMENOR; }
">"                        { return OPMAIOR; }
"~:"                       { return OPDIFERENTE; }
"+"                        { return OPSOMA; }
"-"                        { return OPSUBTRACAO; }
"|"                        { return PIPE; }
"send"                     { return SEND; }
"if"                       { return IF; }
[a-zA-Z]+([a-zA-Z][0-9])*  { strncpy(yylval.pont->nome, yytext, 256); return VARIAVEL; }    /* Tá certo? */
[0-9]+"."[0.9]+            { yylval.pont->val = atof(yytext); return REAL; }                /* Tá certo? */
[0-9]+                     { yylval.pont->tokint = atoi(yytext); return INTEIRO; }          /* Tá certo o "atoi()"? Antes estava atof() */

/* Estava sem " " antes. (??) */
i                        { return TIPOINT; }
r                        { return TIPOREAL; }
c                        { return TIPOCARACTERE; }


%%

int yywrap (void) {
	return 1;
}
