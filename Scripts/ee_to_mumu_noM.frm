
* Process: e+ e- -> mu+ mu-
#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include FeynHelpers.h

* Physical constants
Symbols e, pi, alpha, x;

Local M = (e^2) * (VB(i1, p2, 0) * gamma(i1, i2, mu1) * U(i2, p1, 0)) 
                *  phprop(mu1, mu2, q)  
                * (UB(i3, p3, 0) * gamma(i3, i4, mu2) * V(i4, p4, 0));
#call squareamplitude(M, Msq)
.sort
* Spin averaging (1/2 * 1/2)
multiply 1/4; 
* coupling
id e^4 = 16 * pi^2 * alpha^2;
* propagator handling
id prop(x?) = (x)^-1;
id (q.q)^-1 = (s)^-1;
repeat;
    id q = p1 + p2;
endrepeat;
.sort

* Kinematics 
#call Mandelstam2To2(p1,p2,p3,p4,0,0,0,0)

bracket alpha, s;
.sort
* Save
Format C;
#write <../Results/ee_to_mumu_noM.txt> "%e;", Msq;
.sort
* Print
Format;
Print Msq;
.end
