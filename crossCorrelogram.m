oldDt=largeDt*saveStep;
newDt=oldDt;
%ratio=newDt/oldDt;
spikes=findSpikes(fullV,oldDt,newDt);

spikeRate1=sum(spikes(RS,:),1);
spikeRate2=sum(spikes(IBaxon,:),1);
len=length(spikeRate1);

totalRate1=sum(spikeRate1.*spikeRate1);
totalRate2=sum(spikeRate2.*spikeRate2);

maxDiff=100;
numCorrSteps=maxDiff/dt;
crossCorr=zeros(numCorrSteps,1);
for i=1:numCorrSteps
    crossCorr(i)=sum(spikeRate1(1:len-i).*spikeRate2(i+1:len));
end
crossCorr=crossCorr/sqrt(totalRate1*totalRate2);

figure(4)
clf
plot(dt*(1:numCorrSteps),crossCorr);