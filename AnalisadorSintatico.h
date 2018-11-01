#ifndef UTIL_H
#define UTIL_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

struct No
{
	int num;
	double val;
	char nome[256];
	struct No *esq;
	struct No *dir;
	struct No *lookahead1;
	struct No *lookahead2; 
};

typedef struct No No;
#endif