#ifndef `SYMBOLSH'
#define SYMBOLSH "1"
*-------------------------------------------------------------------------*
* Symbols.h
* Defines global symbols for the procedures and routines
* We "reserve" those
*-------------------------------------------------------------------------*

*-------------------------------------------------------------------------*
* Symbols.h - Clean Explicit Version
*-------------------------------------------------------------------------*

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
    #define MAXTRACE "10"    
    #define MAXVEC "10"      
#endif

* --- Explicit Declarations ---
Index mu1, ..., mu`MUMAX2';
Index i1, ..., i`IMAX2';
Index mu, i, k5=0, k6=0, k7=0;

Vector p, p1, ..., p`MAXVEC';
Vector k, q, q1, q2, q3;

Symbols m, s, t, u, cv, ca;

CF UB, U, VB, V, g, eps, epsM, 
CF fprop, phprop, Zprop, Wprop, prop;
CF  Den, A0, B0;
#endif
