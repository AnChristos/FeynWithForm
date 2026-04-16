
* Process: Renormalization

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
#include SquareAmplitude.h

Symbols e, Mmuon, Melec, x;
Vectors k, kf1, kf2, kq;
Symbols k2 , kminusq2, kdotp1, kminusqdotp2, kdotkminusq;


Local MLO = (e^2) * (UB(i1, p3, Melec ) * g(i1, i2, mu1) * U(i2, p1, Melec))
            * phprop(mu1, mu2, q)
            * (UB(i3, p4, Mmuon) * g(i3, i4, mu2) * U(i4, p2, Mmuon));

* UB(i1, p3) [Outgoing] -> g(i1,i2,mu3) [Loop Absorption] -> fprop(i2,i3,kf2) [Internal Prop 2] 
* -> g(i3,i4,mu1) [Main Interaction] -> fprop(i4,i5,kf1) [Internal Prop 1] 
* -> g(i5,i6,mu3) [Loop Emission] -> U(i6, p1) [Incoming]
Local MNLO = (e^4) * (UB(i1, p3, Melec) 
                  * g(i1, i2, mu3) 
                  * fprop(i2, i3, kf2, Melec) 
                  * g(i3, i4, mu1) 
                  * fprop(i4, i5, kf1, Melec) 
                  * g(i5, i6, mu4) 
                  * U(i6, p1, Melec))
                  * phprop(mu3, mu4, kq)
                  * phprop(mu1, mu2, q)
                  * (UB(i7, p4, Mmuon) * g(i7, i8, mu2) * U(i8, p2, Mmuon));

Local MTotal = MLO+MNLO;
#call squareamplitude(MLO, MsqLO)
#call squareamplitude(MNLO, MsqNLO)
#call squareamplitude(MTotal, MsqTotal)
.sort

Drop drop MsqLO, MsqNLO, MsqTotal, MLO, MNLO, MTotal ;
Local MInt = MsqTotal - MsqLO - MsqNLO;
.sort

Multiply 1/4;
.sort

* --- KINEMATIC DEFINITIONS ---
* q = p1 - p3 (Momentum transfer)
* t = q.q (Mandelstam t)
* k = loop momentum
* kf1 = k (First internal fermion line)
* kf2 = k - q (Second internal fermion line)
* kq = q (Photon momentum for loop)

* --- MASSLESS APPROXIMATION ---
* keeps the Melec in the fermion propagator
id Melec = 0;
id Mmuon = 0;
#call Mandelstam2To2(p1,p2,p3,p4,0,0,0,0)

* Replace the propagator function with algebraic denominators
id prop(q.q) = 1/t;
id prop(kq.kq) = 1/t;
id prop(-Melec^2 + kf1.kf1) = 1/(-Melec^2 +k2);
id prop(-Melec^2 + kf2.kf2) = 1/(-Melec^2 +kminusq2);

* Replace dot products involving loop momentum k
id kf1.p1? = kdotp1;
id kf2.p2? = kminusqdotp2;
id kf1.kf2 = kdotkminusq;
.sort

* Save to file 
Format C;
#write <Renormalization.txt> "%e;", MInt;
.sort
* Print 
Format;
Print+s MInt;

.end
