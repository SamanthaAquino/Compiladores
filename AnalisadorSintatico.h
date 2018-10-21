struct No {
	int token, tokint;
	double val;
	char nome[256];

	struct No *esq, *dir, *prox, *lookahead, *lookahead1, *lookahead2, *lookahead3;
};

typedef struct No No;