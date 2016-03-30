% es. A.5.8
% social golfers
% P players play tournaments during W weeks.
% each week they form G groups of equal size S (thus G | P).
% for each couple (p1, p2) in (P choose 2), p1 and p2 are in the same group at most twice.

include"alldifferent.mzn";

int: players;
int: weeks;
int: groups;

int: S = players div groups;

% groups | players, maybe redundant but who cares
constraint exists(k in 1..players) (
  players = k * groups
);

% arrangement[w,g,s] = player in position s in group g in week w
array[1..weeks,1..groups,1..S] of var 1..players: arrangement;
% player_group[w,p] = group in which player p plays in week w
array[1..weeks,1..players]     of var 1..groups:  player_group;

% consistency constraint on player_group and arrangement
constraint forall(w in 1..weeks, g in 1..groups, s in 1..S, p in 1..players) (
  arrangement[w,g,s] = p -> player_group[w,p] = g
);

% break simmetries

constraint forall(w in 1..weeks, g in 1..groups-1) (
  arrangement[w,g,1] < arrangement[w,g+1,1]
);

constraint forall(w in 1..weeks, g in 1..groups, s in 1..S-1) (
  arrangement[w,g,s] < arrangement[w,g,s+1]
);

% each player is in 1 group per week
constraint forall(w in 1..weeks) (
  alldifferent([ arrangement[w, g, s] | g in 1..groups, s in 1..S ])
);

%
constraint forall(p1, p2 in 1..players,
                  w1, w2 in 1..weeks
            where p1 < p2 /\
                  w1 < w2 /\
                  player_group[w1,p1] = player_group[w1,p2])
(
    player_group[w2,p1] != player_group[w2,p2]
);

solve satisfy;

output [
  "Week " ++ show(w) ++ ":\n" ++
    show([
      show([ arrangement[w,g,s] | s in 1..S ])
      | g in 1..groups
    ]) ++ "\n"
  | w in 1..weeks
];
