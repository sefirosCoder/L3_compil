#ifndef _LISTE_H_
#define _LISTE_H_
#include "header.h"

typedef struct Element Element;
struct Element
{
	char* nvVar;
	int value;
	Element *suivant;
};

typedef struct Liste Liste;
struct Liste 
{
	Element *premier;
};

Liste *initialisation();
void insertion(Liste*,char*,int);
void suppression(Liste*);
int recherche(Element*,char*,int*);

/*  création d'une liste vide */
Liste *initialisation()
{
	Liste *liste = malloc(sizeof(Liste));
	if (liste == NULL)
	{
		exit(EXIT_FAILURE);
	}
	liste->premier = NULL;
	
	return liste;
}
/* Ajoute un élément à la liste  */
void insertion(Liste *liste, char* name, int val)
{	
	Element *element = malloc(sizeof(Element));

	if(liste == NULL)
	{
		element->suivant = NULL;
 	} else {
		element->suivant = liste->premier;
	}
	
	element->nvVar = name;
	element->value = val;
	liste->premier = element;
}

/* supprime le dernier élement ajouter à la liste*/
void suppresion(Liste *liste)
{
	if (liste == NULL)
	{
		exit(EXIT_FAILURE);
	}
	if (liste->premier != NULL)
	{
		Element *aSupp = liste->premier;
		liste->premier = liste->premier->suivant;
		free(aSupp);
	}
}

//recherche la valeur de l'element name dans la liste
int recherche(Element *element, char *name, int *result){
	
	if(element == NULL) {
		return 0;
	}

	if(strcmp(element->nvVar,name)==0){
		*result = element->value;
		return 1;
	}
	
	return recherche(element->suivant,name,result);
	
}

#endif
