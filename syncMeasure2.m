function syncCoeff=syncMeasure2(V,oldDt,newDt)

% Takes the voltage traces of a group of neurons (each neuron's trace is
% one line in V) and produces a measure of synchrony.

spikes=findSpikes(V,oldDt,newDt);

xx=-3:newDt:3;

norm=normpdf(xx,0,0.5);

spikeRate=sum(spikes,1);
smoothSpikeRate=conv(spikeRate,norm,'same');

%len=length(spikeRate);

sumSquares=sum(smoothSpikeRate.^2);

sqSum=sum(smoothSpikeRate)^2;

syncCoeff=sumSquares/sqSum;