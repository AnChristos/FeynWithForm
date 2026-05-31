
* Process: W -> fermion neutrino

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
#include FeynHelpers.h

* Massess
Symbols  ml, mW, gW, sqrt2;
* Polarization 4-vector
Vector n, x, y;


* unpolarized
Local M =   (gW^2/(2 * sqrt2)) * UB(i1, p2, ml) 
            *  (gamma(i1, i3, mu1)-gamma(i1, i2, k5) * gamma(i2, i3, mu1))  
            *  V(i3, p3, 0) * esumM(mu1,q,mW);
#call squareamplitude(M, Msq)
multiply 1/3;
.sort

* polarized
Local MNoPol =  (gW^2/(2 * sqrt2)) * UB(i1, p2, ml) *  (gamma(i1, i3, mu1)-gamma(i1, i2, k5) * gamma(i2, i3, mu1))  * V(i3, p3, 0) ;
Local MPolZ = MNoPol * VpolZ(mu1, q, n, mW); 
Local MPolL = MNoPol * VpolL(mu1, q, n, mW); 
Local MPolR = MNoPol * VpolR(mu1, q, n, mW);  

#call squareamplitude(MPolZ, MsqPolZ)
#call squareamplitude(MPolL, MsqPolL)
#call squareamplitude(MPolR, MsqPolR)
.sort

id sqrt2^-2 = 1/2;
.sort
id e_(q, n, mu1, mu2) * e_(p2, p3, mu1, mu2) = -2 * (q.p2 * n.p3 - q.p3 * n.p2);
.sort
id n.n = -1 ;
.sort

* --- Kinematics ---
id q.q = mW^2;
id p3.p3 = 0;
id p2.p3 = (mW^2 - ml^2)/2;
id q.p2 = (mW^2 + ml^2)/2;
id q.p3 = (mW^2 - ml^2)/2;
.sort


* Save to file 
Format C;
#write <../Results/WDecay.txt> "%e;", Msq;
#write <../Results/WDecayPolZ.txt> "%e;", MsqPolZ;
#write <../Results/WDecayPolL.txt> "%e;", MsqPolL;
#write <../Results/WDecayPolR.txt> "%e;", MsqPolR;
.sort
* Print 
Format;
Print Msq;
Print MsqPolZ;
Print MsqPolL;
Print MsqPolR;

.end
