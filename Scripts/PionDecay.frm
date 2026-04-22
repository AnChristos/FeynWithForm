
* Process: pion -> fermion anti-neutrino

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
#include FeynHelpers.h

Symbols  ml, mpi;
Vector pPion;

* This should be multiplied by a constant which I ommit here.
Local M =  UB(i1, p3, ml) *  gamma(i1, i2, k7) * gamma(i2, i3, mu1) * V(i3, p4, 0)  * pPion(mu1);

#call squareamplitude(M, Msq)
.sort

* --- Kinematics ---
id p3.p3 = ml^2;
id p4.p4 = 0;
id pPion.pPion = mpi^2;
id p3.p4 = (mpi^2 - ml^2)/2;
id pPion.p3 = (mpi^2 + ml^2)/2;
id pPion.p4 = (mpi^2 - ml^2)/2;
.sort

* Save to file 
Format C;
#write <../Results/PionDecay.txt> "%e;", Msq;
.sort
* Print 
Format;
Print Msq;


.end
