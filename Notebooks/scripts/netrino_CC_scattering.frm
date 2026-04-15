
* Process: nu_mu e- -> nu_e mu - 

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include SquareAmplitude.h

* Physical constants
Symbols mW, gweak, mMuon,x;


Local Mneutrino = (gweak^2/ 2 ) * (UB(i1, p3, mMuon) * g(i1, i2, mu1) * g(i2, i3, k7)* U(i3, p1, 0))  
                               * Wprop(mu1, mu2, q, mW) 
                               * (UB(i4, p4, 0) * g(i4, i5, mu2) * g(i5, i6, k7)* U(i6, p2, 0)) ;

#call squareamplitude(Mneutrino, Msqneutrino)
.sort

* Spin averaging (1/2)
multiply 1/2; 
.sort

* propagator handling
id prop(x?) = (x)^-1;
id (-mW^2 + q.q)^-1 = (mW^2)^-1;
repeat;
    id q = p1 - p3;
endrepeat;
.sort

* kinematics
#call Mandelstam2To2(p1,p2,p3,p4,0,0,mMuon,0)

* Final clean up
id u = mMuon^2 - s - t;
.sort


Bracket s, mW, gweak;
.sort            
* Print
Format;
Print +s Msqneutrino;
.end
