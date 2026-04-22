#procedure squareamplitude(Amp,Mat)
*--------------------------------------------------------
* Procedure: squareamplitude 
* Description: Calculate Feynman amplitudes squared. 
* ------------------------------------------------------
*
.sort
*
*   We skip everything but Amp. In Amp we look for the highest i and mu indices
*
Skip;
NSkip `Amp';
#$imax = 0;
#do i = 1,`IMAX'
    if ( match(VB(i`i',?a)) || match(V(i`i',?a))
         || match(UB(i`i',?a)) || match(U(i`i',?a))
         || match(g(i`i',?a)) || match(g(i?,i`i',?a))
         || match(fprop(i`i',?a)) || match(fprop(i?,i`i',?a)) );
            $imax = `i';
    endif;
#enddo
#$mumax = 0;
#do mu = 1,`MUMAX'
    if ( match(g(?a,mu`mu')) 
         || match(phprop(mu`mu',?a)) || match(phprop(mu?,mu`mu',?a)) 
         || match(Zprop(mu`mu',?a)) || match(Zprop(mu?,mu`mu',?a))
         || match(Wprop(mu`mu',?a)) || match(Wprop(mu?,mu`mu',?a)) );
        $mumax = `mu';
    endif;
#enddo
.sort:amplitude-counter;
*
*   Now construct the conjugate
*
Skip;
#call conjugate(`Amp',`Amp'C, `$imax', `$mumax');
.sort:amplitude-conjugate;
*
*   Now multiply Amp and AmpC to get the matrix element squared.
*
Skip;
Drop,`Amp',`Amp'C;
Local   `Mat' = `Amp'*`Amp'C;
#call SpinSum()
#call Propagators()
*
* doTrace
*
Skip;
NSkip `Mat';
#call doTrace(`$imax',0)

#endprocedure