%{
  #include <ctype.h>
  #include <stdlib.h>
  #include <stdio.h>
  #include "type_synth.h"
  #include "header.h"
  #include "liste.h"

  int yylex(void);
  void yyerror(char const *);
  void instruct0(char const *);
  void instruct1(char const *, char constc );
  void comment0(char const *);
  void type_error();	  
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
expr   {}
| LET expr {}
| NUMBER {stack[] = ; stack_size++;}
|FALSE {}
|TRUE {}
;
%%

void yyerror(char const *s) {
  fprintf(stderr, "%s\n", s);
}

