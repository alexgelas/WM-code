function bursts=findBursts(spikes,dt,threshold)

% Takes a binary time series that represents the existence of spikes with
% time-step dt and gives the time series that represents the existence
% (beginning) of bursts. A series of spikes is considered a single burst,
% if the interval between two subsequent spikes is less than the threshold
% (in ms).

numRows=size(spikes,1);
length=size(spikes,2);

separationSteps=threshold/dt;

burstsTemp=spikes;

for i=1:separationSteps-1
    shiftedSpikes=[false(numRows,i) spikes(:,1:length-i)];
    burstsTemp=burstsTemp & (~shiftedSpikes);
end
bursts=burstsTemp;