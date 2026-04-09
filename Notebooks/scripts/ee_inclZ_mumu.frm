
* Process: e+ e- -> mu+ mu- (EW)

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include amplitude.inc

* Kinematic variables
Symbols s, t, u;

* Physical constants
Symbols e, pi, alpha, cv, ca, mZ, gweak;

* Three momenta ratio in CM
Symbols pfInOutRatio,n;

Local MQED = (e^2 )    * (VB(i1, p2, 0) * g(i1, i2, mu1) * U(i2, p1, 0))  
                       * phprop(mu1, mu2, q) 
                       * (UB(i3, p3, 0) * g(i3, i4, mu2) * V(i4, p4, 0));

Local MZ = (gweak^2/4) * (VB(i1, p2, 0) * g(i1, i2, mu1) * (cv*g(i2, i3) - ca*g(i2, i3, k5)) * U(i3, p1, 0))
                       * Zprop(mu1, mu2, q, mZ)
                       * (UB(i4, p3, 0) * g(i4, i5, mu2) * (cv*g(i5, i6) - ca*g(i5, i6, k5)) * V(i6, p4, 0));
Local Mtot = MQED + MZ;

#call squareamplitude(MQED, MsqQED)
#call squareamplitude(MZ, MsqZ)
#call squareamplitude(Mtot, MsqTot)
.sort 
Local MsqInt = MsqTot - MsqQED - MsqZ;
.sort
multiply 1/4; 
.sort

print MsqQED;
* Physics & Normalization
id e^4 = 16 * pi^2 * alpha^2;


* Kinematics 
id q = p1 + p2;
.sort
id prop(x?) = 1/(x);
.sort
id 1/(q.q) = 1/(s);
id 1/(-mZ^2 + q.q) = 1/(s - mZ^2);
id q.q = s;
.sort
* Repeat substitutions as needed.
* We form all Mandelstam 
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

* Differential cross section formula
Local dSigmaQED = (1 / (64 * pi^2 * s)) * pfInOutRatio * MsqQED;
Local dSigmaZ = (1 / (64 * pi^2 * s)) * pfInOutRatio * MsqZ;
Local dSigmaInt = (1 / (64 * pi^2 * s)) * pfInOutRatio * MsqInt;
.sort

Bracket s, alpha, gweak, pi, pfInOutRatio;

* Save
Format C;
#write <ee_incl_mumu_QED.txt> "%e;", dSigmaQED;
.sort
* Print
Format;
Print MsqQED;
Print dSigmaQED;

* Save
Format C;
#write <ee_incl_mumu_Z.txt> "%e;", dSigmaZ;
.sort
* Print
Format;
Print MsqZ;
Print dSigmaZ;

* Save
Format C;
#write <ee_incl_mumu_Int.txt> "%e;", dSigmaInt;
.sort
* Print
Format;
Print MsqInt;
Print dSigmaInt;

.end
