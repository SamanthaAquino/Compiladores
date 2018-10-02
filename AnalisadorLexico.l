%{
    #include<stdio.h>
    #include"AnalisadorSintatico.h" 
%}

numero [0-9]
real {numero}+"."{numero}+
letra [a-zA-Z]
tipo "i"|"r"|"c"
variavel {letra}({letra}|{numero}){0,7}
leia  "<""-""i"|"r"|"c""in"
escreva "-"">""out"
se "if"
senao "else"
enquanto "while"
operadores "+"|"-"|"*"|"/"|"%"
opLogico ","|";"
opNegacao "~"
opRelacional ":"|"<:"|">:"|"<"|">"|"\:"
opAtribuicao "="
abreP "("
fechaP ")"
abreC "{"
fechaC "}"
fimComando "."
pipe "|"
funcao "function"
nomeFuncao {variavel}
exit "quit"
returrn "send"

%%

{numero}+ 	   {printf("Inteiro: %s\n", yytext); return INTEIRO; }
{real} 		   {printf("Real: %s\n", yytext); return REAL; }
{tipo}              { printf("Tipo: %s\n", yytext); yylval = strdup(yytext); return TIPO; }
{leia}              { printf("Comando: %s\n", yytext); return LEIA; }
{escreva}           { printf("Comando: %s\n", yytext); return ESCREVA; }
{se}		   { printf("Comando: %s\n", yytext); return IF; }
{senao}		   { printf("Comando: %s\n", yytext); return ELSE; }
{exit}		   { printf("Comando: %s\n", yytext); return QUIT; }
{returrn}	   { printf("Comando: %s\n", yytext); return SEND; }
{enquanto}	   { printf("Comando: %s\n", yytext); return WHILE; }
{variavel}          { printf("Variavel: %s\n", yytext); return VARIAVEL; }
{operadores}        { printf("Operador Aritmetico: %s\n", yytext); yylval = strdup(yytext); return OPERADORES; }
{opNegacao}         { printf("Operador Negacao: %s\n", yytext); return OPNEGACAO; }
{opLogico}          { printf("Operador Logico: %s\n", yytext); yylval = strdup(yytext); return OPLOGICO; }
{opRelacional}      { printf("Operador Relacional: %s\n", yytext); return OPRELACIONAL; }
{opAtribuicao}       { printf("Operador Atribuição: %s\n", yytext); return OPATRIBUICAO; }
{abreP}    { printf("Parenteses: %s\n", yytext); return ABREP; }
{fechaP}   { printf("Parenteses: %s\n", yytext); return FECHAP;}
{abreC}    { printf("Chaves: %s\n", yytext); return ABREC; }
{fechaC}   { printf("Chaves: %s\n", yytext); return FECHAC;}
{funcao}   { printf("Funcao: %s\n", yytext); return FUNCTION; }
{nomeFuncao} { printf("Nome Funcao: %s\n", yytext); return NOMEFUNCAO;}
{pipe}   { printf("Pipe: %s\n", yytext); return PIPE; }
{fimComando} { printf("Fim de comando: %s\n", yytext); return FIMCOMANDO;}


%%

