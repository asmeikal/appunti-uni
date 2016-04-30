set Componenti;
set Elementi;

param Ordine >= 0;
param CostoFinito >= 0;

param QtaElemento{Elementi} >= 0;

param QtaComponente{Elementi, Componenti} >= 0;

param Costo{Componenti} >= 0;
param DispIniziale{Componenti} >= 0;

var ComponenteAcquistato{Componenti} >= 0;
var FertilizzanteAcquistato >= 0;

minimize Spesa :
    CostoFinito * FertilizzanteAcquistato +
    sum {c in Componenti} Costo[c] * ComponenteAcquistato[c];

subject to OrdineRichiesto:
    FertilizzanteAcquistato + sum {c in Componenti} (ComponenteAcquistato[c] + DispIniziale[c]) = Ordine;

subject to ComposizioneFertilizzante{e in Elementi} :
    sum {c in Componenti} QtaComponente[e, c] * (ComponenteAcquistato[c] + DispIniziale[c]) >= QtaElemento[e] * sum {c in Componenti} (ComponenteAcquistato[c] + DispIniziale[c]);

