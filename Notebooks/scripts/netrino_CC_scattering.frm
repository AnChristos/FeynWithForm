
* Process: nu_mu e- -> nu_e mu - 

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

#include SquareAmplitude.h

* Physical constants
Symbols mW, gweak, mMuon;


Local Mneutrino = (gweak^2/ 2 ) * (UB(i1, p3, mMuon) * g(i1, i2, mu1) * g(i2, i3, k7)* U(i3, p1, 0))  
                               * Wprop(mu1, mu2, q, mW) 
                               * (UB(i4, p4, 0) * g(i4, i5, mu2) * g(i5, i6, k7)* U(i6, p2, 0)) ;

#call squareamplitude(Mneutrino, Msqneutrino)
.sort

* Spin averaging (1/2)
multiply 1/2; 
* propagator handling
id q = p1 - p3;
id prop(x?) = (x)^-1;
id (q.q)^-1 = (t)^-1;
id (-mW^2 + q.q)^-1 = -1/(mW^2);
.sort

repeat;
id p1.p1 = 0;
id p2.p2 = 0;
id p4.p4 = 0;
id p3.p3 = mMuon^2;

id p1.p2 = s/2;
id p1.p4 = -u/2;
id p1.p3 = (mMuon^2 - t)/2;
id p2.p3 = (s + t - mMuon^2)/2;
id p2.p4 = (mMuon^2 - t)/2;
id p3.p4 = (s - mMuon^2)/2;

id t = mMuon^2 - s - u;

endrepeat;
.sort;

Bracket s, mW, gweak;
.sort            
* Print
Format;
Print +s Msqneutrino;
.end
