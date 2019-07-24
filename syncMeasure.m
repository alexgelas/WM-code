function syncCoeff=syncMeasure(V,oldDt,newDt)

% Takes the voltage traces of a group of neurons (each neuron's trace is
% one line in V) and produces a measure of synchrony.

spikes=findSpikes(V,oldDt,newDt);
spikeRate=sum(spikes,1);
syncCoeff=sum(spikeRate.^2)/sum(spikeRate);