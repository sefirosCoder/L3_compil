#ifndef _LISTE_H_
#define _LISTE_H_
#include "header.h"

typedef struct Element Element;
struct Element
{
	char[10] nvVar;
	int value;
	Element *suivant;
}

typedef struct Liste Liste;
struct Liste 
{
	Element *premier;
}

Liste initialisation();
void insertion(Liste,char[10],int);
void suppression(Liste);

/*  création d'une liste vide */
Liste initialisation()
{
	Liste *liste = malloc(sizeof(Liste));
	if (liste == NULL || element == NULL)
	{
		exit(EXIT_FAILURE);
	}
	
	return liste;
}
/* Ajoute un élément à la liste  */
void insertion(Liste liste, char[10] name, int val)
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
void suppresion(Liste liste)
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
#endif
