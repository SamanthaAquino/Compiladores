rm -f y.tab.c y.tab.h y.output lex.yy.c util.o parsetest.o lex.yy.o errormsg.o y.tab.o tokens.txt Analisador programa.c
bison -vdty AnalisadorSintatico.y
flex AnalisadorLexico.l
gcc -g -c util.c
gcc -g -c errormsg.c
gcc -g -c lex.yy.c
gcc -g -c y.tab.c
gcc -g -c parsetest.c
gcc -g -o Analisador parsetest.o y.tab.o lex.yy.o errormsg.o util.o

./Analisador exemplo
gcc -g programa.c -o programa
./programa