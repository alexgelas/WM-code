function mInf=mInfCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory


%mInfExc=1./(1+exp((-V-29.5)/10)); % Correct value for excitatory cells
%mInfInh=1./(1+exp((-V-27)/11.5)); % Correct value for inhibitory cells

%mInf=mInfInh+exc.*(mInfExc-mInfInh);

mInf=exc./(1+exp((-V-29.5)/10))+(1-exc)./(1+exp((-V-27)/11.5));
% Old way to calculate. Doesn't work for vectors.
% if exc==1
%     mInf=1/(1+exp((-V-29.5)/10));
% else
%     mInf=1/(1+exp((-V-27)/11.5));
% end
