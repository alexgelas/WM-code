function freqs=phaseHist(V,refV,dt,histMax)

refSpikes=findSpikes(refV,dt,dt,0);
refPos=find(refSpikes);

spikes=findSpikes(V,dt,dt,0);

bursts=findBursts(spikes,dt,5);

tempLength=size(bursts,2);

burstTimes=sort(mod(find(bursts'),tempLength));

spikeTimes1=burstTimes';
spikeTimes2=refPos;

numSpikes1=size(spikeTimes1,2);
%numSpikes2=size(spikeTimes2,2);

last2wrt1=zeros(1,numSpikes1);
%next2wrt1=zeros(1,numSpikes1);
%isi2wrt1=zeros(1,numSpikes1);
timeFromLast2wrt1=zeros(1,numSpikes1);
%timeToNext2wrt1=zeros(1,numSpikes1);

skipInitialSpikes1=20; % large network
skipFinalSpikes1=20;

%skipInitialSpikes1=5; % small network
%skipFinalSpikes1=5;

for j=skipInitialSpikes1+1:numSpikes1-skipFinalSpikes1
    last2wrt1(j)=spikeTimes2(find(spikeTimes2<spikeTimes1(j),1,'last'));
    timeFromLast2wrt1(j)=spikeTimes1(j)-last2wrt1(j);
    %next2wrt1(j)=spikeTimes2(find(spikeTimes2>=spikeTimes1(j),1,'first'));
    %timeToNext2wrt1(j)=next2wrt1(j)-spikeTimes1(j);
    %isi2wrt1(j)=next2wrt1(j)-last2wrt1(j);
end

temp1=skipInitialSpikes1+1;
temp2=numSpikes1-skipFinalSpikes1;

freqs=hist(dt*timeFromLast2wrt1(temp1:temp2),0.5:1:histMax);