
* Process: pion -> fermion neutrino

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include amplitude.inc

* Massess
Symbols  ml, mpi;

* I will ommit constants as we want to take a ratio.
* This should be multiplied by a constant which I ommit
Local M =  ( 
            VB(i1, p4, 0) * (g(i1, i2) - g(i1, i2, k5)) * g(i2, i3, pPion) * V(i3, p3, ml)
          );

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


* Differential Decay Rate (I ommit 32 pi^2 * m_pi^3)
Local dGamma = ( pRest) * Msq;
.sort
id pRest = (mpi^2 - ml^2);
.sort


bracket mpi;
* Save to file 
Format C;
#write <PionDecay.txt> "%e;", dGamma;
.sort
* Print 
Format;
Print Msq;
Print dGamma;
.end

.end
