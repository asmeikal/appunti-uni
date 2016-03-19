# model files can be loaded with model [file_name]

# variables are real by default
var x1;
var x2;

# maximize or minimize goal function
maximize Funzione_Obiettivo: x1 + x2;

# constrains
subject to Vincolo1: x1 + x2 <= 1;
subject to Vincolo2: x1 - x2 <= 2;
subject to NonNeg1:  x1 >= 0;
# shorter way
s.t. NonNeg2:  x2 >= 0;

