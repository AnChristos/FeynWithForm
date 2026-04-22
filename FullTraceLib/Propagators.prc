#procedure Propagators()
*--------------------------------------------------------
* Procedure: Propagators
* Description: Do the Propagator replacement
* ------------------------------------------------------
*
* Internal Propagators
id  fprop(i1?,i2?,p?,m?) = (g(i1,i2,p)+g(i1,i2)*m)*prop(p.p-m^2);
id  phprop(mu1?,mu2?,q?) = -d_(mu1,mu2)*prop(q.q);
id  Zprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1)*q(mu2)/(m^2)) * prop(q.q - m^2);
id  Wprop(mu1?,mu2?,q?,m?) = (-d_(mu1,mu2) + q(mu1)*q(mu2)/(m^2)) * prop(q.q - m^2);
.sort:propagators;

#endprocedure