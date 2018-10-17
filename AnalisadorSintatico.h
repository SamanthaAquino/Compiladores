#ifndef ANALISADORSINTATICO_H
#define ANALISADORSINTATICO_H

typedef struct No 
{
	int token, tokint;
	double val;
	char nome[256];

	struct No *esq, *dir, *prox, *lookahead;
} No;

#endif