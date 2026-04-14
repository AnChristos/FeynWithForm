
* Process: e+ e- -> mu+ mu- 

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include amplitude.h

* Kinematic variables
Symbols s, t, u;

* Physical constants
Symbols e, pi, alpha, Mass;

* Three momenta ratio in CM
Symbols pfInOutRatio;


Local M = (e^2) * (VB(i1, p2, 0) * g(i1, i2, mu1) * U(i2, p1, 0)) 
                * phprop(mu1, mu2, q)  
                * (UB(i3, p3, Mass) * g(i3, i4, mu2) * V(i4, p4, Mass));
#call squareamplitude(M, Msq)
.sort

* Spin averaging (1/2 * 1/2)
multiply 1/4; 
* coupling
id e^4 = 16 * pi^2 * alpha^2;
* propagator handling
id q = p1 + p2;
id prop(x?) = (x)^-1;
id (q.q)^-1 = (s)^-1;
.sort


* Kinematics 
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


bracket alpha, s;
.sort
* Save
Format C;
#write <ee_to_mumu.txt> "%e;", Msq;
.sort
* Print
Format;
Print Msq;
.end
