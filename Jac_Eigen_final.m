(* ::Package:: *)

(* ::Input:: *)
(*Clear[\[Alpha],\[Beta], a, b, c, d, m, p, v, n, s, w]*)
(**)
(*(*Define the replicator dynamics equations*)*)
(*Fbeta[\[Alpha]_,\[Beta]_]:=(\[Beta] -\[Beta]^2) (b-d-b*\[Alpha]+v*b*\[Alpha]+v*w*\[Alpha]);*)
(*Falpha[\[Alpha]_,\[Beta]_]:=(\[Alpha]-\[Alpha]^2) (-c+a-m*p-a*v*\[Beta]-v*n*s*\[Beta]+v*m*p*\[Beta]);*)
(**)
(*(*Calculate the Jacobian matrix*)*)
(*J=D[{Fbeta[\[Alpha],\[Beta]],Falpha[\[Alpha],\[Beta]]},{{\[Beta],\[Alpha]}}]*)
(**)


(* ::Input:: *)
(*(*Solve for equilibrium points (includes boundary and internal points)*)*)
(*eq=Solve[{Fbeta[\[Alpha],\[Beta]]==0,Falpha[\[Alpha],\[Beta]]==0},{\[Beta],\[Alpha]}]*)
(**)


(* ::Input:: *)
(*(*Separate boundary and internal equilibrium points*)*)
(*boundaryEq=Select[eq,Or[#["\[Alpha]"]==0,#["\[Alpha]"]==1,#["\[Beta]"]==0,#["\[Beta]"]==1]&];*)
(*internalEq=Complement[eq,boundaryEq];*)
(**)
(*(*Compute and display eigenvalues for boundary equilibrium points*)*)
(*Print["Eigenvalues for Boundary Equilibrium Points:"];*)
(*boundaryEig=Table[{point,Eigenvalues[J/. point]},{point,boundaryEq}];*)
(*boundaryEig//TableForm*)
(**)
(*(*Compute and display eigenvalues for internal equilibrium points*)*)
(*Print["Eigenvalues for Internal Equilibrium Points:"];*)
(*internalEig=Table[{point,Eigenvalues[J/. point]},{point,internalEq}];*)
(*internalEig//TableForm*)


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
(*\[Beta]=(c-c-m p)/((m p-a-n s) v);\[Alpha]=(-b+d)/(-b+b v+v w);*)
(*Eigenvalues[J]*)
