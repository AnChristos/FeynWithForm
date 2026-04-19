
* Process: Renormalization

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

Symbol dim;
Dimension dim;
#include FeynHelpers.h

Vectors k1,k2;
Symbols e, Mmuon, Melec;
Symbols y, D1, D2, bubbleProp;
Symbols qmu1, qmu2, gmu1mu2;

CF  A, A0, B, B0, B00, B1, B11;


#message "This bubble is inside a 4D integral "
Local Bubble = (-e^2) 
             * g(i1, i2, mu1) * fprop(i2, i3, k1, Melec) 
             * g(i3, i4, mu2) * fprop(i4, i1, k2, Melec);
#message "This is the row Loop electron bubble "
Print +ss Bubble;

#call Propagators()
#call doTrace(1,1)
.sort
#message ">>> STEP 1: Bubble after traces"
Print +s Bubble ;
.sort

id k2 = k1 - q;
id k2(mu1) = k1(mu1) - q(mu1);
id k2(mu2) = k1(mu2) - q(mu2);
.sort
#message ">>> STEP 2: after k2 = k1 - q"
print +s Bubble;



.end
