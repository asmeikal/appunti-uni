% es. A.5.3
% edge colouring
% all triangles must not have the same colour on all edges

int: n_vertex;
int: n_colours = 3;

array[1..n_vertex] of set of int: edges;

array[1..n_vertex,1..n_vertex] of var 1..n_colours: colours;

constraint assert (
  forall(i in 1..n_vertex) (
    not(i in edges[i])
  ),
  "There is a loop."
);

constraint assert (
  forall(i in 1..n_vertex) (
    forall(j in edges[i]) (
      i in edges[j]
    )
  ),
  "The graph is not simmetric."
);

constraint forall(i, j, k in 1..n_vertex
                  where (i in edges[j]) /\
                        (j in edges[k]) /\
                        (k in edges[i])) (
    (colours[i,j] != colours[j,k] \/
     colours[j,k] != colours[k,i] \/
     colours[k,i] != colours[i,j]) /\
     colours[i,j] = colours[j,i] /\
     colours[i,k] = colours[k,i] /\
     colours[j,k] = colours[k,j]
);

solve satisfy;

output
  [ "(" ++ show(i) ++ "," ++ show(j) ++ "): " ++ show(colours[i, j]) ++ "\n"
    | i, j in 1..n_vertex where (i < j) /\ (i in edges[j]) ];
