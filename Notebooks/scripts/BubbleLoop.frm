
* Process: BubbleLoop

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
Symbol d;
Dimension d;
#include FeynHelpers.h

Vectors k1,k2;
Symbols e, Mmuon, Melec, y, D1, D2shift;
Symbols bubbleProp, LoopFactor,ep, Scale, pi, Q2, alpha;
CF  A, A0, B, B0, B00, B1, B11, log;


Local Bubble = (-e^2) 
             * g(i1, i2, mu1) * fprop(i2, i3, k1, Melec) 
             * g(i3, i4, mu2) * fprop(i4, i1, k2, Melec);
#call Propagators()
#call doTrace(1,0)
.sort;
id k2 = k1 - q;
.sort

* Replace propagators with D1, D2shift 
id prop( - Melec^2 + k1.k1) = 1/D1 ;
id prop( - Melec^2 + k2.k2) = 1/D2shift;
.sort

Local Numerator = Bubble * D1 * D2shift  ;
.sort
* Drop the bubble for now
Drop Bubble;
.sort;

* shift/replace loop momentum
id k1.k1 = D1 + Melec^2;
id k1.q  = (D1 - D2shift + q.q)/2;
.sort;

* Prepeare for Ward identity
Local WardNum = q(mu1) * Numerator;
.sort
* Re-apply the scalar product identity to the new q.k1 terms
id k1.q = (D1 - D2shift + q.q)/2;
.sort

* Put the propagators back to turn the numerator into an integral
Local WardInt= WardNum * D1^-1 * D2shift^-1;
Local BubbleInt=  Numerator * D1^-1 * D2shift^-1;
.sort
Drop Numerator, WardNum;
.sort

* Apply the cancellations
id D1 * D1^-1 * D2shift^-1 = D2shift^-1;
id D2shift * D1^-1 * D2shift^-1 = D1^-1;
.sort

* Now do Integral replacement
* Tensor Integral (Rank 2)
id k1(mu1?)*k1(mu2?)*D1^-1*D2shift^-1 = d_(mu1,mu2)*B00(q.q,Melec,Melec) 
                                 + q(mu1)*q(mu2)*B11(q.q,Melec,Melec);
.sort
* Vector Integral (Rank 1)
id k1(mu1?)*D1^-1*D2shift^-1 = q(mu1)*B1(q.q,Melec,Melec);
.sort
* Scalar Integral (Rank 0)
id D1^-1*D2shift^-1 = B0(q.q,Melec,Melec);
.sort 
* Vector Tadpole
* The Symmetric Propagator (D1)
id k1(mu1?)*D1^-1 = 0;
* The Shifted Propagator (D2shift)
id k1(mu1?)*D2shift^-1 = q(mu1)*A0(Melec);
.sort 
* Leftover Tadpoles (Rank 0)
id D1^-1 = A0(Melec);
id D2shift^-1 = A0(Melec);
.sort
#message ">>>"
Print +s WardInt ;
.sort;
Skip WardInt;
.sort

* Ward identify should be zero 

* Now we can proceed with PV replacements
id B1(q.q,Melec,Melec) = -1/2 * B0(q.q,Melec,Melec);
id B11(q.q,Melec,Melec) = (A0(Melec) - 2*B00(q.q,Melec,Melec)) / (2*Q2);
id B00(q.q,Melec,Melec) = (A0(Melec) + (2*Melec^2 - Q2/2)*B0(q.q,Melec,Melec)) / (2*(d-1));
.sort 
Local PiRaw = BubbleInt / Q2;
.sort

id B0(q.q, Melec, Melec) = B0(Q2, Melec, Melec);
id A0(Melec) = LoopFactor * Melec^2 * (ep^-1 - log(Melec^2/Scale^2) + 1);
id B0(Q2, Melec, Melec) = LoopFactor * (ep^-1 - log(Q2/Scale^2) + 2);
id LoopFactor = 1/(16*pi^2);
.sort

id d = 4 - 2*ep;
id ( - 2 + 2*d)^-1 = 1/6 * (1 + (2/3)*ep);
id ( - 2 + 2*d)^-2 = 1/36 * (1 + (4/3)*ep);
.sort

* Contract with projector
Local Pif = PiRaw * (d_(mu1,mu2) - q(mu1)*q(mu2)/Q2) / (d-1);
* Handle q related terms and e^2
id q.q = Q2;
id q^2 = Q2;
id q^-2 = Q2^-1;
id e^2 = 4 * pi * alpha;
.sort

* High Energy Cleanup
id Melec^2 * Q2^-1 = 0;
id ep^2 = 0;
.sort

* Done
#message ">>>"
Print +s Pif;
.sort

.end
