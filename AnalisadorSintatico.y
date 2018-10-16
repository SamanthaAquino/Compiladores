%{
    #include <stdio.h>
    #include <string.h>
    #include "AnalisadorSintatico.h"

    void yyerror(const char *str)
    {
        fprintf(stderr, "error: %s\n", str);
    }

    int yywrap() { return 1; }
    int main()   { yyparse(); }
%}


%token ABREC
%token ABREP
%token ESCREVA
%token FECHAC
%token FECHAP
%token FIMCOMANDO
%token FUNCTION
%token IF
%token INTEIRO 
%token LEIA
%token OPATRIBUICAO
%token OPDIVISAO
%token OPLOGICO
%token OPMOD
%token OPMULTIPLICACAO
%token OPNEGACAO
%token OPRELACIONAL
%token OPSOMA
%token OPSUBTRACAO
%token PIPE
%token REAL
%token SEND
%token VARIAVEL
%token WHILE
%token CARACTERE

%%

    S: FUNCTION tipo VARIAVEL ABREP param FECHAP ABREC corpo retorna FECHAC

    tipo: INTEIRO
            | REAL
            | CARACTERE

    param:
            | tipo VARIAVEL
            | PIPE

    corpo: declaracao
            | algoritmo

    declaracao:
            | tipo VARIAVEL FIMCOMANDO

    algoritmo: 
            | aritmetica
            | condicional
            | repeticao
            | entrada
            | saida

    aritmetica: VARIAVEL OPATRIBUICAO expressao FIMCOMANDO

    expressao: VARIAVEL
            | VARIAVEL OPSOMA VARIAVEL
            | INTEIRO OPSOMA VARIAVEL
            | VARIAVEL OPSOMA INTEIRO
            | REAL OPSOMA VARIAVEL
            | VARIAVEL OPSOMA REAL
            | INTEIRO OPSOMA INTEIRO
            | REAL OPSOMA REAL
            
            | VARIAVEL OPSUBTRACAO VARIAVEL
            | INTEIRO OPSUBTRACAO VARIAVEL
            | VARIAVEL OPSUBTRACAO INTEIRO
            | REAL OPSUBTRACAO VARIAVEL
            | VARIAVEL OPSUBTRACAO REAL
            | INTEIRO OPSUBTRACAO INTEIRO
            | REAL OPSUBTRACAO REAL
            
            | VARIAVEL OPMULTIPLICACAO VARIAVEL
            | INTEIRO OPMULTIPLICACAO VARIAVEL
            | VARIAVEL OPMULTIPLICACAO INTEIRO
            | REAL OPMULTIPLICACAO VARIAVEL
            | VARIAVEL OPMULTIPLICACAO REAL
            | INTEIRO OPMULTIPLICACAO INTEIRO
            | REAL OPMULTIPLICACAO REAL
            
            | VARIAVEL OPDIVISAO VARIAVEL
            | INTEIRO OPDIVISAO VARIAVEL
            | VARIAVEL OPDIVISAO INTEIRO
            | REAL OPDIVISAO VARIAVEL
            | VARIAVEL OPDIVISAO REAL
            | INTEIRO OPDIVISAO INTEIRO
            | REAL OPDIVISAO REAL
            
            | VARIAVEL OPMOD VARIAVEL
            | INTEIRO OPMOD VARIAVEL
            | VARIAVEL OPMOD INTEIRO
            | REAL OPMOD VARIAVEL
            | VARIAVEL OPMOD REAL
            | INTEIRO OPMOD INTEIRO
            | REAL OPMOD REAL

    condicional: IF ABREP compara FECHAP ABREC algoritmo FECHAC

    repeticao: WHILE ABREP compara FECHAP ABREC algoritmo FECHAC

    compara: 
            | VARIAVEL comp VARIAVEL
            | OPNEGACAO VARIAVEL
            | PIPE

    comp: OPRELACIONAL
            | OPLOGICO

    entrada: LEIA VARIAVEL FIMCOMANDO

    saida: VARIAVEL ESCREVA FIMCOMANDO

    retorna: SEND VARIAVEL
            | SEND INTEIRO
            | SEND REAL
            | SEND CARACTERE

%%
