%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>
	#include "AnalisadorSintatico.h"

	void yyerror(const char *str)
	{
		fprint(stderr, "error: %s\n",str);
	}

No *root;
%}

%union{
	No *pont;
}

%token <pont> FUNCTION
%token <pont> IF
%token <pont> INTEIRO
%token <pont> REAL

%token <pont> WHILE
%token <pont> VARIAVEL

%token <pont> ESCREVA
%token <pont> LEIA
%token <pont> ABREC
%token <pont> FECHAC
%token <pont> ABREP
%token <pont> FECHAP
%token <pont> PIPE
%token <pont> SEND
%token <pont> FIMCOMANDO

%token <pont> TIPOINT
%token <pont> TIPOREAL
%token <pont> TIPOCARACTERE

%token <pont> OPLOGICO
%token <pont> OPNEGACAO
%token <pont> OPCOMPARACAO
%token <pont> OPMENORIGUAL
%token <pont> OPMAIORIGUAL
%token <pont> OPMAIOR
%token <pont> OPMENOR
%token <pont> OPDIFERENTE
%token <pont> OPATRIBUICAO
%token <pont> OPSUBTRACAO
%token <pont> OPSOMA
%token <pont> OPMULTIPLICACAO
%token <pont> OPDIVISAO
%token <pont> OPMOD

%type <pont> S
%type <pont> funcao
%type <pont> var
%type <pont> tipo
%type <pont> param
%type <pont> corpo
%type <pont> declaracao
%type <pont> algoritmo
%type <pont> aritmetica
%type <pont> expressao
%type <pont> condicional
%type <pont> repeticao
%type <pont> compara
%type <pont> entrada
%type <pont> paramEntrada
%type <pont> saida
%type <pont> paramSaida
%type <pont> retorna

%right OPATRIBUICAO
%left OPSUBTRACAO OPSOMA
%left OPMULTIPLICACAO OPDIVISAO
%left OPMOD

