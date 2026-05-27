#procedure SpinSum()
*--------------------------------------------------------
* Procedure: SpinSum
* Description: Do the spinSum replacements
* ------------------------------------------------------
*

* Spin sums for external particles
id  U(i1?,p?,m?)*UB(i2?,p?,m?) =     gamma(i1,i2,p)+gamma(i1,i2)*m;
id  V(i1?,p?,m?)*VB(i2?,p?,m?) =     gamma(i1,i2,p)-gamma(i1,i2)*m;
.sort:spinor-sum;

id  esum(mu1?,p?)*esum(mu2?,p?) =   -d_(mu1,mu2);
id  esumM(mu1?, p?, m?)*esumM(mu2?, p?, m?) = -d_(mu1,mu2) + p(mu1)*p(mu2)/(m^2);
.sort:vector-boson-sum;

* There are in the rest frame of the decaying particle
id VpolZ(mu1?, q?, n?, m?) * VpolZ(mu2?, q?, n?, m?) = n(mu1)*n(mu2);

id VpolL(mu1?, q?, n?, m?) * VpolL(mu2?, q?, n?, m?) =  1/2 * ((-d_(mu1,mu2) 
                                                       + q(mu1)*q(mu2)/m^2 - n(mu1) * n(mu2)) 
                                                       + e_(mu1,mu2,q,n)/m ) ;

id VpolR(mu1?, q?, n?, m?) * VpolR(mu2?, q?, n?, m?) = 1/2 *((-d_(mu1,mu2) + 
                                                             q(mu1)*q(mu2)/m^2 
                                                            - n(mu1) * n(mu2)) 
                                                            - e_(mu1,mu2,q,n)/m ) ;
.sort:vector-boson-pol-rest;

#endprocedure