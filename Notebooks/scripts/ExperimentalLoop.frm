
* Process: ExperimentalLoop

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

Symbol dim;
Dimension dim;
#include FeynHelpers.h

Vectors k1,k2;
Symbols e, Mmuon, Melec;
Symbols y, D1, D2shift, bubbleProp;
Symbols qmu1, qmu2, gmu1mu2;
CF  A, A0, B, B0, B00, B1, B11;


Local Bubble = (-e^2) 
             * g(i1, i2, mu1) * fprop(i2, i3, k1, Melec) 
             * g(i3, i4, mu2) * fprop(i4, i1, k2, Melec);
Print +ss Bubble;
#call Propagators()
#call doTrace(1,1)
.sort
#message ">>>"
Print +s Bubble ;
.sort

* Replace propagators with D1, D2shift 
id prop( - Melec^2 + k1.k1) = 1/D1 ;
id prop( - Melec^2 + k2.k2) = 1/D2shift;
.sort
Local Numerator = Bubble * D1 * D2shift  ;
#message ">>>"
Print +s Numerator ;
.sort
* Drop the bubble for now
Drop Bubble;
.sort;

* shift/replace loop momentum
id k2 = k1 - q;
id k1.k1 = D1 + Melec^2;
id k1.q  = (D1 - D2shift + q.q)/2;
.sort
#message ">>>"
Print +s Numerator ;
.sort;

Local WardNum = q(mu1) * Numerator;
.sort
* Re-apply the scalar product identity to the new q.k1 terms
id k1.q = (D1 - D2shift + q.q)/2;
.sort
#message ">>>"
Print +s Numerator ;
Print +s WardNum ;
.sort;

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
#message ">>>"
Print +s WardInt ;
Print +s BubbleInt ;
.sort;

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
Print +s BubbleInt ;
.sort;


.end
