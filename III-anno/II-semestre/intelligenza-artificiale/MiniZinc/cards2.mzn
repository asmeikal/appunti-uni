% es. A.5.7
% cards2
%
% given a collection of N cards with values in [M] arrange them
% in a strictly asc-desc-asc-desc sequence such that the local
% maximums are at D distance (i.e. have D-1 cards between them)

include"alldifferent.mzn";

array[1..N] of 1..M: cards;
int: N;
int: M;
int: D;

array[1..N] of var 1..M: arrange;
array[1..N] of var 1..N: permutation;

constraint forall(i in 1..N) (
  arrange[i] = cards[permutation[i]]
);

constraint N > 0;
constraint M > 0;
constraint D > 0;

constraint alldifferent(permutation);

% if you want the sequences to always exist
%constraint exists(i, j, k in 2..N-1 where i < k /\ k < j /\ j - i = D) (
constraint exists(i, j, k in 1..N where i <= k /\ k <= j /\ j - i = D) (
  forall(i_asc in 1..i-1) (
    arrange[i_asc] < arrange[i_asc+1]
  ) /\
  forall(i_desc in i..k-1) (
    arrange[i_desc] > arrange[i_desc+1]
  ) /\
  forall(j_asc in k..j-1) (
    arrange[j_asc] < arrange[j_asc+1]
  ) /\
  forall(j_desc in j..N-1) (
    arrange[j_desc] > arrange[j_desc+1]
  )
);

solve satisfy;

output [show(i) ++ " " | i in arrange];
