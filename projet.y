%{
  #include <ctype.h>
  #include <stdlib.h>
  #include <stdio.h>
  #include "type_synth.h"
  #include "header.h"

  int yylex(void);
  void yyerror(char const *);
  void instruct0(char const *);
  void instruct1(char const *, char constc );
  void comment0(char const *);
  void type_error();	  
  #define STACK_CAPACITY 50
  static int stack[STACK_CAPACITY];
  static size_t stack_size = 0;
%}
%union {
  int val;
  type_synth type;
}

%type <val> NUMBER TRUE FALSE 
%type <type> expr 

%token NUMBER
%token LET
%token IN
%token IF
%token THEN
%token ELSE


%left IF
%right THEN
%right ELSE
%right IN
%precedence LET
%left '+' '-'
%left '*' '/'
%start lignes
%%

lignes:
lignes expr error ';;' { stack_size = 0; }
| lignes error ';;'
| expr error ';;'      { stack_size = 0; }
| error ';;'
| lignes expr ';;'     { stack_size = 0; }
| lignes ';;'
| expr ';;'            { stack_size = 0; }
| ';;'
;

expr :
expr    { }
| LET expr {}
| NUMBER {}
|FALSE {}
|TRUE {}
;
%%

void yyerror(char const *s) {
  fprintf(stderr, "%s\n", s);
}

