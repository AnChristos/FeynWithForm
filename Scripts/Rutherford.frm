
* Process: Rutherford

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include FeynHelpers.h

Symbols e, pi, alpha, Mproton, x;

Local M =     (e^2) * (UB(i1, p3, 0) * gamma(i1, i2, mu1) * U(i2, p1, 0)) 
                    * phprop(mu1, mu2, q)  
                    * (UB(i3, p4, Mproton) * gamma(i3, i4, mu2) * U(i4, p2, Mproton));

Local Mscalar = (e^2) * (p1(mu1) + p3(mu1)) 
                      * phprop(mu1, mu2, q) 
                      * (p2(mu2) + p4(mu2));
.sort
#call squareamplitude(M, MsqNoAv)
#call squareamplitude(Mscalar, Msqscalar)
.sort
Local Msq = 1/4 * MsqNoAv;
.sort
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
#write <ee_pp.txt> "%e;", Msq;
#write <ee_scalar_pp.txt> "%e;", Msqscalar;
.sort
* Print
Format;
Print+s Msq;
Print+s Msqscalar;
.end
