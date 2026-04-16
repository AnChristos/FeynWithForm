
* Process: Renormalization

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
#include SquareAmplitude.h

Symbols e, Mmuon, Melec, x;
Vectors k, kf1, kf2;
Symbols k2 , kminusq2, kdotp1, kminusqdotp2, kdotkminusq;


Local MLO = (e^2) * (UB(i1, p3, Melec ) * g(i1, i2, mu1) * U(i2, p1, Melec))
            * phprop(mu1, mu2, q)
            * (UB(i3, p4, Mmuon) * g(i3, i4, mu2) * U(i4, p2, Mmuon));

Local MNLO = -1* (e^4) 
             * (UB(i1, p3, Melec) * g(i1, i2, mu1) * U(i2, p1, Melec)) 
             * phprop(mu1, mu3, q) 
             * g(i11, i12, mu3) * fprop(i12, i13, kf1, Melec) 
             * g(i13, i14, mu4) * fprop(i14, i11, kf2, Melec)
             * phprop(mu4, mu2, q)
             * (UB(i7, p4, Mmuon) * g(i7, i8, mu2) * U(i8, p2, Mmuon));

Local MTotal = MLO+MNLO;
#call squareamplitude(MLO, MsqLO)
#call squareamplitude(MNLO, MsqNLO)
#call squareamplitude(MTotal, MsqTotal)
.sort
Multiply 1/4;
.sort
Drop drop MsqNLO, MsqTotal, MLO, MNLO, MTotal ;
Local MInt = MsqTotal - MsqLO - MsqNLO;
.sort


* --- KINEMATIC DEFINITIONS: VACUUM POLARIZATION ---
* q  = p1 - p3           : Momentum transfer between electron and muon lines
* t  = q.q               : Mandelstam variable t (photon momentum squared)
* k  = loop momentum     : Integration variable for the fermion loop
* kf1 = k                : Momentum of the first fermion in the bubble
* kf2 = k - q            : Momentum of the second fermion in the bubble (cons. of momentum)

* Replace the propagator function with algebraic denominators
id prop(q.q) = 1/t;
id prop(-Melec^2 + kf1.kf1) = 1/(-Melec^2 +k2);
id prop(-Melec^2 + kf2.kf2) = 1/(-Melec^2 +kminusq2);

* Replace dot products involving loop momentum k
id kf1.p1? = kdotp1;
id kf2.p2? = kminusqdotp2;
id kf1.kf2 = kdotkminusq;
.sort

* --- MASSLESS APPROXIMATION ---
* keeps the Melec in the fermion propagator
id Melec = 0;
id Mmuon = 0;
#call Mandelstam2To2(p1,p2,p3,p4,0,0,0,0)
id u = -s -t;

* Save to file 
Format C;
#write <RenormalizationLO.txt> "%e;", MsqLO;
#write <Renormalization.txt> "%e;", MInt;
.sort
* Print 
Format;
Print+s MInt;
Print+s MsqLO;

.end
