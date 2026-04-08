
* Process: e+ e- -> mu+ mu- 

#include amplitude.inc

* Kinematic variables
Symbols s, t, u;

* Physical constants
Symbols e, pi, alpha, Mass;

* Three momenta ratio in CM
Symbols pfInOutRatio;


Local M = (e^2 / s) * (VB(i1, p2, 0) * g(i1, i2, j1) * U(i2, p1, 0)) * (UB(i3, p3, Mass) * g(i3, i4, j1) * V(i4, p4, Mass));
#call squareamplitude(M, Msq)

.sort
trace4, 1;
trace4, 2;
.sort
contract;
Print Msq;
.sort

* Physics & Normalization
id e^4 = 16 * pi^2 * alpha^2;
* Spin averaging (1/2 * 1/2)
multiply 1/4; 

* 3. Kinematics 
* Repeat substitutions as needed.
* We form all Mandelstam 
* Note that here what happens
* is symbolic substitution

repeat;

    id p1.p1 = 0;
    id p2.p2 = 0;
    id p3.p3 = Mass^2;
    id p4.p4 = Mass^2;

    id p1.p2 = (s - p1.p1 - p2.p2)/2;
    id p3.p4 = (s - p3.p3 - p4.p4)/2;


    id p1.p3 = (p1.p1 + p3.p3 - t)/2;
    id p2.p4 = (p2.p2 + p4.p4 - t)/2;


    id p1.p4 = (p1.p1 + p4.p4 - u)/2;
    id p2.p3 = (p2.p2 + p3.p3 - u)/2;
endrepeat;
.sort

* Differential cross section formula
Local dSigma = (1 / (64 * pi^2 * s)) * pfInOutRatio * Msq;
.sort

bracket alpha, s, pfInOutRatio;
* Save
Format C;
#write <ee_to_mumu.txt> "%e;", dSigma;
.sort
* Print
Format;
factorize;
Print Msq;
Print dSigma;
.end
