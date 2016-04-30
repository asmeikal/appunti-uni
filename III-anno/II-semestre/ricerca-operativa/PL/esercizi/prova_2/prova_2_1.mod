set Farcitura;
set Ingredienti;

param Prezzo{Farcitura} >= 0;
param Domanda{Farcitura} >= 0;

param Disponibili{Ingredienti} >= 0;

param Consumo{Farcitura, Ingredienti} >= 0;

var Produzione{Farcitura} >= 0;

maximize Profitto:
    sum {f in Farcitura} Produzione[f] * Prezzo[f];

subject to IngredientiDisponibili{i in Ingredienti}:
    sum {f in Farcitura} Consumo[f, i] * Produzione[f] <= Disponibili[i];

subject to DomandaProduzione{f in Farcitura}:
    Produzione[f] <= Domanda[f];

