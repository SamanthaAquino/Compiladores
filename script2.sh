flex AnalisadorLexico.l
bison -d AnalisadorSintatico.y
gcc AnalisadorSintatico.tab.c lex.yy.c -Analisador