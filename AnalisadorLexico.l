%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	#include "util.h"
	#include "y.tab.h"
	#include "errormsg.h"
	
	YYSTYPE yylval;
	int tok, charPos=1;
	
	string toknames[] = {"INTEIRO", "REAL", "VARIAVEL", "STRING", "STRING2", "FUNCTION", "ENDFUNCTION", "ESCREVA", "LEIA", "IF", "WHILE", "OPNEGACAO", "OPCOMPARACAO", "OPMENORIGUAL", "OPMENOR", "OPMAIORIGUAL", "OPMAIOR", "OPDIFERENTE", "OPSOMA", "OPSUBTRACAO", "OPMULTIPLICACAO", "OPDIVISAO", "OPMOD", "OPATRIBUICAO", "TIPOINT", "TIPOCHAR", "TIPOREAL", "ABREC", "FECHAC", "ABREP", "FECHAP", "FIMCOMANDO", "PIPE"};

	string tokname(int tok)
	{
		return tok<258 || tok>299 ? "BAD_TOKEN" : toknames[tok-258];
	}

	int yywrap(void)
	{
		charPos=1;
		return 1;
	}

	void adjust(void)
	{
		EM_tokPos=charPos;
		charPos+=yyleng;
	}

	void write_file(void)
	{
		FILE *arqtoken;
		FILE *arq;
		char filename[] = "tokens.txt";
		char filename2[] = "programa.c";
		arqtoken = fopen(filename, "a");
		arq = fopen(filename2, "a");

		switch(tok) {
			case FUNCTION:
				fprintf(arq,"#include<stdio.h>\n#include<stdlib.h>\n\nint main(){\n");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"function");				
				break;
			case ESCREVA:
				fprintf(arq,"printf");
				fprintf(arqtoken,"%s\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),"out");

				break;
			case LEIA:
				fprintf(arq,"scanf");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"in");
				break;
			case ABREC:
				fprintf(arq,"{\n");
				fprintf(arqtoken,"%s\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),"{");
				break;
			case ENDFUNCTION:
				fprintf(arq,"\nreturn 0;\n}\n");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"endfunction");
				break;
			case FECHAC:
				fprintf(arq,"}\n");
				fprintf(arqtoken,"%s\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),"}");
				break;
			case IF:
				fprintf(arq,"if");
				fprintf(arqtoken,"%s\t\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),"if");			
				break;
			case WHILE:
				fprintf(arq,"while");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"while");				
				break;
			case ABREP:
				fprintf(arq,"(");
				fprintf(arqtoken,"%s\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),"(");
				break;
			case FECHAP:
				fprintf(arq,")");
				fprintf(arqtoken,"%s\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),")");
				break;
			case FIMCOMANDO:
				fprintf(arq,";\n");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),".");				
				break;
			case PIPE:
				fprintf(arq,",");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"|");
				break;
			case OPATRIBUICAO:
				fprintf(arq," = ");
				fprintf(arqtoken,"%s\t\t\t%s\t\t\t\t\n",tokname(tok),"=");
				break;
			case OPDIVISAO:
				fprintf(arq," / ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"/");				
				break;
			case OPMOD:
				fprintf(arq," % ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"%");
				break;
			case OPMULTIPLICACAO:
				fprintf(arq," * ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"*");
				break;
			case OPSOMA:
				fprintf(arq," + ");
				fprintf(arqtoken,"%s\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),"+");				
				break;
			case OPSUBTRACAO:
				fprintf(arq," - ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"-");
				break;
			case OPNEGACAO:
				fprintf(arq," ! ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"~");
				break;
			case OPCOMPARACAO:
				fprintf(arq," == ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),":");				
				break;
			case OPMENORIGUAL:
				fprintf(arq," <= ");
				fprintf(arqtoken,"%s\t\t\t%s\t\t\t\t\n",tokname(tok),"<:");
				break;
			case OPMENOR:
				fprintf(arq," < ");
				fprintf(arqtoken,"%s\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),"<");				
				break;
			case OPMAIORIGUAL:
				fprintf(arq," >= ");
				fprintf(arqtoken,"%s\t\t\t%s\t\t\t\t\n",tokname(tok),">:");
				break;
			case OPMAIOR:
				fprintf(arq," > ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),">");
				break;
			case OPDIFERENTE:
				fprintf(arq," != ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"~:");
				break;
			case TIPOINT:
				fprintf(arq,"int ");
				fprintf(arqtoken,"%s\t\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),"i");
				break;
			case TIPOREAL:
				fprintf(arq,"float ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"r");
				break;
			case TIPOCHAR:
				fprintf(arq,"char ");
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),"c");
				break;
			case INTEIRO:
				fprintf(arq,"%d",yylval.inteiro);
				fprintf(arqtoken,"%s\t\t\t\t\t%d\t\t\t\t\n",tokname(tok),yylval.inteiro);
				break;
			case REAL:
				fprintf(arq,"%.2f",yylval.real);
				fprintf(arqtoken,"%s\t\t\t\t\t%f\t\t\t\t\n",tokname(tok),yylval.real);
				break;
			case VARIAVEL:
				fprintf(arq,"%s",yylval.var);
				fprintf(arqtoken,"%s\t\t\t\t%s\t\t\t\t\n",tokname(tok),yylval.var);
				break;
			case STRING:
				yylval.var = yylval.var + 1;
				fprintf(arq,"(\"%%d \\n \", %s)", yylval.var);
				fprintf(arqtoken,"%s\t\t\t\t\t%s\t\t\t\t\n",tokname(tok),yylval.var);
				break;
			case STRING2:
				yylval.var = yylval.var + 1;
				fprintf(arq,"(\"%s \\n \")", yylval.var);
				fprintf(arqtoken, "%s\t\t\t\t\t%s\t\t\t\t\n", tokname(tok),yylval.var);
				break;
			default:
				fprintf(arqtoken,"%s\t\t\t\t\n",tokname(tok));
		}

		fclose(arqtoken);
		fclose(arq);
	}
%}

%%
"{" 		{adjust(); tok = ABREC ; write_file();  printf("Abre Chave: %s\n", yytext); return (ABREC);}
"}" 		{adjust(); tok = FECHAC ; write_file(); printf("Fecha Chave: %s\n", yytext); return (FECHAC);}
"(" 		{adjust(); tok = ABREP ; write_file();  printf("Abre Parentese: %s\n", yytext); return (ABREP);}
")" 		{adjust(); tok = FECHAP ; write_file(); printf("Fecha Parentese: %s\n",yytext); return (FECHAP);}
"." 		{adjust(); tok = FIMCOMANDO ; write_file(); printf("Fim Comando: %s\n",yytext); return (FIMCOMANDO);}
"|" 		{adjust(); tok = PIPE ; write_file(); printf("Pipe: %s\n",yytext); return (PIPE);}

"while"   	{adjust(); tok = WHILE ; write_file(); printf("Comando de repeticao: %s\n", yytext); return (WHILE);}
"if"       	{adjust(); tok = IF ; write_file(); printf("Comando condicional: %s\n",yytext); return (IF);}
"function" 	{adjust(); tok = FUNCTION ; write_file(); printf("Palavra reservada: %s\n", yytext); return (FUNCTION);}
"out"      	{adjust(); tok = ESCREVA ; write_file(); printf("Palavra reservada: %s\n", yytext); return (ESCREVA);}
"in"       	{adjust(); tok = LEIA ; write_file(); printf("Palavra reservada: %s\n", yytext); return (LEIA);}
"endfunction" {adjust(); tok = ENDFUNCTION ; write_file(); printf("Palavra reservada: %s\n", yytext); return (ENDFUNCTION);}

"="  		{adjust(); tok = OPATRIBUICAO ; write_file(); printf("Atribuicao: %s\n",yytext); return (OPATRIBUICAO);}
"/"  		{adjust(); tok = OPDIVISAO ; write_file(); printf("Divisao: %s\n", yytext); return (OPDIVISAO);}
"%"  		{adjust(); tok = OPMOD ; write_file(); printf("MOD: %s\n", yytext); return (OPMOD);}
"*"  		{adjust(); tok = OPMULTIPLICACAO ; write_file(); printf("Multiplicação: %s\n", yytext); return (OPMULTIPLICACAO);}
"+"  		{adjust(); tok = OPSOMA ; write_file(); printf("Soma: %s\n", yytext); return (OPSOMA);}
"-" 		{adjust(); tok = OPSUBTRACAO ; write_file(); printf("Subtração: %s\n",yytext); return (OPSUBTRACAO);}
"~"  		{adjust(); tok = OPNEGACAO ; write_file(); printf("Negação: %s\n",yytext); return (OPNEGACAO);}
":"  		{adjust(); tok = OPCOMPARACAO ; write_file(); printf("Comparação: %s\n",yytext); return (OPCOMPARACAO);}
"<:" 		{adjust(); tok = OPMENORIGUAL ; write_file(); printf("Menor igual: %s\n",yytext); return (OPMENORIGUAL);}
"<"  		{adjust(); tok = OPMENOR ; write_file(); printf("Menor: %s\n",yytext); return (OPMENOR);}
">:" 		{adjust(); tok = OPMAIORIGUAL ; write_file(); printf("Maior igual: %s\n",yytext); return (OPMAIORIGUAL);}
">"  		{adjust(); tok = OPMAIOR ; write_file(); printf("Maior: %s\n",yytext); return (OPMAIOR);}
"~:" 		{adjust(); tok = OPDIFERENTE ; write_file(); printf("Diferente: %s\n",yytext); return (OPDIFERENTE);}

"i" {adjust(); tok = TIPOINT ; write_file(); printf("Tipo de dado: %s\n",yytext); return (TIPOINT);}
"r" {adjust(); tok = TIPOREAL ; write_file(); printf("Tipo de dado: %s\n",yytext); return (TIPOREAL);}
"c" {adjust(); tok = TIPOCHAR ; write_file(); printf("Tipo de dado: %s\n",yytext); return (TIPOCHAR);}

[0-9]+ {adjust(); tok = INTEIRO ; yylval.inteiro=atoi(yytext); write_file(); printf("Inteiro: %s\n",yytext); return (INTEIRO);}
[0-9]+,[0-9]+ {adjust(); tok = REAL ; yylval.real=atof(yytext); write_file(); printf("Real: %s\n",yytext); return (REAL);}
[a-zA-Z][a-zA-Z0-9]* {adjust(); tok = VARIAVEL ; yylval.var=yytext; write_file(); printf("Nome variavel: %s\n",yytext); return (VARIAVEL);}
"#"[a-zA-Z][a-zA-Z0-9]* {adjust(); tok = STRING ; yylval.var=yytext; write_file(); printf("STRING: %s\n",yytext); return (STRING);}
"&"[a-zA-Z][a-zA-Z0-9]* {adjust(); tok = STRING2; yylval.var=yytext; write_file(); printf("STRING: %s\n", yytext); return (STRING2);}

%%