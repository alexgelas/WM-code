function hInf=hInfCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

%hInfExc=1./(1+exp((V+59.4)/10.7)); % Correct value for excitatory cells
%hInfInh=1./(1+exp((V+58.3)/6.7)); % Correct value for inhibitory cells

%hInf=hInfInh+exc.*(hInfExc-hInfInh);

hInf=exc./(1+exp((V+59.4)/10.7))+(1-exc)./(1+exp((V+58.3)/6.7));

% Old way to calculate. Doesn't work for vectors.
% if exc==1
%     hInf=1/(1+exp((V+59.4)/10.7));
% else
%     hInf=1/(1+exp((V+58.3)/6.7));
% end