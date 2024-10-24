(* ::Package:: *)

(* ::Input:: *)
(*Clear[\[Alpha],\[Beta], a, b, c, d, m, p, v, n, s, w]*)


(* ::Input:: *)
(*(*Replicator dynamics equations to find equilibrium points*)*)
(*Fb=\[Beta]*(1-\[Beta])*(b-d-b*\[Alpha]+v*b*\[Alpha]+v*w*\[Alpha]);*)
(*Fa=\[Alpha]*(1-\[Alpha])*(-c+a-m*p-a*v*\[Beta]-v*n*s*\[Beta]+v*m*p*\[Beta]);*)
(*Solve[Fb==0&&Fa==0,{\[Beta],\[Alpha]}]*)


(* ::Input:: *)
(*{{\[Beta]->(a-c-m p)/((a-m p+n s) v),\[Alpha]->(-b+d)/(-b+b v+v w)},{\[Beta]->0,\[Alpha]->0},{\[Beta]->0,\[Alpha]->1},{\[Beta]->1,\[Alpha]->0},{\[Beta]->1,\[Alpha]->1}}*)


(* ::Input:: *)
(*(*Jacobian matrix*)*)
(*J={{D[Fb,\[Beta]],D[Fb,\[Alpha]]},{D[Fa,\[Beta]],D[Fa,\[Alpha]]}}*)


(* ::Input:: *)
(*Simplify[(b-d-b \[Alpha]+b v \[Alpha]+v w \[Alpha]) (1-\[Beta])-(b-d-b \[Alpha]+b v \[Alpha]+v w \[Alpha]) \[Beta]]*)


(* ::Input:: *)
(*Simplify[(1-\[Alpha]) (a-c-m p-a v \[Beta]+m p v \[Beta]-n s v \[Beta])-\[Alpha] (a-c-m p-a v \[Beta]+m p v \[Beta]-n s v \[Beta])]*)


(* ::Input:: *)
(**)
(*J[\[Beta],\[Alpha]]*)


(* ::Input:: *)
(*(*b=0.72;d=0.54;v=0.15;w=1;c=0.69;a=0.79;m=0;p=0;n=0;s=0;*)*)
(*a=0.67;b=0.69;c=0.30;d=0.73;v=0.62;w=0.64;m=0;p=0;n=0;s=0;*)
(**)


(* ::Input:: *)
(*(*Eigen values*)*)


(* ::Input:: *)
(*J1=J;*)
(*\[Beta]=0;\[Alpha]=0;*)
(*Eigenvalues[J]*)


(* ::Input:: *)
(*J2=J;*)
(*\[Beta]=0;\[Alpha]=1;*)
(*Eigenvalues[J]*)


(* ::Input:: *)
(*J3=J;*)
(*\[Beta]=1;\[Alpha]=0;*)
(*Eigenvalues[J]*)


(* ::Input:: *)
(*J4=J;*)
(*\[Beta]=1;\[Alpha]=1;*)
(*Eigenvalues[J]*)


(* ::Input:: *)
(*J5=J;*)
(*\[Beta]=(a-c-m p)/((a-m p+n s) v);\[Alpha]=(-b+d)/(-b+b v+v w);*)
(*Eigenvalues[J]*)


(* ::Input:: *)
(*(*Strem plots for above parameter values*)*)


(* ::Input:: *)
(*a1=StreamPlot[{(\[Alpha]-\[Alpha]^2) (-c+a-m*p-a*v*\[Beta]-v*n*s*\[Beta]+v*m*p*\[Beta]),(\[Beta]-\[Beta]^2) (b-d-b*\[Alpha]+v*b*\[Alpha]+v*w*\[Alpha])},{ \[Alpha] ,0,1},{\[Beta] ,0,1},PlotRange->{{-0.05,1.05},{-0.05,1.05}},*)
(*FrameStyle->Directive[Black],*)
(*FrameLabel->{Style["Attack probability",12,FontFamily->"Arial",Black],Style["Defence probability",12,FontFamily->"Arial",Black]},*)
(*FrameTicksStyle->Directive[Black,FontFamily->"Arial",12],*)
(*StreamStyle->{Black}]*)
(*(*Add equilibrium points with annotations*)(*Epilog->{Red,PointSize[Large],Point[{0,0}],Point[{1,0}],Point[{0,1}],Point[{0.38961,0.843882}],Point[{1,1}],*)
(*(*Equilibrium points*)Text[Style["Unstable",12,Red],{0.1,0}],*)
(*(*Annotate each point*)Text[Style["Stable",12,Blue],{0.9,0}],Text[Style["Unstable",12,Red],{0.9,1}],Text[Style["Saddle Point",12,Orange],{0.5,0.85}],Text[Style["Stable",12,Blue],{0.1,1}]}]*)*)


(* ::Input:: *)
(*(*Define a Lyapunov candidate function based on entropy*)V[\[Beta]_,\[Alpha]_]:=(\[Beta]-\[Beta]^2) (b-d-b*\[Alpha]+v*b*\[Alpha]+v*w*\[Alpha])+(\[Alpha]-\[Alpha]^2) (-c+a-m*p-a*v*\[Beta]-v*n*s*\[Beta]+v*m*p*\[Beta])*)
(**)
(*(*3D Plot of the Lyapunov function with equilibrium points*)*)
(*Plot3D[V[\[Beta],\[Alpha]],{\[Alpha],0,1},{\[Beta],0,1},PlotRange->All,PlotStyle->Opacity[0.7],AxesLabel->{"\[Alpha] (Attack)","\[Beta] (Defense)","V(\[Alpha], \[Beta])"},ColorFunction->"Rainbow"]*)
(**)


(* ::Input:: *)
(*(*Define parameters*)*)
(*w=Symbol["w"];*)
(*c=Symbol["c"];*)
(*a=Symbol["a"];*)
(*m=Symbol["m"];*)
(*p=Symbol["p"];*)
(*d=Symbol["d"];*)
(*b=Symbol["b"];*)
(*v=Symbol["v"];*)
(*n=Symbol["n"];*)
(*s=Symbol["s"];*)
(**)
(*(*Payoff functions for Player 1 (Attacker)*)*)
(*U1NoAttack=(1-\[Beta])*0+\[Beta]*(-d+b);*)
(*U1Attack=(1-\[Beta])*(-w)+\[Beta]*(-d+v*b-w*(1-v));*)
(**)
(*(*Payoff functions for Player 2 (Defender)*)*)
(*U2NoDefence=(1-\[Alpha])*0+\[Alpha]*(-c+a-m*p);*)
(*U2Defence=(1-\[Alpha])*0+\[Alpha]*(-c+a*(1-v)-v*n*s-(1-v)*m*p);*)
(**)
(*(*Solve the system of equations for indifference (best responses)*)*)
(*nashEquilibrium=Solve[U1NoAttack==U1Attack&&U2NoDefence==U2Defence,{\[Alpha],\[Beta]}]*)
(**)
(*(*Output Nash equilibrium strategies (\[Alpha],\[Beta])*)*)
(*nashEquilibrium*)
(**)


(* ::Input:: *)
(*b=0.72;d=0.54;v=0.15;w=1;c=0.69;a=0.79;m=0;p=0;n=0;s=0;*)
(*(*Output Nash equilibrium strategies (\[Alpha],\[Beta])*)*)
(*nashEquilibrium*)


(* ::Input:: *)
(**)
(**)
