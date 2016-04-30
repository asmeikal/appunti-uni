
set Prodotti; # P1, P2
set Risorse;  # Levigatura, Pulitura

# checks non-negativity of parameters
param Q_Max{Risorse}   >= 0;
param Prezzo{Prodotti} >= 0;

param Richieste{Risorse,Prodotti} >= 0;

# non-negativity embedded in the declaration
var x{Prodotti} >= 0;

maximize Profitto:
        sum {i in Prodotti} Prezzo[i] * x[i];

subject to VincoloRisorse{j in Risorse}:
        sum {i in Prodotti} Richieste[j,i] * x[i] <= Q_Max[j];

