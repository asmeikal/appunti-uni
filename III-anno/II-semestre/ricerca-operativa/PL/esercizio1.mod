set Origini;
set Destinazioni;

param Domanda{Destinazioni} >= 0;
param Disponibili{Origini}  >= 0;

param CostiTrasporto{Origini, Destinazioni} >= 0;

param CostiPrelevamento{Origini} >= 0;

var MerceTrasportata{Origini, Destinazioni} >= 0;

minimize Costo:
    sum {o in Origini, d in Destinazioni} (CostiTrasporto[o,d] + CostiPrelevamento[o]) * MerceTrasportata[o,d];

subject to VincoloDisponibili{o in Origini}:
    sum {d in Destinazioni} MerceTrasportata[o,d] <= Disponibili[o];

subject to VincoloDomanda{d in Destinazioni}:
    sum {o in Origini} MerceTrasportata[o,d] = Domanda[d];

