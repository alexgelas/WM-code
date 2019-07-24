function tauM=tauMCalc(V,exc)
% exc=1 if excitatory, exc=0 if inhibitory


%tauMexc=0.25+4.35*exp(-abs(V+10)/10); % Correct value for excitatory cells
%tauMinh=0.25+4.35*exp(-abs(V+10)/10); % Correct value for inhibitory cells

%tauM=tauMinh+exc.*(tauMexc-tauMinh);

tauM=0.25+4.35*exp(-abs(V+10)/10);
% Old way to calculate. Doesn't work for vectors.
% if exc==1
%     tauM=0.25+4.35*exp(-abs(V+10)/10);
% else
%     tauM=0.25+4.35*exp(-abs(V+10)/10);
% end

