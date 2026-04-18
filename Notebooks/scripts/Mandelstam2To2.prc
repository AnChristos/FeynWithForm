#procedure Mandelstam2To2(p1, p2, p3, p4, m1, m2, m3, m4)
*-------------------------------------------------------------------------*
* Procedure: Mandelstam2To2
* p1, p2: Initial state vectors
* p3, p4: Final state vectors
* m1, m2, m3, m4: Masses of the respective particles
*-------------------------------------------------------------------------*
repeat;
    id `p1'.`p1' = `m1'^2;
    id `p2'.`p2' = `m2'^2;
    id `p3'.`p3' = `m3'^2;
    id `p4'.`p4' = `m4'^2;

* s-channel combinations
    id `p1'.`p2' = (s - `m1'^2 - `m2'^2)/2;
    id `p3'.`p4' = (s - `m3'^2 - `m4'^2)/2;

* t-channel combinations
    id `p1'.`p3' = (`m1'^2 + `m3'^2 - t)/2;
    id `p2'.`p4' = (`m2'^2 + `m4'^2 - t)/2;

* u-channel combinations
    id `p1'.`p4' = (`m1'^2 + `m4'^2 - u)/2;
    id `p2'.`p3' = (`m2'^2 + `m3'^2 - u)/2;
endrepeat;
.sort:kinematics-applied;

#endprocedure