
* Trace manipulation
#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

CF g;
AutoDeclare Index i,mu;
Index k5=0, k6=0, k7=0;
Vector p1,...,p10;
Symbols cv, ca, m1, m2;

* -----------------------------------------------------
* The internal convention of form 
* can be found at 
* https://form-dev.github.io/form-docs/stable/manual
*
* Here is the summary
*  {g_(j1,mu1),g_(j1,mu2)} = 2 * d_(mu1,mu2)
*  [g_(j1,mu1),g_(j2,mu2)] = 0    j1 not equal to j2.
* 
*.   The basis of the algebra (4D) is given 
*    gi_(j) unit matrix
*    g_(j,mu1)
*    [g_(j,mu1),g_(j,mu2)]/2
*    g5_(j)*g_(j,mu1)
*    g5_(j)
* -----------------------------------------------------
* 
* When we write the physics amplitudes 
* We want the internal "Amplitude.inc"
* to take care of the conjugation,
* contraction and trace
* We effectively write
* g(i1, i2, mu1) * g(i2, i1, mu2)
* That is 
* sum_{i1, i2} (gamma^mu1)_{i1,i2} * (gamma^mu2)_{i2,i1}
* Note that the indices "close"
* i1->i2->i1
* There is repeat loop (here shown explicitly)
* that performs the "index contraction".
* Then traces can be calculated over 
* indices by FORM internal engine
* -----------------------------------------------------




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


repeat;
* Handle:
* 1. g(i1,i2,?a)*g(i2,i3,?b) -> g(i1,i3,?a,?b)
    id g(i1?,i2?,?a) * g(i2?,i3?,?b) = g(i1,i3,?a,?b);
endrepeat;

* Translation to Built-in
#do i = 1,10
    id,once,g(i1?,i1?,?a) = g_(`i',?a);
    id  g_(`i',k7) = g7_(`i');
    al  g_(`i',k6) = g6_(`i');
    al  g_(`i',k5) = g5_(`i');
#enddo

* Evaluate Traces
#do i = 1,10
    Trace4,`i';
#enddo
.sort

* Group terms by the physical couplings and masses
Bracket cv, ca, m1, m2;
.sort
Print;
.end
