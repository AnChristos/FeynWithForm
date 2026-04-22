*-------------------------------------------------------------------------*
* FeynHelpers.h
* Defines global symbols for the procedures and routines
*-------------------------------------------------------------------------*
#-
* --- Symbol Limits ---
#ifndef `MAXLIMITS'
    #define MAXLIMITS "1"
    
* Limits for a single amplitude
    #define IMAX "40"        
    #define MUMAX "20"
    
* Buffer for squaring (2x the base)
    #define IMAX2 "80"       
    #define MUMAX2 "40"
    
* Limits on lines and independent 4-momenta  
    #define MAXVEC "10"      
#endif


* Space-time indices
Index mu, mu1, ..., mu`MUMAX2';

* Spinor Indices
Index i, i1, ..., i`IMAX2';

* Special indices for gamma5
*(1+gamma5/2)   (1-gamma5/2) 
Index k5=0, k6=0, k7=0;

* Four vector indices
Vector p, p1, ..., p`MAXVEC';
* Auxiliary vector indices
Vector q;

* Mass
Symbols m;

* Mandelstam
Symbols s, t, u;

* V-A 
Symbol cv, ca;

* Spinors
CF UB, U, VB, V;

* propagators
CF fprop, phprop, Zprop, Wprop, prop;

* Gamma Matrices
CF gamma;

* polarization sum
CF esum, esumM; 
#+

