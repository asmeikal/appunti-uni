
set Prodotti;
set Mesi circular;
set Linee;

param OreDispLinee{Linee, Mesi} >= 0;
param TempiProduzione{Prodotti, Linee} >= 0;
param Richieste{Prodotti, Mesi} >= 0;

param CostoProduzione >= 0;
param CostoMateriale{Prodotti} >= 0;
param CostoImmagazzinamento >= 0;

var Produzione{Prodotti, Linee, Mesi} >= 0;
var Immagazzinati{Prodotti, Mesi} >= 0;

minimize Costo:
    sum {p in Prodotti, m in Mesi, l in Linee}
        (CostoProduzione + CostoMateriale[p]) * Produzione[p,m,l] +
        CostoImmagazzinamento * Immagazzinati[p, m];

subject to SoddisfacimentoRichieste{p in Prodotti, m in Mesi}:
    (sum {l in Linee} Produzione[p,m,l])
        - Immagazzinati[p, m]
        + Immagazzinati[p, prev(m, Mesi)]
            = Richieste[p, m];

subject to VincoloTempi{l in Linee, m in Mesi}:
    sum {p in Prodotti} TempiProduzione[p,l] * Produzione[p,m,l]
        <= OreDispLinee[l,m];

subject to MagazziniVuoti{p in Prodotti} :
    Immagazzinati[p, last(Mesi)] = 0;

