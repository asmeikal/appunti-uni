% es. A.5.6
% cards
% arrange k sets of [n] labeled cards such that cards with value i
% have i cards between them

include "count_eq.mzn";

int: n_cards;
int: n_sets;

int: total_cards = n_cards * n_sets;

array[1..total_cards] of var 1..n_cards: arranged_set;

constraint forall(i in 1..n_cards) (
  count_eq(arranged_set, i, n_sets)
);

constraint forall(i in 1..total_cards) (
  forall(j in 1..i-1) (
    exists(k in 1..n_sets-1) (
      if arranged_set[j] = arranged_set[i] then i - j = k * (arranged_set[i]+1) else true endif
    )
  )
);

solve satisfy;

output [ show(i) ++ " " | i in arranged_set];
