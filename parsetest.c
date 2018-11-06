#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "errormsg.h"

extern int yyparse(void);

void parse(string fname)
{
	EM_reset(fname);
	if (yyparse() == 0)
		fprintf(stderr, "Parsing successful!\n");
	else fprintf(stderr, "FAILED");
}

int main(int argc, char **argv)
{
	FILE *arqtoken;
	char filename[] = "tokens.txt";
	if(argc!=2){
		fprintf(stderr, "usage a.out filename\n");
	}
	remove(filename);
	arqtoken = fopen(filename, "w");
	fprintf(arqtoken, "Token\t\t\t\tValor\t\t\n\n");
	parse(argv[1]);
	return 0;
}