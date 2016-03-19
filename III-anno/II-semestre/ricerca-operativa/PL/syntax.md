
nel .mod:
set NomeInsieme ordered;  # insieme ordinato
set NomeInsieme circular; # insieme ordinato e ciclico
set NomeInsieme dimension p;

nel .dat:
set NomeInsieme := 1 .. N;
set NomeInsieme := 1 .. N by p;

operazioni sugli insiemi:
union
inter
within (sottoinsieme)
diff (differenza)
symdiff (unione meno intersezione, differenza simmetrica)
card(insieme)
cross (prodotto cartesiano)

