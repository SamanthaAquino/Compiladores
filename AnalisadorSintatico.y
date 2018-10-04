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
%token OPDIVISAO
%token OPLOGICO
%token OPMOD
%token OPMULTIPLICACAO
%token OPNEGACAO
%token OPRELACIONAL
%token OPSOMA
%token OPSUBTRACAO
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

    declaracao: TIPO VARIAVEL FIMCOMANDO;

    algoritmo: expressao algoritmo FIMCOMANDO 
                  | comando algoritmo FIMCOMANDO 
                  | ;

    expressao: aritmetica | logica;

    aritmetica: ABREP aritmetica2 FECHAP
                  | aritmetica2;

    aritmetica2:  VARIAVEL OPDIVISAO VARIAVEL          {$$ = $1 / $3;}
                  | INTEIRO OPDIVISAO VARIAVEL         {$$ = $1 / $3;}
                  | VARIAVEL OPDIVISAO INTEIRO         {$$ = $1 / $3;}
                  | INTEIRO OPDIVISAO INTEIRO          {$$ = $1 / $3;}
                  | REAL OPDIVISAO VARIAVEL            {$$ = $1 / $3;}
                  | VARIAVEL OPDIVISAO REAL            {$$ = $1 / $3;}
                  | REAL OPDIVISAO REAL                {$$ = $1 / $3;}
                  | VARIAVEL OPMOD VARIAVEL            {$$ = $1 % $3;}
                  | INTEIRO OPMOD VARIAVEL             {$$ = $1 % $3;}
                  | VARIAVEL OPMOD INTEIRO             {$$ = $1 % $3;}
                  | INTEIRO OPMOD INTEIRO              {$$ = $1 % $3;}
                  | REAL OPMOD VARIAVEL                {$$ = $1 % $3;}
                  | VARIAVEL OPMOD REAL                {$$ = $1 % $3;}
                  | REAL OPMOD REAL                    {$$ = $1 % $3;}
                  | VARIAVEL OPMULTIPLICACAO VARIAVEL  {$$ = $1 * $3;}
                  | INTEIRO OPMULTIPLICACAO VARIAVEL   {$$ = $1 * $3;}
                  | VARIAVEL OPMULTIPLICACAO INTEIRO   {$$ = $1 * $3;}
                  | INTEIRO OPMULTIPLICACAO INTEIRO    {$$ = $1 * $3;}
                  | REAL OPMULTIPLICACAO VARIAVEL      {$$ = $1 * $3;}
                  | VARIAVEL OPMULTIPLICACAO REAL      {$$ = $1 * $3;}
                  | REAL OPMULTIPLICACAO REAL          {$$ = $1 * $3;}
                  | VARIAVEL OPSOMA VARIAVEL           {$$ = $1 + $3;}
                  | INTEIRO OPSOMA VARIAVEL            {$$ = $1 + $3;}
                  | VARIAVEL OPSOMA INTEIRO            {$$ = $1 + $3;}
                  | INTEIRO OPSOMA INTEIRO             {$$ = $1 + $3;}
                  | REAL OPSOMA VARIAVEL               {$$ = $1 + $3;}
                  | VARIAVEL OPSOMA REAL               {$$ = $1 + $3;}
                  | REAL OPSOMA REAL                   {$$ = $1 + $3;}
                  | VARIAVEL OPSUBTRACAO VARIAVEL      {$$ = $1 - $3;}
                  | INTEIRO OPSUBTRACAO VARIAVEL       {$$ = $1 - $3;}
                  | VARIAVEL OPSUBTRACAO INTEIRO       {$$ = $1 - $3;}
                  | INTEIRO OPSUBTRACAO INTEIRO        {$$ = $1 - $3;}
                  | REAL OPSUBTRACAO VARIAVEL          {$$ = $1 - $3;}
                  | VARIAVEL OPSUBTRACAO REAL          {$$ = $1 - $3;}
                  | REAL OPSUBTRACAO REAL              {$$ = $1 - $3;}
                  | VARIAVEL                           {$$ = $1 ;}
                  | REAL                               {$$ = $1 ;}
                  | INTEIRO                            {$$ = $1 ;} ;

    logica: OPNEGACAO logica | relacional | logica OPLOGICO logica;
    // negacao : OPNEGACAO logica;

    relacional: aritmetica2 OPRELACIONAL aritmetica2;

    comando: atribuicao | entrada | saida | condicional | repeticao;

    atribuicao: VARIAVEL OPATRIBUICAO expressao;

    entrada: LEIA VARIAVEL;

    saida: ESCREVA saida2;
    //Apagamos mensagem vv

    saida2:  VARIAVEL
                | ;

    condicional: IF ABREP logica FECHAP ABREC algoritmo FECHAC
                | IF ABREP logica FECHAP ABREC algoritmo FECHAC ELSE ABREC algoritmo FECHAC;

    repeticao: WHILE ABREP logica FECHAP ABREC algoritmo FECHAC
                | WHILE ABREP logica FECHAP ABREC algoritmo QUIT FECHAC;

    returrn: SEND aritmetica2
                | SEND NOMEFUNCAO ABREP param FECHAP;
    
%%
