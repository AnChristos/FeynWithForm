
* Example generating LO QED topologies
#-
* Above suppresses extra output
Off Statistics;
Off FinalStats;

Vector p1,...,p10, q1,...,q10;
Set ext : p1,...,p10;
Set int : q1,...,q10;

Model QED;
  Particle eMinus,ePlus, -1;
  Particle muMinus, muPlus    -1;
  Particle ph,                0;   
  Vertex ePlus, eMinus, ph: alpha; 
  Vertex muMinus, muPlus, ph: alpha;
EndModel;

Local Annih = diagrams_(QED, {ePlus, eMinus}, {muPlus, muMinus}, ext, int, 0);

Local Bhabha = diagrams_(QED, {ePlus, eMinus}, {ePlus, eMinus}, ext, int, 0);

Local Moller = diagrams_(QED, {eMinus, eMinus}, {eMinus, eMinus}, ext, int, 0);

Local ggee = diagrams_(QED, {ph, ph}, {ePlus, eMinus}, ext, int, 0);

Local eegg = diagrams_(QED, {ePlus, eMinus}, {ph, ph}, ext, int, 0);

Local compton = diagrams_(QED, {ph, eMinus}, {ph, eMinus}, ext, int, 0);
.sort
Print +ss;
.end
