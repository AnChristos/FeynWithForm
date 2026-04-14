#ifndef `UTILSH'
#define UTILSH "1"
*-------------------------------------------------------------------------*
* Trace.h
* 
* Based on material from:  
* https://www.nikhef.nl/~form/maindir/courses/uam2019/uam2019.html
*-------------------------------------------------------------------------*

#include Symbols.h

*--------------------------------------------------------
* Procedure: doTrace 
* Description Glues gamma chains and executes Dirac traces
* ------------------------------------------------------
*
#procedure doTrace(Mat)

*
*   String the gamma matrices together in traces.
*

repeat;
    id g(i1?,i2?,?a) * g(i2?,i3?,?b) = g(i1,i3,?a,?b);
endrepeat; 
.sort:chains-glued;

*
*   Now put the traces one by one in terms of the built in gammas
*
#do i = 1,10
    id,once,g(i1?,i1?,?a) = g_(`i',?a);
    id  g_(`i',k7) = g7_(`i');
    al  g_(`i',k6) = g6_(`i');
    al  g_(`i',k5) = g5_(`i');
#enddo
.sort:built-in-gamma;
*
*   Finally take the traces
*
#do i = 1,10
Trace4,`i';
#enddo

#endprocedure

*--------------------------------------------------------
* Procedure: conjugate 
* Description Forming the conjugate 
* ------------------------------------------------------
#procedure conjugate(Amp, AmpC, imax, mumax)
* Create the conjugate expression
*
L   `AmpC' = `Amp';
id  i_ = -i_;

*   Make a new set of dummy indices above $imax and $mumax.
#do i = 1, `$imax'
    #$ioffset = `$imax' + `i';
    Multiply replace_(i`i', i`$ioffset');
#enddo

#do mu = 1, `$mumax'
    #$muoffset = `$mumax' + `mu';
    Multiply replace_(mu`mu', mu`$muoffset');
#enddo

* Exchange rows/columns (Transpose)
id  g(i1?,i2?,mu?) = g(i2,i1,mu);
id  fprop(i1?,i2?,?a) = fprop(i2,i1,?a);
id  phprop(mu1?,mu2?,p?) = phprop(mu2,mu1,p);
id  Zprop(mu1?,mu2?,?a) = Zprop(mu2,mu1,?a);
id  Wprop(mu1?,mu2?,?a) = Wprop(mu2,mu1,?a);

* Swap Spinors 
Multiply replace_(UB,U,U,UB,VB,V,V,VB);
* Swap k6 and k7 (1-gamma^5)/2 <->(1+gamma^5)2
Multiply replace_(k6,k7,k7,k6);
* gamma5 minus sign
id  g(?a,k5) = -g(?a,k5);
.sort
#endprocedure 


#endif