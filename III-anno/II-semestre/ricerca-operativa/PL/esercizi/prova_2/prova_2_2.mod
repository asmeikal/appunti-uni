set Farcitura;
set Ingredienti;

param DomandaMinima{Farcitura} >= 0;

param CostoIngredienti{Ingredienti} >= 0;
param Disponibili{Ingredienti} >= 0;

param Consumo{Farcitura, Ingredienti} >= 0;

# grammi per tipo di farcitura
var MateriaFarcitura{Farcitura, Ingredienti} >= 0;

minimize Spesa:
    sum {i in Ingredienti, f in Farcitura} CostoIngredienti[i] * MateriaFarcitura[f,i] / 1000;

subject to IngredientiDisponibili{i in Ingredienti}:
    sum {f in Farcitura} MateriaFarcitura[f, i] <= Disponibili[i];

subject to DomandaProduzione{f in Farcitura, i in Ingredienti}:
    MateriaFarcitura[f, i] / Consumo[f, i] >= DomandaMinima[f];

