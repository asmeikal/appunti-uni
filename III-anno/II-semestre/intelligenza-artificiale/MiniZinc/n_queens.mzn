% es. A.5.2
% n-Queens

include"alldifferent.mzn";

int: n_queens;

array[1..n_queens] of var 1..n_queens: columns;

constraint alldifferent([columns[i] | i in 1..n_queens]);

constraint forall(i, j in 1..n_queens where i < j) (
    abs(columns[i] - columns[j]) != j - i
);

% constraint alldifferent([columns[i] - i | i in 1..n_queens]);
% constraint alldifferent([columns[i] + i | i in 1..n_queens]);

solve satisfy;

output
  ["Solution with " ++ show(n_queens) ++ " Queens:\n"]
  ++
  [ if fix(columns[i]) = j then "Q " else "- " endif
    ++
    if j = n_queens then "\n" else "" endif
  | i, j in 1..n_queens ];
