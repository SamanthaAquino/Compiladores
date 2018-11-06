/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INTEIRO = 258,
    REAL = 259,
    VARIAVEL = 260,
    STRING = 261,
    STRING2 = 262,
    FUNCTION = 263,
    ENDFUNCTION = 264,
    ESCREVA = 265,
    LEIA = 266,
    IF = 267,
    WHILE = 268,
    OPNEGACAO = 269,
    OPCOMPARACAO = 270,
    OPMENORIGUAL = 271,
    OPMENOR = 272,
    OPMAIORIGUAL = 273,
    OPMAIOR = 274,
    OPDIFERENTE = 275,
    OPSOMA = 276,
    OPSUBTRACAO = 277,
    OPMULTIPLICACAO = 278,
    OPDIVISAO = 279,
    OPMOD = 280,
    OPATRIBUICAO = 281,
    TIPOINT = 282,
    TIPOCHAR = 283,
    TIPOREAL = 284,
    ABREC = 285,
    FECHAC = 286,
    ABREP = 287,
    FECHAP = 288,
    FIMCOMANDO = 289,
    PIPE = 290
  };
#endif
/* Tokens.  */
#define INTEIRO 258
#define REAL 259
#define VARIAVEL 260
#define STRING 261
#define STRING2 262
#define FUNCTION 263
#define ENDFUNCTION 264
#define ESCREVA 265
#define LEIA 266
#define IF 267
#define WHILE 268
#define OPNEGACAO 269
#define OPCOMPARACAO 270
#define OPMENORIGUAL 271
#define OPMENOR 272
#define OPMAIORIGUAL 273
#define OPMAIOR 274
#define OPDIFERENTE 275
#define OPSOMA 276
#define OPSUBTRACAO 277
#define OPMULTIPLICACAO 278
#define OPDIVISAO 279
#define OPMOD 280
#define OPATRIBUICAO 281
#define TIPOINT 282
#define TIPOCHAR 283
#define TIPOREAL 284
#define ABREC 285
#define FECHAC 286
#define ABREP 287
#define FECHAP 288
#define FIMCOMANDO 289
#define PIPE 290

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 20 "AnalisadorSintatico.y" /* yacc.c:1909  */

	int inteiro;
	float real;
	string var;
	struct No *atual;

#line 131 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
