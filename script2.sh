echo "\nFLEX\n"
flex AnalisadorLexico.l
echo "\nBISON\n"
bison -d AnalisadorSintatico.y
echo "\nGCC\n"
gcc AnalisadorSintatico.tab.c lex.yy.c -o Analisador
echo "\nEXECUTAR\n"
./Analisador < exemplo