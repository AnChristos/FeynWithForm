*-------------------------------------------------------------------------*
* SquareAmplitude.h
*
* Based on material from:  
* https://www.nikhef.nl/~form/maindir/courses/uam2019/uam2019.html
*-------------------------------------------------------------------------*
#include Utils.h

*--------------------------------------------------------
* Procedure: squareamplitude 
* Description: Calculate Feynman amplitudes squared. 
* ------------------------------------------------------
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
* doTrace
*
Skip;
NSkip `Mat';
#call doTrace(`Mat')
#endprocedure


