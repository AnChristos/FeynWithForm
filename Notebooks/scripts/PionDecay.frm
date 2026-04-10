
* Process: W -> fermion neutrino

#include amplitude.inc

* Massess
Symbols  ml, mW;


Local M =   UB(i1, p2, ml) * g(i1, i2, k7) * g(i2, i3, mu1) * V(i3, p3, 0) * epsM(mu1,q,mW);


#call squareamplitude(M, Msq)
.sort

* --- Kinematics ---
id q.q = mw^2;
id p3.p3 = 0;
id p2.p3 = (mw^2 - ml^2)/2;
id q.p2 = (mw^2 + ml^2)/2;
id q.p3 = (mw^2 - ml^2)/2;
.sort

Print;
.end
