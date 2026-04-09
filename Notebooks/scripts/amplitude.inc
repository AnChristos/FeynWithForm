*-------------------------------------------------------------------------*
* amplitude.inc
* Original from: Jos Vermaseren (NIKHEF)
* See also : J.A.M.Vermaseren "New features of FORM" math-ph/0010025
*
* Core Procedure: squareamplitude 
* Description:
* FORM procedure for squaring Feynman amplitudes, 
* performing spin sums, and evaluating Dirac traces.
*-------------------------------------------------------------------------*

AutoDeclare Index i,mu,k;
AutoDeclare Symbol m,x;
AutoDeclare Vector p,q;
Vector q,q1,q2,p1,...,p10;
CF  UB,U,VB,V,g,eps;
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
L   `Amp'C = `Amp';
id  i_ = -i_;
*
*   Make a new set of dummy indices above $imax and $mumax.
*
Multiply replace_(<i1,i{`$imax'+1}>,...,<i`$imax',i{2*`$imax'}>);
Multiply replace_(<mu1,mu{`$mumax'+1}>,...,<mu`$mumax',mu{2*`$mumax'}>);
*
*   Exchange rows and columns
*
id  g(i1?,i2?,mu?) = g(i2,i1,mu);
id  fprop(i1?,i2?,?a) = fprop(i2,i1,?a);
id  phprop(mu1?,mu2?,p?) = phprop(mu2,mu1,p);
id  Zprop(mu1?,mu2?,?a) = Zprop(mu2,mu1,?a);
id  Wprop(mu1?,mu2?,?a) = Wprop(mu2,mu1,?a);
*
*   and exchange U and UB, V and VBAR
*
Multiply replace_(UB,U,U,UB,VB,V,V,VB);
*
*   gamma5 gets a minus sign. Hence k6 <--> k7
*
Multiply replace_(k6,k7,k7,k6);
id  g(?a,k5) = -g(?a,k5);
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
id  V(i1?,p?,m?)*VB(i2?,p?,m?) = -g(i1,i2,p)+g(i1,i2)*m;
id  eps(mu1?,p?)*eps(mu2?,p?) = -d_(mu1,mu2);
*
*   Propagators
*
id  fprop(i1?,i2?,p?,m?) = (g(i1,i2,p)+g(i1,i2)*m)*prop(p.p-m^2);
id  phprop(mu1?,mu2?,q?) = -d_(mu1,mu2)*prop(q.q);
id  Zprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1)*q(mu2)/(m^2)) * prop(q.q - m^2);
id  Wprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1)*q(mu2)/(m^2)) * prop(q.q - m^2);
*
*   String the gamma matrices together in traces.
*
repeat;
* Handle:
* 1. g(i1,i2,?a)*g(i2,i3,?b) -> g(i1,i3,?a,?b)
* 2. g(i1,i2)*g(i2,i3,?a)    -> g(i1,i3,?a)
* 3. g(i1,i2)*g(i2,i3)       -> g(i1,i3)
    id g(i1?,i2?,?a) * g(i2?,i3?,?b) = g(i1,i3,?a,?b);

* Handle  Unit with both indices matching gamma
    id g(i1?,i2?) * g(i1?,i2?,?a) = g(i1,i1,?a);
    id g(i1?,i2?) * g(i2?,i1?,?a) = g(i1,i1,?a);
endrepeat;

.sort:amplitude-3;
Skip;
NSkip `Mat';
*
*   Now put the traces one by one in terms of the built in gammas
*
#do i = 1,10
    id,once,g(i1?,i1?,?a) = g_(`i',?a);
    id  g_(`i',k7) = g7_(`i');
    al  g_(`i',k6) = g6_(`i');
    al  g_(`i',k5) = g5_(`i');
#enddo
.sort:amplitude-4;
*
*   Finally take the traces
*
#do i = 1,10
Trace4,`i';
#enddo
#endprocedure

