
* Process: e+ e- -> mu+ mu- (EW)


* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include amplitude.h

* Kinematic variables
Symbols s, t, u;

* Physical constants
Symbols e, pi, alpha, cv, ca, mZ, gweak;

* Three momenta ratio in CM
Symbols pfInOutRatio;

Local MQED = (e^2 )    * (VB(i1, p2, 0) * g(i1, i2, mu1) * U(i2, p1, 0))  
                       * phprop(mu1, mu2, q) 
                       * (UB(i3, p3, 0) * g(i3, i4, mu2) * V(i4, p4, 0));

Local MZ = (gweak^2/4) * (VB(i1, p2, 0) * g(i1, i2, mu1) * 1/2* ((cv-ca)*g(i2, i3, k7) + (cv+ca)*g(i2, i3, k6)) * U(i3, p1, 0))
                       * Zprop(mu1, mu2, q, mZ)
                       * (UB(i4, p3, 0) * g(i4, i5, mu2) * 1/2 * ((cv-ca)*g(i5, i6, k7) + (cv+ca)*g(i5, i6, k6)) * V(i6, p4, 0));
Local Mtot = MQED + MZ;

#call squareamplitude(MQED, MsqQED)
#call squareamplitude(MZ, MsqZ)
#call squareamplitude(Mtot, MsqTot)
.sort 
Local MsqInt = MsqTot - MsqQED - MsqZ;
.sort


* Spin averaging (1/2 * 1/2)
multiply 1/4; 
* coupling
id e^4 = 16 * pi^2 * alpha^2;
id e^2 = 4 * pi * alpha;
* propagator handling
id q = p1 + p2;
id prop(x?) = (x)^-1;
id (q.q)^-1 = (s)^-1;
id (-mZ^2 + q.q)^-1 = (s - mZ^2)^-1;
.sort


* Mandelstam
repeat;
* Massless limit
    id p1.p1 = 0;
    id p2.p2 = 0;
    id p3.p3 = 0;
    id p4.p4 = 0;

    id p1.p2 = s/2;
    id p3.p4 = s/2;
    id p1.p3 = - t/2;
    id p2.p4 = - t/2;
    id p1.p4 = u/2;
    id p2.p3 = u/2;    
endrepeat;
.sort;


Bracket s, alpha, gweak;
.sort
* Save
Format C;
#write <ee_incl_mumu_QED.txt> "%e;", MsqQED;
#write <ee_incl_mumu_Int.txt> "%e;", MsqInt;
#write <ee_incl_mumu_Z.txt> "%e;", MsqZ;
.sort

* Print
Format;
Print +s MsqZ;
Print +s MsqInt;
Print +s MsqQED;
.end
