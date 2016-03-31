% es. A.5.8
% social golfers
% P players play tournaments during W weeks.
% each week they form G groups of equal size S (thus G | P).
% for each couple (p1, p2) in (P choose 2), p1 and p2 are in the same group at most twice.

% this is a slightly optimized version: finds unsatisfiable cases faster
% is a little slower with small cases
% with P: 9, W: 5, G: 3 finds that there is no solution in 176msec
% socialgolf.mzn has no solution after 2m 38s

include"alldifferent.mzn";
include"alldifferent_except_0.mzn";

int: players;
int: weeks;
int: groups;

int: S = players div groups;

% groups | players, maybe redundant but who cares
constraint exists(k in 1..players) (
  players = k * groups
);

% arrangement[w,g,s] = player in position s in group g in week w
array[1..weeks,1..groups,1..S]  of var 1..players: arrangement;
% player_group[w,p] = group in which player p plays in week w
array[1..weeks,1..players]      of var 1..groups:  player_group;
% playermatches[p,w,s] = player in position s in week w in the group of p
% note: playermatches[p,w,s] is 0 if arrangement[w,g,s] = p
array[1..players,1..weeks,1..S] of var 0..players: playermatches;

% consistency constraint on player_group and arrangement
constraint forall(w in 1..weeks, g in 1..groups, s in 1..S, p in 1..players) (
  arrangement[w,g,s] = p -> player_group[w,p] = g
);

% consistency constraint on playermatches and arrangement
constraint forall(p in 1..players, w in 1..weeks, s in 1..S) (
  if (arrangement[w,player_group[w,p],s] = p) then
    playermatches[p,w,s] = 0
   else
    playermatches[p,w,s] = arrangement[w,player_group[w,p],s]
  endif
);

% break simmetries

% order groups in each week
constraint forall(w in 1..weeks, g in 1..groups-1) (
  arrangement[w,g,1] < arrangement[w,g+1,1]
);

% order players in each week
constraint forall(w in 1..weeks, g in 1..groups, s in 1..S-1) (
  arrangement[w,g,s] < arrangement[w,g,s+1]
);

% fix first week
constraint forall(g in 1..groups, s in 1..S) (
  fix(arrangement[1,g,s] = s + S*(g-1))
);

% each player is in 1 group per week
constraint forall(w in 1..weeks) (
  alldifferent([ arrangement[w, g, s] | g in 1..groups, s in 1..S ])
);

% each player battles an alldifferent list of players
% note: except 0 since each player would appear w times in this list otherwise
constraint forall(p in 1..players) (
  alldifferent_except_0([ playermatches[p, w, s] | w in 1..weeks, s in 1..S ])
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
