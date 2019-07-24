a=findSpikes(fullV,dt,dt);
%%b=findSpikes2(fullI(forcedCell,:),dt,dt,20);
%b=findSpikes2(fullV(1,:),dt,dt,20);

% RSspikes=find(a(1,:));
% forcingSpikes=find(b(1,:));
% basketSpikes=find(a(2,:));
% ltsSpikes=find(a(3,:));
% ibAxonSpikes=find(a(7,:));
% ibApicalSpikes=find(a(4,:));

ibAxonBursts=find(findBursts(a(7,:),dt,8));
numBursts=length(ibAxonBursts);

numBurstsAfter500=sum(ibAxonBursts>2500);
freqIB=numBurstsAfter500/3