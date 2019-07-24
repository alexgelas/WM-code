tic

% Parameters for simulation and saving results
if mathNet || numCellsBase==1
    smallDt=0.005;
else
    smallDt=0.01;
end

dt=largeDt;

numSmallSteps=largeDt/smallDt;

%steps=3500; % see defaultParams
quickRun=true; % quickRun means using Euler method (instead of trapezoid) and a larger time step whenever there is no spike (or large change in the state variables)


% RS: h
% Basket: -
% LTS: h
% Apical dendrite: h, m, Ca
% Basal dendrite: h, m, Ca
% Soma: -
% Axon: m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

initialize;

for i=1:steps
    
    % Print out the simulation step
    if (mod(i,200/largeDt)==0 && i<=1000/largeDt) || (mod(i,500/largeDt)==0  && i>1000/largeDt)
        i
    end
    
    updateInputV;
    
    % Main update in loop
    if quickRun
        update;
    else
        update2;
    end

    % Save results at each step
    saveState;
    
end

elapsedTime=toc