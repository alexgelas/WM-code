function m0=m0Calc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory

%m0exc=1./(1+exp((-V-34.5)/10)); % The correct value for excitatory cells
%m0inh=1./(1+exp((-V-38)/10)); % The correct value for inhibitory cells

%m0=m0inh+exc.*(m0exc-m0inh);

m0=exc./(1+exp((-V-34.5)/10))+(1-exc)./(1+exp((-V-38)/10));

% Old way to calculate. Doesn't work for vectors.
% if exc==1
%     m0=1./(1+exp((-V-34.5)/10));
% else
%     m0=1./(1+exp((-V-38)/10));
% end