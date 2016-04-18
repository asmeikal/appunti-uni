% es. A.5.9
% meetings

include"alldifferent.mzn";

int: N;
int: M;
int: K;
int: S;
int: T;

% variabili di decisione

array[1..N, 1..T] of var 0..S : Sala;
array[1..S, 1..T] of var bool : Usata;
array[1..S, 1..T, 1..K] of var 1..N : Manager;

% controlli sull'input

constraint assert(N > 0, "Troppi pochi manager.");
constraint assert(M > 0, "Troppi pochi incontri.");
constraint assert(K <= N, "Troppi posti per incontro.");
constraint assert(S > 0, "Troppe poche sale.");
constraint assert(T > 0, "Troppi pochi turni.");

% % % % % % % % % % %
% break  symmetries %
% % % % % % % % % % %

% i manager sono seduti in ordine
constraint forall(sala in 1..S, turno in 1..T, posto in 1..K-1) (
  Manager[sala, turno, posto] < Manager[sala, turno, posto+1]
);

% i primi K manager sono nella sala 1 nel turno 1
constraint forall(manager in 1..K) (
  Sala[manager, 1] = 1
);

% i manager sono ordinati fra le sale
constraint forall(sala in 1..S-1, turno in 1..T) (
  Manager[sala, turno, 1] < Manager[sala+1, turno, 1]
);

% le sale vengono usate in ordine
constraint forall(sala in 1..S, turno in 1..T) (
  not Usata[sala, turno] -> forall(sala1 in sala+1..S) (
    not Usata[sala1, turno]
  )
);

% i turni vengono fatti in ordine
constraint forall(turno in 1..T) (
  not Usata[1, turno] -> forall(turno1 in turno+1..T) (
    not Usata[1, turno1]
  )
);

% ordinare lessicograficamente?

% % % % % % % % % % % % % %
% consistency constraints %
% % % % % % % % % % % % % %

% se una sala è usata in un turno, esiste un manager che la usa
constraint forall(sala in 1..S, turno in 1..T) (
  Usata[sala, turno] -> exists(manager in 1..N) (
    Sala[manager, turno] = sala
  )
);

% se un manager usa una sala in un turno, quella sala è usata
constraint forall(manager in 1..N, turno in 1..T) (
  Sala[manager, turno] > 0 -> Usata[Sala[manager, turno], turno]
);

% se un manager usa una sala in un turno, ha un posto in quella sala in quel turno
constraint forall(manager in 1..N, turno in 1..T) (
  Sala[manager, turno] > 0 -> exists(posto in 1..K) (
    Manager[Sala[manager, turno], turno, posto] = manager
  )
);

% se una sala è usata in un turno, tutti i manager in tutti i posti sono in quella sala
constraint forall(sala in 1..S, turno in 1..T) (
  Usata[sala, turno] -> forall(posto in 1..K) (
    Sala[Manager[sala, turno, posto], turno] = sala
  )
);

% % % % % % % % % % % %
% problem constraints %
% % % % % % % % % % % %

% il numero di sale usate in tutti i turni è pari al numero di meeting
constraint M = sum(sala in 1..S, turno in 1..T where Usata[sala, turno]) (1);

% un insieme alldifferent di manager è in ogni sala usata in ogni turno
constraint forall(sala in 1..S, turno in 1..T) (
 alldifferent([Manager[sala, turno, posto] | posto in 1..K])
);

% ogni coppia di manager è nella stessa sala almeno in un turno
constraint forall(manager1, manager2 in 1..N where manager1 < manager2) (
  exists(turno in 1..T) (
    Sala[manager1, turno] > 0 /\
    Sala[manager1, turno] = Sala[manager2, turno]
  )
);

solve satisfy;

output
[
  show(N) ++ " manager, " ++ 
  show(M) ++ " meeting, " ++
  show(S) ++ " sale, " ++
  show(T) ++ " turni, " ++
  show(K) ++ " posti " ++ "\n"
]
++
[
  if fix(Usata[s, t]) == true then
    "Turno " ++ show(t) ++ ", sala " ++ show(s) ++ ": " ++ 
    show([Manager[s, t, k] | k in 1..K]) 
    ++ "\n"
  else
    ""
  endif
  | t in 1..T, s in 1..S 
]
;
