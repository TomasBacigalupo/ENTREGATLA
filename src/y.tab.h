/* A Bison parser, made by GNU Bison 3.4.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2019 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUMERO = 258,
    VARIABLE = 259,
    EQUALS = 260,
    var = 261,
    SAME = 262,
    LT = 263,
    LET = 264,
    GT = 265,
    GET = 266,
    WHILE = 267,
    AND = 268,
    OR = 269,
    OP = 270,
    CP = 271,
    DIF = 272,
    DIV = 273,
    MINUS = 274,
    MUL = 275,
    PLUS = 276,
    ENDCYCLE = 277,
    PRINT = 278,
    CAMBIO = 279,
    ID = 280,
    END_LINE = 281,
    END = 282,
    MAIN = 283,
    IF = 284,
    ELSE = 285,
    ENDIF = 286,
    NUMBER_T = 287,
    TEXT_T = 288,
    NUM_C = 289,
    TEXT_C = 290,
    EQUALSCMP = 291,
    NTEQUAL = 292,
    MOD = 293,
    NOT = 294
  };
#endif
/* Tokens.  */
#define NUMERO 258
#define VARIABLE 259
#define EQUALS 260
#define var 261
#define SAME 262
#define LT 263
#define LET 264
#define GT 265
#define GET 266
#define WHILE 267
#define AND 268
#define OR 269
#define OP 270
#define CP 271
#define DIF 272
#define DIV 273
#define MINUS 274
#define MUL 275
#define PLUS 276
#define ENDCYCLE 277
#define PRINT 278
#define CAMBIO 279
#define ID 280
#define END_LINE 281
#define END 282
#define MAIN 283
#define IF 284
#define ELSE 285
#define ENDIF 286
#define NUMBER_T 287
#define TEXT_T 288
#define NUM_C 289
#define TEXT_C 290
#define EQUALSCMP 291
#define NTEQUAL 292
#define MOD 293
#define NOT 294

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 16 "gramatica.y"

    struct Node * node;

#line 139 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
