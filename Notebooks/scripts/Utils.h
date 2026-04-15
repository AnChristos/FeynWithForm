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
#do i = 1, `MAXTRACE'
    id,once,g(i1?,i1?,?a) = g_(`i',?a);
    id  g_(`i',k7) = g7_(`i');
    al  g_(`i',k6) = g6_(`i');
    al  g_(`i',k5) = g5_(`i');
#enddo
.sort:built-in-gamma;
*
*   Finally take the traces
*
#do i = 1,`MAXTRACE'
Trace4,`i';
#enddo

#endprocedure


*--------------------------------------------------------
* Procedure: Propagators
* Description: Do the Propagator replacement
* ------------------------------------------------------
#procedure Propagators(Mat)

* Internal Propagators
id  fprop(i1?,i2?,p?,m?) = (g(i1,i2,p)+g(i1,i2)*m)*prop(p.p-m^2);
id  phprop(mu1?,mu2?,q?) = -d_(mu1,mu2)*prop(q.q);
id  Zprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1)*q(mu2)/(m^2)) * prop(q.q - m^2);
id  Wprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1)*q(mu2)/(m^2)) * prop(q.q - m^2);
.sort:propagators;

#endprocedure

*--------------------------------------------------------
* Procedure: SpinSum
* Description: Do the spinSum replacements
* ------------------------------------------------------
#procedure SpinSum(Mat)

* Spin sums for external particles
id  U(i1?,p?,m?)*UB(i2?,p?,m?) =  g(i1,i2,p)+g(i1,i2)*m;
id  V(i1?,p?,m?)*VB(i2?,p?,m?) =  g(i1,i2,p)-g(i1,i2)*m;
id  eps(mu1?,p?)*eps(mu2?,p?) = -d_(mu1,mu2);
id  epsM(mu1?, p?, m?)*epsM(mu2?, p?, m?) = -d_(mu1,mu2) + p(mu1)*p(mu2)/(m^2);
.sort:spinsum;


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


*-------------------------------------------------------------------------*
* Procedure: Mandelstam2To2
* p1, p2: Initial state vectors
* p3, p4: Final state vectors
* m1, m2, m3, m4: Masses of the respective particles
*-------------------------------------------------------------------------*
#procedure Mandelstam2To2(p1, p2, p3, p4, m1, m2, m3, m4)
repeat;
    id `p1'.`p1' = `m1'^2;
    id `p2'.`p2' = `m2'^2;
    id `p3'.`p3' = `m3'^2;
    id `p4'.`p4' = `m4'^2;

* s-channel combinations
    id `p1'.`p2' = (s - `m1'^2 - `m2'^2)/2;
    id `p3'.`p4' = (s - `m3'^2 - `m4'^2)/2;

* t-channel combinations
    id `p1'.`p3' = (`m1'^2 + `m3'^2 - t)/2;
    id `p2'.`p4' = (`m2'^2 + `m4'^2 - t)/2;

* u-channel combinations
    id `p1'.`p4' = (`m1'^2 + `m4'^2 - u)/2;
    id `p2'.`p3' = (`m2'^2 + `m3'^2 - u)/2;
endrepeat;

.sort:kinematics-applied;
#endprocedure

#endif