%%

	S: funcao {root = $1;};

	funcao: FUNCTION tipo var ABREP param FECHAP ABREC corpo retorna FECHAC
			{
				$$ = (No*)malloc(sizeof(No));
				$$->token = FUNCTION;
				$$->lookahead = $2;
				$$->lookahead1 = $3;
				$$->lookahead2 = $5;
				$$->lookahead3 = $8;
				$$->esq = $9;
				$$->dir = NULL;
			};

	var: VARIAVEL
	    {
	    	$$ = (No*)malloc(sizeof(No));
	    	$$->token = VARIAVEL;
	    	$$->esq = NULL;
	    	$$->dir = NULL;
	    };

	tipo: TIPOINT
		{
			$$ = (No*)malloc(sizeof(No));
			$$->token = TIPOINT;
			$$->esq = NULL;
			$$->dir = NULL;
		}
		|TIPOREAL
		{
			$$ = (No*)malloc(sizeof(No));
			$$->token = TIPOREAL;
			$$->esq = NULL;
			$$->dir = NULL;
		}
		| TIPOCARACTERE
		{
			$$ = (No*)malloc(sizeof(No));
			$$->token = TIPOCARACTERE;
			$$->esq = NULL;
			$$->dir = NULL;
		};

	param: tipo var
		 | PIPE
         |;

    corpo: declaracao
    	 | algoritmo;

    declaracao: tipo var FIMCOMANDO

    algoritmo: aritmetica
    		 | condicional
    		 | repeticao
    		 | entrada
    		 | saida
             |;

    aritmetica: var OPATRIBUICAO expressao FIMCOMANDO
    			{
    				$$ = (No*)malloc(sizeof(No));
    				$$->token = OPATRIBUICAO;
    				$$->esq = NULL;
    				$$->dir = NULL;
    			};

    expressao: var
            | INTEIRO
            {
            	$$ = (No*)malloc(sizeof(No));
            	$$->token = INTEIRO;
            	$$->esq = NULL;
            	$$->dir = NULL;
            }
            | REAL
            {
            	$$ = (No*)malloc(sizeof(No));
            	$$->token = REAL;
            	$$->esq = NULL;
            	$$->dir = NULL;
            }
            | expressao OPSOMA expressao
            {
            	$$ = (No*)malloc(sizeof(No));
            	$$->token = OPSOMA;
            	strcpy($$->nome, yylval.pont->nome);
            	$$->esq = $1;
            	$$->dir = $3;
            }
            | expressao OPSUBTRACAO expressao
            {
            	$$ = (No*)malloc(sizeof(No));
            	$$->token = OPSUBTRACAO;
            	strcpy($$->nome, yylval.pont->nome);
            	$$->esq = $1;
            	$$->dir = $3;
            }
            | expressao OPMULTIPLICACAO expressao
            {
            	$$ = (No*)malloc(sizeof(No));
            	$$->token = OPMULTIPLICACAO;
            	strcpy($$->nome, yylval.pont->nome);
            	$$->esq = $1;
            	$$->dir = $3;
            }
            | expressao OPDIVISAO expressao
            {
            	$$ = (No*)malloc(sizeof(No));
            	$$->token = OPDIVISAO;
            	strcpy($$->nome, yylval.pont->nome);
            	$$->esq = $1;
            	$$->dir = $3;
            }
            | expressao OPMOD expressao
            {
            	$$ = (No*)malloc(sizeof(No));
            	$$->token = OPMOD;
            	strcpy($$->nome, yylval.pont->nome);
            	$$->esq = $1;
            	$$->dir = $3;
            }
            | ABREP expressao FECHAP;

    condicional: IF ABREP compara FECHAP ABREC algoritmo FECHAC 
    			{
    				$$ = (No*)malloc(sizeof(No));
    				$$->token = IF;
    				$$->lookahead = $3;
    				$$->esq = $6;
    				$$->dir = NULL;
    			}
    			| IF ABREP expressao FECHAP ABREC algoritmo FECHAC
    			{
    				$$ = (No*)malloc(sizeof(No));
    				$$->token = IF;
    				$$->lookahead = $3;
    				$$->esq = $6;
    				$$->dir = NULL;
    			};

    repeticao: WHILE ABREP compara FECHAP ABREC algoritmo FECHAC
    			{
    				$$ = (No*)malloc(sizeof(No));
    				$$->token = WHILE;
    				$$->lookahead = $3;
    				$$->esq = $6;
    				$$->dir = NULL;
    			};

    compara: var OPCOMPARACAO var
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = OPCOMPARACAO;
    			$$->esq = $1;
    			$$->dir = $3;
    		}
    		| var OPMENORIGUAL var
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = OPMENORIGUAL;
    			$$->esq = $1;
    			$$->dir = $3;
    		}
    		| var OPMAIORIGUAL var
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = OPMAIORIGUAL;
    			$$->esq = $1;
    			$$->dir = $3;
    		}
    		| var OPMENOR var
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = OPMENOR;
    			$$->esq = $1;
    			$$->dir = $3;
    		}
    		| var OPMAIOR var
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = OPMAIOR;
    			$$->esq = $1;
    			$$->dir = $3;
    		}
    		| var OPDIFERENTE var 
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = OPDIFERENTE;
    			$$->esq = $1;
    			$$->dir = $3;
    		}
    		| expressao OPLOGICO expressao
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = OPLOGICO;
    			$$->esq = $1;
    			$$->dir = $3;
    		}
    		| OPNEGACAO var
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = OPNEGACAO;
    			$$->esq = NULL;
    			$$->dir = $2;
    		}
    		| PIPE
            |;

    entrada: TIPOINT paramEntrada
    		 {
    		 	$$ = (No*)malloc(sizeof(No));
    		 	$$->token = TIPOINT;
    		 	$$->esq = $2;
    		 	$$->dir = NULL;
    		 }
    		| TIPOREAL paramEntrada
    		 {
    		 	$$ = (No*)malloc(sizeof(No));
    		 	$$->token = TIPOREAL;
    		 	$$->esq = $2;
    		 	$$->dir = NULL;
    		 } 
    		| TIPOCARACTERE paramEntrada
    		 {
    		 	$$ = (No*)malloc(sizeof(No));
    		 	$$->token = TIPOCARACTERE;
    		 	$$->esq = $2;
    		 	$$->dir = NULL;
    		 };

    paramEntrada: LEIA paramEntrada FIMCOMANDO
    			  {
    			  	$$ = (No*)malloc(sizeof(No));
    			  	$$->token = LEIA;
    			  	$$->esq = $2;
    			  	$$->dir = NULL;
    			  };

    saida: TIPOINT paramSaida
    	  {
    	   	 $$ = (No*)malloc(sizeof(No));
    	   	 $$->token = TIPOINT;
    	   	 $$->esq = $2;
    	   	 $$->dir = NULL;
    	  }
    	  | TIPOREAL paramSaida
    	  {
    	  	$$ = (No*)malloc(sizeof(No));
    	  	$$->token = TIPOREAL;
    	  	$$->esq = $2;
    	  	$$->dir = NULL;
    	  }
    	 | TIPOCARACTERE paramSaida
    	 {
    	 	$$ = (No*)malloc(sizeof(No));
    	 	$$->token = TIPOCARACTERE;
    	 	$$->esq = $2;
    	 	$$->dir = NULL;
    	 };

    paramSaida: ESCREVA var FIMCOMANDO
    			{
    				$$ = (No*)malloc(sizeof(No));
    				$$->token = ENTRADA;
    				$$->esq = $2;
    				$$->dir = NULL;
    			};

    retorna: SEND expressao
    		{
    			$$ = (No*)malloc(sizeof(No));
    			$$->token = SEND;
    			$$->esq = $2;
    			$$->dir = NULL;
    		};
%%

int yywrap()
{
	return 1;
}

int main()
{
	yyparce();
}