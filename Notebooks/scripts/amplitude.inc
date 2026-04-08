*-------------------------------------------------------------------------*
* amplitude.h
* Core Procedure: squareamplitude
* Original Author: Jos Vermaseren (NIKHEF)
*
* Description:
* A general-purpose FORM procedure for squaring Feynman amplitudes, 
* performing spin sums, and evaluating Dirac traces.
*-------------------------------------------------------------------------*

AutoDeclare Index i,j,k;
AutoDeclare Symbol m,x;
AutoDeclare Vector p,q;
Vector q,pe,pp,pa,pb,q1,q2,p1,...,p10;
CF  UB,U,VB,V,g,gstring,e;
CF  fprop,phprop,gprop,prop;
Index k5=0, k6=0, k7=0;
*
*
#procedure squareamplitude(Amp,Mat)
.sort
*
*   We skip everything but Amp. In Amp we look for the highest i and j indices
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
#$jmax = 0;
#do j = 1,20
    if ( match(g(?a,j`j')) || match(phprop(j`j',?a)) || match(phprop(j?,j`j',?a)) );
        $jmax = `j';
    endif;
#enddo
.sort:amplitude-1;
*
*   Just for a check we print the highest i and j indices
*
#message highest i is i`$imax', highest j is j`$jmax';
*
*   Now construct the conjugate
*
Skip;
L   `Amp'C = `Amp';
id  i_ = -i_;
*
*   Make a new set of dummy indices above $imax and $jmax.
*
Multiply replace_(<i1,i{`$imax'+1}>,...,<i`$imax',i{2*`$imax'}>);
Multiply replace_(<j1,j{`$jmax'+1}>,...,<j`$jmax',j{2*`$jmax'}>);
*
*   Exchange rows and columns
*
id  g(i1?,i2?,j?) = g(i2,i1,j);
id  fprop(i1?,i2?,?a) = fprop(i2,i1,?a);
id  phprop(j1?,j2?,p?) = phprop(j2,j1,p);
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
id  e(j1?,p?)*e(j2?,p?) = -d_(j1,j2);
*
*   Propagators
*
id  fprop(i1?,i2?,p?,m?) = (g(i1,i2,p)+g(i1,i2)*m)*prop(p.p-m^2);
id  phprop(j1?,j2?,q?) = -d_(j1,j2)*prop(q.q);
*
*   String the gamma matrices together in traces.
*
repeat id g(i1?,i2?,?a)*g(i2?,i3?,?b) = g(i1,i3,?a,?b);
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

