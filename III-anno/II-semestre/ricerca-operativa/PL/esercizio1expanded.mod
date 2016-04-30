set Origini;
set Destinazioni;

set Nord;
set Sud;
set Isole;

set OriginiNord := Origini inter Nord;
set DestinazioniSud := Destinazioni inter (Sud union Isole);

param Domanda{Destinazioni} >= 0;
param Disponibili{Origini}  >= 0;

param CostiTrasporto{Origini, Destinazioni} >= 0;

param CostiAggiuntivi{Origini, Destinazioni} >= 0;

param CostiTasse{Destinazioni} >= 0;
param CostiPrelevamento{Origini} >= 0;

var MerceTrasportata{Origini, Destinazioni} >= 0;

minimize Costo:
    sum {o in Origini, d in Destinazioni}
        (CostiTrasporto[o,d] +
         CostiPrelevamento[o] +
         CostiTasse[d] +
         CostiAggiuntivi[o,d]) * MerceTrasportata[o,d];

subject to VincoloDisponibili{o in Origini}:
    sum {d in Destinazioni} MerceTrasportata[o,d] <= Disponibili[o];

subject to VincoloDomanda{d in Destinazioni}:
    sum {o in Origini} MerceTrasportata[o,d] = Domanda[d];

subject to VincoloOrigini:
    sum {o in OriginiNord, d in Destinazioni} MerceTrasportata[o,d] >= 4.0/5 * sum {o in Origini, d in Destinazioni} MerceTrasportata[o,d];

subject to VincoloDestinazioni:
    sum {o in Origini, d in DestinazioniSud} MerceTrasportata[o,d] >= 2.0/3 * sum {o in Origini, d in Destinazioni} MerceTrasportata[o,d];

