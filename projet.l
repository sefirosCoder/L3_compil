%{
  #include <limits.h>
  #include "type_synth.h"
  #include "ex1.tab.h"
  void string_to_int(int *v, const char *s);
%}
%option noyywrap
%%
[[:digit:]]+  {string_to_int(&yylval.val, yytext); return NUMBER;}
"let"  {return LET;}
"in"  {return IN;}
"if"  {return IF;}
"then"  {return THEN;}
"else"  {return ELSE;}
[[:blank:]]
.|\n {return yytext[0];}
%%

void string_to_int(int *r, const char *s) {
  char *p;
  long v;
  errno = 0;
  v = strtol(yytext, &p, 10);
  if ( ( *p != '\0' || ( errno == ERANGE 
                     && ( v == LONG_MIN || v == LONG_MAX ) ) ) 
       || ( v < INT_MIN || v > INT_MAX ) ) {
    fprintf(stderr, "Error converting string to int\n");
    exit(EXIT_FAILURE);
  } 
  *r = v;
}
