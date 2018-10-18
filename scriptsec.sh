bison -d AnalisadorSintatico.y
flex AnalisadorLexico.y
gcc linguagem.tab.c lex.yy.c -Analisador
