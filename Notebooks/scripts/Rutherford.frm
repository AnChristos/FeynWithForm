
* Process: Rutherford

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include SquareAmplitude.h

* Physical constants
Symbols e, pi, alpha, Mproton, x;

Local M =     (e^2) * (UB(i1, p3, 0) * g(i1, i2, mu1) * U(i2, p1, 0)) 
                    * phprop(mu1, mu2, q)  
                    * (UB(i3, p4, Mproton) * g(i3, i4, mu2) * U(i4, p2, Mproton));
#call squareamplitude(M, Msq)
.sort

* Spin averaging (1/2 * 1/2)
multiply 1/4; 
* coupling
id e^4 = 16 * pi^2 * alpha^2;
* propagator handling
id prop(x?) = (x)^-1;
id (q.q)^-1 = (t)^-1;
repeat;
    id q = p1 - p3;
endrepeat;
.sort

* Kinematics 
#call Mandelstam2To2(p1,p2,p3,p4,0,Mproton,0,Mproton)

* Further clean up
id u = 2*Mproton^2 - s - t;

bracket alpha, s;
.sort
* Save
Format C;
#write <Rutherford.txt> "%e;", Msq;
.sort
* Print
Format;
Print Msq;
.end
