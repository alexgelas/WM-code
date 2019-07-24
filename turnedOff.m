function netTurnedOff = turnedOff(V,interval,dt)
% Decides whether the network turned off.
% It takes as input the voltage traces ('V' - rows correspond to different cells,
% columns to different times), an interval of time ('interval' - in ms) and the time
% step of the trace ('dt' - in ms) and returns true if there were almost no
% spikes in the last (interval) ms of the simulation.

numCells=size(V,1);
numSteps=size(V,2);
spikes=findSpikes(V,dt,dt); % exact values of oldDt and newDt don't matter, only their ratio
numLateSpikes=sum(sum(spikes(:,numSteps-floor(interval/dt):end)));

avgRateThreshold=0.3; % average firing rate (in Hz) per cell, below which the network is considered silent

if numLateSpikes<avgRateThreshold*numCells*interval/1000
    netTurnedOff=1;
else
    netTurnedOff=0;
end

end