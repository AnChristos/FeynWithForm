#procedure SpinSum(Mat)
*--------------------------------------------------------
* Procedure: SpinSum
* Description: Do the spinSum replacements
* ------------------------------------------------------
*
* Spin sums for external particles
id  U(i1?,p?,m?)*UB(i2?,p?,m?) =  g(i1,i2,p)+g(i1,i2)*m;
id  V(i1?,p?,m?)*VB(i2?,p?,m?) =  g(i1,i2,p)-g(i1,i2)*m;
id  eps(mu1?,p?)*eps(mu2?,p?) = -d_(mu1,mu2);
id  epsM(mu1?, p?, m?)*epsM(mu2?, p?, m?) = -d_(mu1,mu2) + p(mu1)*p(mu2)/(m^2);
.sort:spinsum;

#endprocedure