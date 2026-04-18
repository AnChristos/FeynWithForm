#procedure doTrace(Mat)
*--------------------------------------------------------
* Procedure: doTrace 
* Description Glues gamma chains and executes Dirac traces
* ------------------------------------------------------
*
*   String the gamma matrices together in traces.
*
repeat;
    id g(i1?,i2?,?a) * g(i2?,i3?,?b) = g(i1,i3,?a,?b);
endrepeat; 
.sort:chains-glued;
*
*   Now put the traces one by one in terms of the built in gammas
*
#do i = 1, `MAXTRACE'
    id,once,g(i1?,i1?,?a) = g_(`i',?a);
    id  g_(`i',k7) = g7_(`i');
    al  g_(`i',k6) = g6_(`i');
    al  g_(`i',k5) = g5_(`i');
#enddo
.sort:built-in-gamma;
*
*   Finally take the traces
*
#do i = 1,`MAXTRACE'
Trace4,`i';
#enddo

#endprocedure