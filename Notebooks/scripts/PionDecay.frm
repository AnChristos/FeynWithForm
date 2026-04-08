
* Process: pion -> fermion neutrino

#include amplitude.inc

* Constants and Kinematics
Symbols Gf, Vud, fpi, ml, mpi;


Local M = - (Gf/sqrt_(2)) * Vud * fpi * ( 
            VB(i1, p3, ml) * g(i1, i2, pPion) * (g(i2, i3) - g(i2, i3, k5)) * U(i3, p4, 0)
          );

#call squareamplitude(M, Msq)
.sort
Multiply -1;
.sort

* --- Kinematics ---
id p3.p3 = ml^2;
id p4.p4 = 0;
id pPion.pPion = mpi^2;
id p3.p4 = (mpi^2 - ml^2)/2;
id pPion.p3 = (mpi^2 + ml^2)/2;
id pPion.p4 = (mpi^2 - ml^2)/2;
.sort

* Differential Decay Rate
Local dGamma = ( pRest / (32 * pi^2 * mpi^2) ) * Msq;
.sort

id pRest = (mpi^2 - ml^2)/(2*mpi);
.sort

id 1/sqrt_(2)/sqrt_(2) = 1/2;
bracket Gf, Vud, fpi, pi, mpi;
.sort

* Save to file 
Format C;
#write <pi_decay_rate.txt> "%e;", dGamma;
.sort

* Print 
Format;
bracket Gf, Vud, fpi, pi, mpi;
Print Msq;
Print dGamma;
.end

.end
