*-------------------------------------------------------------------------*
* amplitude.h
*
* Core Procedure: squareamplitude 
* Description:
* FORM procedure for squaring Feynman amplitudes, 
* performing spin sums, and evaluating Dirac traces.
* 
* Original from: Jos Vermaseren
* J.A.M.Vermaseren "New features of FORM" math-ph/0010025
* Based on material from:  
* https://www.nikhef.nl/~form/maindir/courses/uam2019/uam2019.html
*-------------------------------------------------------------------------*

AutoDeclare Index i,mu,k;
AutoDeclare Symbol m,x;
AutoDeclare Vector p,q;
Vector q,q1,q2,p1,...,p10;
CF  UB,U,VB,V,g,eps,epsM;
CF  fprop,phprop,Zprop,Wprop,prop;
Index k5=0, k6=0, k7=0;



*
*
#procedure squareamplitude(Amp,Mat)
.sort
*
*   We skip everything but Amp. In Amp we look for the highest i and mu indices
*
Skip;
NSkip `Amp';
#$imax = 0;
#do i = 1,40
    if ( match(VB(i`i',?a)) || match(V(i`i',?a))
         || match(UB(i`i',?a)) || match(U(i`i',?a))
         || match(g(i`i',?a)) || match(g(i?,i`i',?a))
         || match(fprop(i`i',?a)) || match(fprop(i?,i`i',?a)) );
            $imax = `i';
    endif;
#enddo
#$mumax = 0;
#do mu = 1,20
    if ( match(g(?a,mu`mu')) 
         || match(phprop(mu`mu',?a)) || match(phprop(mu?,mu`mu',?a)) 
         || match(Zprop(mu`mu',?a)) || match(Zprop(mu?,mu`mu',?a))
         || match(Wprop(mu`mu',?a)) || match(Wprop(mu?,mu`mu',?a)) );
        $mumax = `mu';
    endif;
#enddo
.sort:amplitude-1;
*
*   Now construct the conjugate
*
Skip;
#call conjugate(`Amp',`Amp'C, `$imax', `$mumax');
.sort:amplitude-2;
*
*   Now multiply Amp and AmpC to get the matrix element squared.
*
Skip;
Drop,`Amp',`Amp'C;
L   `Mat' = `Amp'*`Amp'C;
*
*   Spin sums
*
id  U(i1?,p?,m?)*UB(i2?,p?,m?) =  g(i1,i2,p)+g(i1,i2)*m;
id  V(i1?,p?,m?)*VB(i2?,p?,m?) =  g(i1,i2,p)-g(i1,i2)*m;
id  eps(mu1?,p?)*eps(mu2?,p?) = -d_(mu1,mu2);
id  epsM(mu1?, p?, m?)*epsM(mu2?, p?, m?) = -d_(mu1,mu2) + p(mu1)*p(mu2)/(m^2);
*
*   Propagators
*
id  fprop(i1?,i2?,p?,m?) = (g(i1,i2,p)+g(i1,i2)*m)*prop(p.p-m^2);
id  phprop(mu1?,mu2?,q?) = -d_(mu1,mu2)*prop(q.q);
id  Zprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1)*q(mu2)/(m^2)) * prop(q.q - m^2);
id  Wprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1)*q(mu2)/(m^2)) * prop(q.q - m^2);
.sort:amplitude-3;
*
* formTrace
*
Skip;
NSkip `Mat';
#call doTrace(`Mat')
#endprocedure


*
*
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

*
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

