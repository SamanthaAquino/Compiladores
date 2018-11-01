%{

	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include "AnalisadorSintatico.h"
	#include "util.h"
	#include "errormsg.h"

	int yylex(void);

	void yyerror(char *s)
	{
		EM_error(EM_tokPos, "%s",s);
	}

	No *base;	
%}

%union{
	int inteiro;
	float real;
	string var;
	struct No *atual;
}

%start Programa

%token <inteiro> INTEIRO
%token <real> 	 REAL
%token <var>     VARIAVEL
%token <var>     STRING

%token FUNCTION
%token ENDFUNCTION

%token ESCREVA
%token LEIA

%token IF
%token WHILE

%token OPNEGACAO
%token OPCOMPARACAO
%token OPMENORIGUAL
%token OPMENOR
%token OPMAIORIGUAL
%token OPMAIOR
%token OPDIFERENTE

%left OPSOMA
%left OPSUBTRACAO
%left OPMULTIPLICACAO
%left OPDIVISAO
%right OPMOD
%right OPATRIBUICAO

%token TIPOINT
%token TIPOCHAR
%token TIPOREAL

%token ABREC 
%token FECHAC
%token ABREP
%token FECHAP
%token FIMCOMANDO
%token PIPE

/*não terminais*/
%type<atual> Programa
%type<atual> Corpo
%type<atual> Tipo
%type<atual> Atribuicao
%type<atual> TipoAtri
%type<atual> Atri_num
%type<atual> Declaracao
%type<atual> Declaracao2
%type<atual> Calculo
%type<atual> Expressao
%type<atual> Relacional
%type<atual> Condicao
%type<atual> Repeticao
%type<atual> Entrada
%type<atual> Saida
%type<atual> Retorna


%%

Programa : FUNCTION Corpo Retorna { printf("Programa executado com sucesso\n"); exit(0); } ;

Corpo: Calculo | Atribuicao | Declaracao | Condicao | Repeticao | Entrada | Saida;

Tipo: INTEIRO  { $$ = (No*)malloc(sizeof(No));
				  $$->num = INTEIRO;
				  $$->esq = NULL;
				  $$->dir = NULL;
				  $$->lookahead1 = NULL;
				  $$->lookahead2 = NULL;};
	  | REAL    { $$ = (No*)malloc(sizeof(No));
	   			  $$->num = REAL;
	   			  $$->esq = NULL;
	   			  $$->dir = NULL;
	   			  $$->lookahead1 = NULL;
	   			  $$->lookahead2 = NULL;};
	  | VARIAVEL{ $$ = (No*)malloc(sizeof(No));
	  			  $$->num = VARIAVEL;
	  			  $$->esq = NULL;
	  			  $$->dir = NULL;
	  			  $$->lookahead1 = NULL;
	  			  $$->lookahead2 = NULL;};

Atribuicao: VARIAVEL OPATRIBUICAO TipoAtri {$$ = (No*)malloc(sizeof(No));
											$$->num = OPATRIBUICAO;
											$$->esq = $3;
											$$->dir = NULL;
											$$->lookahead1 = NULL;
											$$->lookahead2 = NULL;};
TipoAtri: Atri_num | Calculo;

Atri_num: Tipo FIMCOMANDO Corpo;

Declaracao: TIPOINT VARIAVEL Declaracao2 {$$=(No*)malloc(sizeof(No));
										  $$->num = TIPOINT;
										  $$->esq = $3;
										  $$->dir = NULL;
										  $$->lookahead1 = NULL;
										  $$->lookahead2 = NULL;};
		  | TIPOREAL VARIAVEL Declaracao2 {$$ = (No*)malloc(sizeof(No));
		  								   $$->num = TIPOREAL;
		  								   $$->esq = $3;
		  								   $$->dir = NULL;
		  								   $$->lookahead1 = NULL;
		  								   $$->lookahead2 = NULL;};
		  | TIPOCHAR VARIAVEL Declaracao2{ $$ = (No*)malloc(sizeof(No));
		  								   $$->num = TIPOCHAR;
		  								   $$->esq = $3;
		  								   $$->dir = NULL;
		  								   $$->lookahead1 = NULL;
		  								   $$->lookahead2 = NULL;};

Declaracao2: OPATRIBUICAO TipoAtri {$$ = (No*)malloc(sizeof(No));
 								    $$->num = OPATRIBUICAO;
 								    $$->esq = $2;
 								    $$->dir = NULL;
 								    $$->lookahead1 = NULL;
 								    $$->lookahead2 = NULL;};
 			| FIMCOMANDO { $$ = (No*)malloc(sizeof(No));
 			               $$->num = FIMCOMANDO;
 			               $$->esq = NULL;
 			               $$->dir = NULL;
 			               $$->lookahead1 = NULL;
 			               $$->lookahead2 = NULL;};

Calculo: Expressao FIMCOMANDO Corpo;

