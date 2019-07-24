spikes=findSpikes(fullV,dt,dt,0);
bursts=findBursts(spikes,dt,10);
if ~isempty(IBaxon)
    burstsAxon=bursts(IBaxon(1,1),:);
    burstTimes=find(bursts(IBaxon(1,1),:))*dt;
    spikeNum=burstsAxon(floor((burstTimes+0.01)/dt));
    doublets=find(spikeNum==2);
    triplets=find(spikeNum==3);
    quadruplets=find(spikeNum==4);
end

