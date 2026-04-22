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
#do ii = 1,`IMAX'
    if ( match(VB(i`ii',?a))    || match(V(i`ii',?a))
         || match(UB(i`ii',?a)) || match(U(i`ii',?a))
         || match(gamma(i`ii',?a)) || match(gamma(i?,i`ii',?a))
         || match(fprop(i`ii',?a)) || match(fprop(i?,i`ii',?a)) );
            $imax = `ii';
    endif;
#enddo
#$mumax = 0;
#do jj = 1,`MUMAX'
    if ( match(gamma(?a,mu`jj')) 
         || match(phprop(mu`jj',?a)) || match(phprop(mu?,mu`jj',?a)) 
         || match(Zprop(mu`jj',?a)) || match(Zprop(mu?,mu`jj',?a))
         || match(Wprop(mu`jj',?a)) || match(Wprop(mu?,mu`jj',?a)) );
        $mumax = `jj';
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

*
* Handle spin sum and propagators
*

#call SpinSum()
#call Propagators()

*
* doTrace
*
Skip;
NSkip `Mat';
#call doTrace(`$imax',0)

#endprocedure