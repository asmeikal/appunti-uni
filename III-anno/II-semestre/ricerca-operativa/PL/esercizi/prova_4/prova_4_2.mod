set Pezzi;
set Assi;
set Tagli7M;
set Tagli3M;

param Prezzo7M >= 0;
param Prezzo3M >= 0;
param Richieste{Pezzi} >= 0;
param PezziTagli7M{Tagli7M, Pezzi} >= 0;
param PezziTagli3M{Tagli3M, Pezzi} >= 0;

var AssiTagli7M{Tagli7M} integer >= 0;
var AssiTagli3M{Tagli3M} integer >= 0;

minimize spesa :
    Prezzo7M * sum {t in Tagli7M} AssiTagli7M[t] + Prezzo3M * sum {t in Tagli3M} AssiTagli3M[t];

subject to Ordine{p in Pezzi} :
    sum {j in Tagli7M} PezziTagli7M[j, p] * AssiTagli7M[j] + sum {j in Tagli3M} PezziTagli3M[j, p] * AssiTagli3M[j] = Richieste[p];

