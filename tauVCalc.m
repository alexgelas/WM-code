function tauV=tauVCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

h=hInfCalc(V,exc);
m=mInfCalc(V,exc);
mKM=0.005;

gNa=100*(m0Calc(V,exc)).^3.*h;
gK=5*m.^4;
gL=0.25;
gKM=1.5*mKM;

tauVexc=0.9./(gNa+gK+gL+gKM);
%tauHexc=0.15+1.15./(1+exp((V+33.5)/15)); % Correct value for excitatory cells
%tauHinh=0.225+1.125./(1+exp((V+37)/15)); % Correct value for inhibitory cells

%tauH=tauHinh+exc.*(tauHexc-tauHinh);
tauV=tauVexc;

% Old way to calculate. Doesn't work for vectors.
% if exc==1
%     tauH=0.15+1.15/(1+exp((V+33.5)/15));
% else
%     tauH=0.225+1.125/(1+exp((V+37)/15));
% end







