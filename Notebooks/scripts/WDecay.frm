
* Process: W -> fermion neutrino

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
#include FeynHelpers.h

* Massess
Symbols  ml, mW, gW;
* Polarization 4-vector
Vector n, x, y;


* unpolarized
Local M =   (gW^2/2) * UB(i1, p2, ml) 
            *  (g(i1, i3, mu1)-g(i1, i2, k5) * g(i2, i3, mu1))  
            * V(i3, p3, 0) * epsM(mu1,q,mW);
#call squareamplitude(M, Msq)
multiply 1/3;
.sort

* polarized
Local MNoPol =  (gW^2/2) * UB(i1, p2, ml) *  (g(i1, i3, mu1)-g(i1, i2, k5) * g(i2, i3, mu1))  * V(i3, p3, 0) ;
#call squareamplitude(MNoPol, MsqNoPol)
.sort
*-------------------------------------------------------------------------*
* Polarization Projection in W-boson rest frame (q = (mW, 0, 0, 0))
*  n.n = -1
*  n = (0, 0, 0, 1) 
* Longitudinal (Z):
* PZ(mu,nu) = n(mu)*n(nu)
* | 0  0  0  0 |
* | 0  0  0  0 |
* | 0  0  0  0 |
* | 0  0  0  1 |
*
* Left-Handed (L):
* PL(mu,nu) = 1/2 * (-d_(mu,nu) + q(mu)*q(nu)/mW^2 - n(mu)*n(nu) + i_*e_(mu,nu,q,n)/mW)
*     | 0  0   0  0 |
* 1/2 | 0  1   i  0 |
*     | 0 -i   1  0 |
*     | 0  0   0  0 |
*
* Right-Handed (R):
* PR(mu,nu) = 1/2 * (-d_(mu,nu) + q(mu)*q(nu)/mW^2 - n(mu)*n(nu) - i_*e_(mu,nu,q,n)/mW)
*     | 0  0   0  0 |
* 1/2 | 0  1  -i  0 |
*     | 0  i   1  0 |
*     | 0  0   0  0 |
*-------------------------------------------------------------------------*
Local MsqPolZ = MsqNoPol * n(mu1) * n(mu2); 
Local MsqPolL = MsqNoPol * 1/2 * ((-d_(mu1,mu2) + q(mu1)*q(mu2)/mW^2 - n(mu1) * n(mu2)) + e_(mu1,mu2,q,n)/mW ) ; 
Local MsqPolR = MsqNoPol * 1/2 *((-d_(mu1,mu2) + q(mu1)*q(mu2)/mW^2 - n(mu1) * n(mu2)) - e_(mu1,mu2,q,n)/mW ) ; 
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
#write <WDecay.txt> "%e;", Msq;
#write <WDecayPolZ.txt> "%e;", MsqPolZ;
#write <WDecayPolL.txt> "%e;", MsqPolL;
#write <WDecayPolR.txt> "%e;", MsqPolR;
.sort
* Print 
Format;
Print Msq;
Print MsqPolZ;
Print MsqPolL;
Print MsqPolR;

.end
