
* Process: e- gamma -> e- gamma (Compton)
#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
#include amplitude.inc

* Kinematic variables
Symbols s, t, u, me, E3E1ratioSq, PreFac;
* constants
Symbols e, pi, alpha;

Local Ms = (e^2) * UB(i1, p3, me) * g(i1, i2, mu2) * eps(mu1, p2) 
                 * fprop(i2, i3, q1, me) 
                 * g(i3, i4, mu1) * U(i4, p1, me) * eps(mu2, p4);

Local Mu = (e^2) * UB(i1, p3, me) * g(i1, i2, mu1) * eps(mu1, p2)
                 * fprop(i2, i3, q2 , me) 
                 * g(i3, i4, mu2) * U(i4, p1, me) * eps(mu2, p4);


Local Mtot = Ms + Mu;

* Square the total amplitude
#call squareamplitude(Mtot, Msq)
.sort
* Average over initial spins (1/2) and polarizations (1/2) = 1/4
multiply 1/4;
.sort 

* conservation
id q1 = p1 + p2;
id q2 = p1 - p4;
.sort
* propagator handling
id prop(x?) = (x)^-1;
.sort
id (q1.q1)^-1 = (s)^-1;
id (q2.q2)^-1 = (u)^-1;
id (-me^2 + q1.q1)^-1 = (s - me^2)^-1;
id (-me^2 + q2.q2)^-1 = (u - me^2)^-1;
.sort 
* Mandelstam 
id q1.q1 = s;
id q2.q2 = u;
.sort
repeat;
    id p1.p1 = me^2;
    id p3.p3 = me^2;
    id p2.p2 = 0;
    id p4.p4 = 0;

    id p1.p2 = (s - me^2)/2;
    id p3.p4 = (s - me^2)/2;
    id p1.p4 = (me^2 - u)/2;
    id p2.p3 = (me^2 - u)/2;
    id p1.p3 = (2*me^2 - t)/2;
    id p2.p4 = -t/2;
endrepeat;
.sort
id e^4 = 16 * pi^2 * alpha^2;
.sort
Local dSigmaLab = PreFac * Msq;
.sort
id PreFac = ((1 / (64 * pi^2 * me^2)) * E3E1ratioSq);
.sort

Bracket s, alpha,E3E1ratioSq, pi ;
.sort
* Save
Format C;
#write <Compton.txt> "%e;", dSigmaLab;
.sort

* Print
Format;
Format;
Print+s  Msq;
Print+s  dSigmaLab;
.end
