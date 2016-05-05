
param nQueens > 0;

var Scacchiera{1..nQueens, 1..nQueens} integer >= 0;

minimize Costo:
    sum {i in 1..nQueens, j in 1..nQueens} Scacchiera[i,j];

subject to totalQueens:
    sum {i in 1..nQueens, j in 1..nQueens} Scacchiera[i,j] = nQueens;

subject to VincoloColonne {i in 1..nQueens}:
    sum {j in 1..nQueens} Scacchiera[i,j] = 1;

subject to VincoloRighe {j in 1..nQueens}:
    sum {i in 1..nQueens} Scacchiera[i,j] = 1;

subject to VincoloDiagonaliSx1 {i in 1..nQueens}:
    sum {j in 0..i-1} Scacchiera[i-j,j+1] <= 1;

subject to VincoloDiagonaliSx2 {i in 2..nQueens}:
    sum {j in 0..nQueens-i} Scacchiera[nQueens-j,i+j] <= 1;

subject to VincoloDiagonaliDx1 {i in 1..nQueens}:
    sum {j in 0..nQueens-i-1} Scacchiera[j+1,i+j] <= 1;

subject to VincoloDiagonaliDx2 {i in 2..nQueens}:
    sum {j in 0..nQueens-i-1} Scacchiera[i+j,j+1] <= 1;