Expressao: Tipo OPSOMA Tipo { $$ = (No*)malloc(sizeof(No));
							  $$->num = OPSOMA;
							  $$->esq = $1;
							  $$->dir = $3;
							  $$->lookahead1=NULL;
							  $$->lookahead2=NULL;};
		 | Tipo OPSUBTRACAO Tipo { $$ = (No*)malloc(sizeof(No));
		 						   $$->num = OPSUBTRACAO;
		 						   $$->esq = $1;
		 						   $$->dir = $3;
		 						   $$->lookahead1 = NULL;
		 						   $$->lookahead2 = NULL;
		 						 };
		 | Tipo OPMULTIPLICACAO Tipo { $$ = (No*)malloc(sizeof(No));
		 							   $$->num = OPMULTIPLICACAO;
		 							   $$->esq = $1;
		 							   $$->dir = $3;
		 							   $$->lookahead1 = NULL;
		 							   $$->lookahead2 = NULL;
		 						     };
		 | Tipo OPDIVISAO Tipo { $$ = (No*)malloc(sizeof(No));
		 	                     $$->num = OPDIVISAO;
		 	                     $$->esq = $1;
		 	                     $$->dir = $3;
		 	                     $$->lookahead1 = NULL;
		 	                     $$->lookahead2 = NULL;
		 					   };
		| Tipo OPMOD Tipo { $$ = (No*)malloc(sizeof(No));
						    $$->num = OPMOD;
						    $$->esq = $1;
						    $$->dir = $3;
						    $$->lookahead1 = NULL;
						    $$->lookahead2 = NULL;
						  };
Relacional: Tipo OPMAIORIGUAL Tipo { $$ = (No*)malloc(sizeof(No));
									 $$->num = OPMAIORIGUAL;
									 $$->esq = $1;
									 $$->dir = $3;
									 $$->lookahead1 = NULL;
									 $$->lookahead2 = NULL;
								   };
		  | Tipo OPMAIOR Tipo { $$ = (No*)malloc(sizeof(No));
		  					    $$->num = OPMAIOR;
		  						$$->esq = $1;
		  						$$->dir = $3;
		  						$$->lookahead1 = NULL;
		  						$$->lookahead2 = NULL;
		  					  };
		  | Tipo OPMENORIGUAL Tipo { $$ = (No*)malloc(sizeof(No));
		  							 $$->num= OPMENORIGUAL;
		  							 $$->esq = $1;
		  							 $$->dir = $3;
		  							 $$->lookahead1 = NULL;
		  							 $$->lookahead2 = NULL;
		  							};
		  | Tipo OPMENOR Tipo { $$ = (No*)malloc(sizeof(No));
		  						$$->num = OPMENOR;
		  						$$->esq = $1;
		  						$$->dir = $3;
		  						$$->lookahead1 = NULL; 
		  						$$->lookahead2 = NULL;
		  					  };
		  | Tipo OPCOMPARACAO Tipo{ $$ = (No*)malloc(sizeof(No));
		  							$$->num = OPCOMPARACAO;
		  							$$->esq = $1;
		  							$$->dir = $3;
		  							$$->lookahead1 = NULL;
		  							$$->lookahead2 = NULL;
		                          };
		  | Tipo OPDIFERENTE Tipo { $$= (No*)malloc(sizeof(No));
		  							$$->num = OPDIFERENTE;
		  							$$->esq = $1;
		  							$$->dir = $3; 							
		  							$$->lookahead1 = NULL;
		  							$$->lookahead2 = NULL;
		                          };

Condicao: IF ABREP Relacional FECHAP ABREC Corpo FECHAC { $$ = (No*)malloc(sizeof(No));
											$$->num = IF;
											$$->esq = $6;
											$$->dir = NULL;
											$$->lookahead1 = $3;
											$$->lookahead2 = NULL;
										  };

Repeticao: WHILE ABREP Relacional FECHAP Corpo { $$ = (No*)malloc(sizeof(No));
											   $$->num = WHILE;
											   $$->esq = $5;
											   $$->dir = NULL;
											   $$->lookahead1 = $3;
											   $$->lookahead2 = NULL;
											 };

Entrada: LEIA Tipo FIMCOMANDO{ $$ = (No*)malloc(sizeof(No));
							$$->num = LEIA;
							$$->esq = $2;
							$$->dir = NULL;
							$$->lookahead1 = NULL;
							$$->lookahead2 = NULL;
						  };

Saida: ESCREVA STRING FIMCOMANDO { $$ = (No*)malloc(sizeof(No));
							$$->num = ESCREVA;
							$$->esq = NULL;
							$$->dir = NULL;
							$$->lookahead1 = NULL;
							$$->lookahead2 = NULL;
						  };
Retorna: ENDFUNCTION { $$ = (No*)malloc(sizeof(No));
						  $$->num = ENDFUNCTION;
						  $$->esq = NULL;
						  $$->dir = NULL;
						  $$->lookahead1 = NULL;
						  $$->lookahead2 = NULL;
						};