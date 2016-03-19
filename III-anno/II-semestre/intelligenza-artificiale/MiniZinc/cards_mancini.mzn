% es. A.5.6
% cards
% arrange k sets of [n] labeled cards such that cards with value i
% have i cards between them

include"alldifferent.mzn";

int: n_cards;
int: n_sets;

array[1..n_sets, 1..n_cards] of var 1..(n_cards*n_sets): positions;
array[1..n_sets*n_cards] of var 1..n_cards: disposition;

constraint alldifferent([positions[i,j] | i in 1..n_sets, j in 1..n_cards]);

constraint forall(i in 1..n_cards) (
  forall(j in 1..n_sets-1) (
    positions[j+1,i] - positions[j,i] = i+1
  )
);

constraint forall(k in 1..n_sets*n_cards) (
  exists(j in 1..n_cards, i in 1..n_sets) (
    k = positions[i,j] /\ disposition[k] = j
  )
);

solve satisfy;

output [ show(i) ++ " " | i in disposition];
