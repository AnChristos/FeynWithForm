
* Process: e- gamma -> e- gamma (Compton)
#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
#include FeynHelpers.h

* constants
Symbols me, e, pi, alpha, x;
Vectors q1, q2 ;

Local Ms = (e^2) * UB(i1, p3, me) * gamma(i1, i2, mu2) * esum(mu1, p2) 
                 * fprop(i2, i3, q1, me) 
                 * gamma(i3, i4, mu1) * U(i4, p1, me) * esum(mu2, p4);

Local Mu = (e^2) * UB(i1, p3, me) * gamma(i1, i2, mu1) * esum(mu1, p2)
                 * fprop(i2, i3, q2 , me) 
                 * gamma(i3, i4, mu2) * U(i4, p1, me) * esum(mu2, p4);


Local Mtot = Ms + Mu;

* Square the total amplitude
#call squareamplitude(Mtot, Msq)
.sort

* Spin averaging (1/2 * 1/2)
multiply 1/4; 
* coupling
id e^4 = 16 * pi^2 * alpha^2;
* propagator handling

repeat;
    id q1 = p1 + p2;
    id q2 = p1 - p4;
endrepeat;
id prop(x?) = (x)^-1;
id (-me^2 + q1.q1)^-1 = (s - me^2)^-1;
id (-me^2 + q2.q2)^-1 = (u - me^2)^-1;
.sort

* Kinematics 
#call Mandelstam2To2(p1,p2,p3,p4,me,0,me,0)

* Final clean up
id t = 2*me^2 - s - u;

Bracket s, alpha, pi ;
* Save
Format C;
#write <../Results/Compton.txt> "%e;", Msq;
.sort

* Print
Format;
Print+s  Msq;
.end
