
* Trace manipulation

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
Symbols cv,ca;

#include amplitude.h

* The Trace of 2 matrices:
Local Trace2 = g(i1, i2, mu1) * g(i2, i1, mu2);


* The Trace of 3 matrices:
Local Trace3 = g(i1, i2, mu1) * g(i2, i3, mu2) * g(i3, i1, mu3);


* The Trace of 4 matrices:
Local Trace4 = g(i1, i2, mu1) * g(i2, i3, mu2) * g(i3, i4, mu3) * g(i4, i1, mu4);


* 5. Trace of g5 with 4 matrices 
Local TraceG5With4 = g(i1, i2, k5) * g(i2, i3, mu1) * g(i3, i4, mu2) * g(i4, i5, mu3) * g(i5, i1, mu4);


* 6. cv, ca Trace  
Local cvcaTrace = 
    g(i1, i2, mu1) * 1/2 * ((cv+ca)*g(i2, i3, k7) + (cv-ca)*g(i2, i3, k6)) * (g(i3, i4, p1) + m1*g(i3, i4)) *
    g(i4, i5, mu2) * 1/2 * ((cv+ca)*g(i5, i6, k7) + (cv-ca)*g(i5, i6, k6)) * (g(i6, i1, p2) + m2*g(i6, i1));

#call doTrace(Trace2)
#call doTrace(Trace3)
#call doTrace(Trace4)
#call doTrace(TraceG5With4)
#call doTrace(cvcaTrace)


* Group terms by the physical couplings and masses
Bracket cv, ca, m1, m2;
.sort
Print;
.end
