flex -o AnalisadorLexico.c AnalisadorLexico.l
bison -v -d -o AnalisadorSintatico.c AnalisadorSintatico.y
gcc AnalisadorSintatico.c AnalisadorLexico.c -o Analisador -g -DYYDEBUG=1
./Analisador < exemplo
