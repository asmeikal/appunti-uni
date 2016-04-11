set BIGNE;
set MATERIE;

param costo{MATERIE};
param consumo{MATERIE,BIGNE};
param disponibilita{MATERIE};
param domanda{BIGNE};

var qta{MATERIE,BIGNE}, >= 0;

subject to disponibilita_max {i in MATERIE}:
    sum{j in BIGNE} qta[i,j] <= disponibilita[i];

subject to produzione_min {i in MATERIE, j in BIGNE}:
    qta[i,j]/consumo[i,j] >= domanda[j];

minimize costo_tot: sum{i in MATERIE} costo[i] * (sum{j in BIGNE} qta[i,j]);

