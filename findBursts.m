function bursts=findBursts(spikes,dt,threshold)

% Takes a binary time series that represents the existence of spikes with
% time-step dt and gives the time series that represents the existence
% (beginning) of bursts, with a positive number in the corresponding bin of
% time. The number itself is the number of spikes for that burst.
% A series of spikes is considered a single burst
% if the interval between two subsequent spikes is less than the threshold
% (in ms). In the vector returned, the value at the be

numRows=size(spikes,1);
length=size(spikes,2);

separationSteps=threshold/dt;

burstsTemp=spikes;
spikeNumTemp=spikes;

for i=1:separationSteps-1
    shiftedSpikes=[false(numRows,i) spikes(:,1:length-i)];
    leftShiftedSpikes=[spikes(:,i+1:length) false(numRows,i)];
    burstsTemp=burstsTemp & (~shiftedSpikes);
    spikeNumTemp=spikeNumTemp+leftShiftedSpikes;
end
bursts=burstsTemp.*spikeNumTemp;
