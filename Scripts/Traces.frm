
* Trace manipulation

#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;
Symbol m1,m2;

#include FeynHelpers.h

* The Trace of 2 matrices:
Local Trace2 = gamma(i1, i2, mu1) * gamma(i2, i1, mu2);

* The Trace of 3 matrices:
Local Trace3 = gamma(i1, i2, mu1) * gamma(i2, i3, mu2) * gamma(i3, i1, mu3);

* The Trace of 4 matrices:
Local Trace4 = gamma(i1, i2, mu1) * gamma(i2, i3, mu2) * gamma(i3, i4, mu3) * gamma(i4, i1, mu4);

* Trace of g5 with 4 matrices 
Local TraceG5With4 = gamma(i1, i2, k5) * gamma(i2, i3, mu1) * gamma(i3, i4, mu2) * gamma(i4, i5, mu3) * gamma(i5, i1, mu4);

* cv, ca Trace  
Local cvcaTrace = 
    gamma(i1, i2, mu1) * 1/2 * ((cv+ca)*gamma(i2, i3, k7) + (cv-ca)*gamma(i2, i3, k6)) * (gamma(i3, i4, p1) + m1*gamma(i3, i4)) *
    gamma(i4, i5, mu2) * 1/2 * ((cv+ca)*gamma(i5, i6, k7) + (cv-ca)*gamma(i5, i6, k6)) * (gamma(i6, i1, p2) + m2*gamma(i6, i1));

#call doTrace(5,0)



* Group terms by the physical couplings and masses
Bracket cv, ca, m1, m2;
.sort
Print;
.end
