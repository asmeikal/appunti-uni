
# 4 tipi di fertilizzanti, 2 reparti di produzione
#
# Tempi lavorazione | F1  | F2   | F3   | F4  | Max ore |
# Produzione        | 2   | 1.5  | 0.5  | 2.5 |    100  |
# Confezionamento   | 0.5 | 0.25 | 0.25 | 1   |     50  |
# Prezzo vendita    | 250 | 230  | 110  | 250 |

var x1;
var x2;
var x3;
var x4;

maximize Profitto:
		250 * x1 + 230 * x2 + 110 * x3 + 250 * x4;

s.t. MaxOreProduzione:
		2 * x1 + 1.5 * x2 + 0.5 * x3 + 2.5 * x4 <= 100;

s.t. MaxOreConfezionamento:
		0.5 * x1 + 0.25 * x2 + 0.25 * x3 + x4 <= 50;

s.t. NonNeg1: x1 >= 0;
s.t. NonNeg2: x2 >= 0;
s.t. NonNeg3: x3 >= 0;
s.t. NonNeg4: x4 >= 0;

