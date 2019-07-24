function crossCorr=crossCorrelogram2(V1,V2,oldDt,newDt,minDiff,maxDiff)

% Takes the voltage traces of two groups of neurons (each neuron's trace is
% one line in V1/V2) and produces the crosscorrelogram, from minDiff
% (usually either 0 or negative) to maxDiff (in ms). oldDt refers is the
% timestep for V1/V2, and newDt is the time bin for the x-correlogram.

spikes1=findSpikes(V1,oldDt,newDt);
spikes2=findSpikes(V2,oldDt,newDt);

spikeRate1=sum(spikes1,1);
spikeRate2=sum(spikes2,1);
len=length(spikeRate1);

%spikeRate1

totalRate1=sum(spikeRate1.*spikeRate1);
totalRate2=sum(spikeRate2.*spikeRate2);

numNegativeSteps=max(-minDiff,0)/newDt;
numPositiveSteps=min(maxDiff,maxDiff-minDiff)/newDt;
numCorrSteps=numNegativeSteps+numPositiveSteps+1; % (maxDiff-minDiff)/dt;
crossCorr=zeros(numCorrSteps,1);

crossCorr(numNegativeSteps+1)=sum(spikeRate1.*spikeRate2); % at 0 difference

for i=1:numPositiveSteps
    crossCorr(numNegativeSteps+1+i)=sum(spikeRate1(1:len-i).*spikeRate2(i+1:len));
end
for i=1:numNegativeSteps
    crossCorr(numNegativeSteps+1-i)=sum(spikeRate1(i+1:len).*spikeRate2(1:len-i));
end
if totalRate1*totalRate2>0
    %crossCorr=crossCorr/sqrt(totalRate1*totalRate2); % erased June 29th
    % otherwise crossCorr=0 anyway
end

% figure(4)
% clf
% plot(newDt*(-numNegativeSteps:numPositiveSteps),crossCorr);