* Process: e+ e- -> mu+ mu-

* Indices 
Indices mu, nu, rho, sigma;

* Kinematic variables
Symbols s, t, u;

* Physical constants
Symbols e, pi, alpha;

* Four-vectors
Vectors p1, p2, p3, p4;

* ------------------------------------------------------------------
*  Matrix Element Squared for e+(p2) e-(p1) -> mu+(p3) mu-(p4)
* (|M|^2) = (e^4 / s^2) * g^{mu rho} * g^{nu sigma} *
*            Tr[slash(p2) * gamma_mu  * slash(p1) * gamma_nu ] *
*            Tr[slash(p3) * gamma_rho * slash(p4) * gamma_sigma]
*  FORM conventions (see also Diagrammatica)
*  g_ is gamma matrix
*  g_(1,...) is Electron current ; g_(2,...) is Muon current
* ------------------------------------------------------------------ 
Local Msq = (e^4 / s^2) * d_(mu, rho) * d_(nu, sigma) * 
            (g_(1, p2) * g_(1, mu) * g_(1, p1) * g_(1, nu)) * 
            (g_(2, p3) * g_(2, rho) * g_(2, p4) * g_(2, sigma));

* Differential cross section formula
Local dSigma = (1 / (64 * pi^2 * s)) * Msq;

trace4, 1;
trace4, 2;
.sort 
Print Msq; 
.sort
contract;
.sort
Print Msq;
.sort

* Physics & Normalization
id e^4 = 16 * pi^2 * alpha^2;
* Spin averaging (1/2 * 1/2)
multiply 1/4; 

* 3. Kinematics 
* Repeat substitutions as needed.
* We form all Mandelstam for 2 to 2 
* diagrams
repeat;

    id p1.p1 = 0;
    id p2.p2 = 0;
    id p3.p3 = 0;
    id p4.p4 = 0;

    id p1.p2 = (s - p1.p1 - p2.p2)/2;
    id p3.p4 = (s - p3.p3 - p4.p4)/2;


    id p1.p3 = (p1.p1 + p3.p3 - t)/2;
    id p2.p4 = (p2.p2 + p4.p4 - t)/2;


    id p1.p4 = (p1.p1 + p4.p4 - u)/2;
    id p2.p3 = (p2.p2 + p3.p3 - u)/2;
endrepeat;

.sort

bracket alpha, s;
Print dSigma;
.end
