% figure(2)
% spikes=findSpikes(fullV,dt,dt,0);
% bursts=findBursts(spikes,dt,5);
% burstTimes=find(bursts(IBaxon,:))*dt;
% interBurst=([burstTimes 0]-[0 burstTimes]);
% interBurst=interBurst(2:length(interBurst)-1);
% hist(interBurst,200)

figure(2)
spikes=findSpikes(fullV,dt,dt,0);
bursts=findBursts(spikes,dt,IBaxon);
burstTimes=find(bursts(IBaxon,:))*dt;
interBurst=([burstTimes 0]-[0 burstTimes]);
interBurst=interBurst(2:length(interBurst)-1);
hist(interBurst,200)

ltsSpikeTimes=find(spikes(LTS,:))*dt;
IBfromLTS=zeros(length(burstTimes),1);
for i=1:length(burstTimes)
    lastLTS=ltsSpikeTimes(find(ltsSpikeTimes<burstTimes(i),1,'last'));
    if isempty(lastLTS)
        IBfromLTS(i)=-1;
    else
        IBfromLTS(i)=burstTimes(i)-lastLTS;
    end
end
skip=find(IBfromLTS<0,1,'last');
IBfromLTS(1:skip)=[];
hist(IBfromLTS,100)
