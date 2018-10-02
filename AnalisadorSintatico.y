%{
#include <stdio.h>
#include <string.h>

void yyerror(const char *str) { fprintf(stderr, "error: %s\n", str); }

int yywrap() { return 1; }

int main() { yyparse(); }

%}

%token ABREC
%token ABREP
%token ELSE
%token ESCREVA
%token FECHAC
%token FECHAP
%token FIMCOMANDO
%token FUNCTION
%token IF
%token INTEIRO 
%token LEIA
%token NOMEFUNCAO
%token OPATRIBUICAO
%token OPERADORES
%token OPLOGICO
%token OPNEGACAO
%token OPRELACIONAL
%token PIPE
%token QUIT
%token REAL
%token SEND
%token TIPO
%token VARIAVEL
%token WHILE

%%

    S:FUNCTION TIPO NOMEFUNCAO ABREP param FECHAP ABREC CORPO returrn FECHAC;
    param:TIPO VARIAVEL
           | TIPO VARIAVEL PIPE param 
	   | ;
    CORPO: declaracao algoritmo;
    declaracao: TIPO VARIAVEL FIMCOMANDO
		              ;
    algoritmo: expressao algoritmo FIMCOMANDO 
              | comando algoritmo FIMCOMANDO 
              | ;
    expressao: aritmetica | logica;
    aritmetica: ABREP aritmetica2 FECHAP
                 | aritmetica2;
    aritmetica2: VARIAVEL OPERADORES VARIAVEL
                  | INTEIRO OPERADORES VARIAVEL
                  | VARIAVEL OPERADORES INTEIRO
                  | INTEIRO OPERADORES INTEIRO
                  | REAL OPERADORES VARIAVEL
                  | VARIAVEL OPERADORES REAL
                  | REAL OPERADORES REAL
                  | VARIAVEL
                  | REAL
                  | INTEIRO;

    logica: OPNEGACAO logica | relacional | logica OPLOGICO logica;
    // negacao : OPNEGACAO logica;
    relacional: aritmetica2 OPRELACIONAL aritmetica2;
    comando: atribuicao | entrada | saida | condicional | repeticao;
    atribuicao: VARIAVEL OPATRIBUICAO expressao;
    entrada: LEIA VARIAVEL;
    saida: ESCREVA saida2;
    //Apagamos mensagem vv
    saida2:  VARIAVEL
            | 
            ;
    condicional: IF ABREP logica FECHAP ABREC algoritmo FECHAC
                  | IF ABREP logica FECHAP ABREC algoritmo FECHAC ELSE ABREC algoritmo FECHAC;
    repeticao: WHILE ABREP logica FECHAP ABREC algoritmo FECHAC
                  | WHILE ABREP logica FECHAP ABREC algoritmo QUIT FECHAC;

    returrn: SEND aritmetica2
              | SEND NOMEFUNCAO ABREP param FECHAP;
    
%%
