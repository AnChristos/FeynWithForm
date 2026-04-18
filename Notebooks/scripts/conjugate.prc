#procedure conjugate(Amp, AmpC, imax, mumax)

*--------------------------------------------------------
* Procedure: conjugate 
* Description Forming the conjugate 
* ------------------------------------------------------

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
id  g(i1?,i2?,?a) = g(i2,i1,?a);
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
.sort:end-conjugate;

#endprocedure 