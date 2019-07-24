function tauH=tauHCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

%tauHexc=0.15+1.15./(1+exp((V+33.5)/15)); % Correct value for excitatory cells
%tauHinh=0.225+1.125./(1+exp((V+37)/15)); % Correct value for inhibitory cells

%tauH=tauHinh+exc.*(tauHexc-tauHinh);

tauH=exc.*(0.15+1.15./(1+exp((V+33.5)/15)))+(1-exc).*(0.225+1.125./(1+exp((V+37)/15)));
% Old way to calculate. Doesn't work for vectors.
% if exc==1
%     tauH=0.15+1.15/(1+exp((V+33.5)/15));
% else
%     tauH=0.225+1.125/(1+exp((V+37)/15));
% end







