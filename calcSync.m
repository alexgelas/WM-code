syncRS=zeros(numSims,1);
syncRS2=zeros(numSims,1);
syncIB=zeros(numSims,1);
syncIB2=zeros(numSims,1);
window=5;
for sim=1:numSims
    fullV=fullVall(:,:,sim);
    syncRS(sim)=syncMeasure(fullV(RS,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,window);
    syncRS2(sim)=syncMeasure2(fullV(RS,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,window);
    syncIB(sim)=syncMeasure(fullV(IBaxon,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,window);
    syncIB2(sim)=syncMeasure2(fullV(IBaxon,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,window);
end
meanSyncRS=mean(syncRS);
meanSyncRS2=mean(syncRS2);
devSyncRS=std(syncRS);
devSyncRS2=std(syncRS2);
meanSyncIB=mean(syncIB);
meanSyncIB2=mean(syncIB2);
devSyncIB=std(syncIB);
devSyncIB2=std(syncIB2);

%[meanSync devSync meanSync2 devSync2]