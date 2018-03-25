%{
  #include <ctype.h>
  #include <stdlib.h>
  #include <stdio.h>
  #include "type_synth.h"
  #include "header.h"
  #include "liste.h"

  int yylex(void);
  void type_error();
  #define STACK_CAPACITY 50
  static int stack[STACK_CAPACITY];
  static size_t stack_size = 0;
  Liste *maliste; 	  
%}
%union {
  int val;
  char *string;
  type_synth type;
}

%type <val> NUMBER expr 
%type <string> ID 
%type <type> type


%token NUMBER
%token LET
%token IN
%token IF
%token THEN
%token ELSE
%token ID
%token EQUALS
%token FUNCTION
%token REC

%token ENDLIGNE


%token INT



%left IF
%right THEN
%right ELSE
%precedence LET
%right IN
%left '+' '-'
%left '*' '/'
%start lignes
%%

lignes:
lignes expr error ENDLIGNE '\n' {fprintf(stdout,"cas 1 \n");fprintf(stdout,"--->%d\n",$2);}
| lignes error ENDLIGNE '\n'	   {fprintf(stdout,"cas 2 \n");}
| expr error ENDLIGNE '\n'      {fprintf(stdout,"cas 3 \n");fprintf(stdout,"--->%d\n",$1);}
| error ENDLIGNE '\n'	   {fprintf(stdout,"cas 4 \n");}
| lignes expr ENDLIGNE '\n'     {fprintf(stdout,"cas 5 \n");fprintf(stdout,"--->%d\n",$2);}
| lignes ENDLIGNE '\n'	   {fprintf(stdout,"cas 6 \n");}
| expr ENDLIGNE '\n'           {fprintf(stdout,"cas 7 \n"); fprintf(stdout,"--->%d\n",$1);}
| ENDLIGNE '\n'		   {fprintf(stdout,"cas 8 \n");}
;


type :
INT {$$ = get_type_node(INT_TYPE);}

expr :
expr IN expr {
			//renvoie le resultat contenue dans le expr après le IN;
			fprintf(stdout,"in\n");
			$$=$3;
			}
|LET ID EQUALS expr {
			insertion(maliste,$2,$4);
			fprintf(stdout,"la valeur de %s est %d \n",$2,$4);
			fprintf(stdout,"la valeur dans la liste de %s est de %d",maliste->premier->nvVar,maliste->premier->value);
			$$ = $4;
			// a la fin de l'envirronement il faut supprimer les valeurs ajouter dans le let
			}
|IF expr THEN expr {
				if ( $2 == 1 ){
                                        $$ = $4;
                                }
		}
|IF expr THEN expr ELSE expr {
				if ( $2 == 1 ){
					$$ = $4;
				} else {
					$$ = $6;
				}
			}
|expr '+' expr { 
		$$ = $1 + $3;
		}
|expr '-' expr {
		$$ = $1 - $3;
		}
|expr '/' expr {
		//gérer la div par 0
		if ($3 == 0) {
			fprintf(stderr,"division par 0! \n");
			exit(EXIT_FAILURE);
		
		}
		$$ = $1 / $3;
		}

|expr '*' expr {
		$$ = $1 * $3;
		}
|expr EQUALS expr {
			if($1 == $3){
				$$ = 1;
			}else{
				$$ = 0;
			}		
		}
|'(' expr ')' {$$ = $2; } 	
|ID	{int res; 

	//fprintf(stdout,"%d \n",maliste->premier->value);
	
	if(recherche(maliste->premier,$1,&res) == 0){
		fprintf(stdout,"hugo à dit sa marche pos \n");
		exit(EXIT_FAILURE);
	}
	fprintf(stdout,"la première valeur de %s dans la liste est %d\n",$1,res);	
	$$ = res;
	}

|NUMBER
;
%%

void yyerror(char const *s) {
  fprintf(stderr, "%s\n", s);
}

int main()
{
	maliste = initialisation();
	yyparse();
	
}
