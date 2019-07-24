defaultParams;
dataFolder='simData';
load(strcat(dataFolder,'/90Hz.mat'))
filepath='90Hz';
numSims=10;
steps=5000;

numCellsBase=20;
numColumns=1;
fourTimesRS=true;
cellNumbering;




startGamma2=400;
endGamma2=800;

minDiff=-80;
maxDiff=80;

oldDt=largeDt*saveStep;
crossCorrDt=1;

autoCorrMaxTime=1000;
autoCorrStep=1;
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

crossCorr=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);

crossCorrEarly=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);
crossCorrLate=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);

powerRS=zeros(numSims,numCorrSteps);
powerIB=zeros(numSims,numCorrSteps);

begin=200/saveDt+1;
    
for sim=1:numSims
    fullV=fullVall(:,:,sim);
    fullSInput=fullSInputAll(:,:,sim);
    %crossCorr(sim,:)=crossCorrelogram2(fullV(RS,begin:end),fullV(IBaxon,begin:end),oldDt,crossCorrDt,minDiff,maxDiff);
    %crossCorr(sim,:)=crossCorrelogram2(fullV(RS,:),fullV(IBaxon,:),oldDt,crossCorrDt,minDiff,maxDiff);
    crossCorrEarly(sim,:)=crossCorrelogram2(fullV(RS(1,:),begin:startGamma2/largeDt),fullV(IBaxon(1,:),begin:startGamma2/largeDt),oldDt,crossCorrDt,minDiff,maxDiff);
    crossCorrLate(sim,:)=crossCorrelogram2(fullV(RS(1,:),startGamma2/largeDt+1:endGamma2/largeDt),fullV(IBaxon(1,:),startGamma2/largeDt+1:endGamma2/largeDt),oldDt,crossCorrDt,minDiff,maxDiff);
    
    %powerRS(sim,:)=powerSpectrum(fullV(RS,:),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    %powerIB(sim,:)=powerSpectrum(fullV(IBaxon,:),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
end

heading='';
sim=1;
fullVtemp=fullVall(:,:,sim);
fullSInputTemp=fullSInputAll(:,:,sim);
figure(3);
displayInputGamma2=0; % Do not draw on top
clf
rastergram2
%ax.YLim(2)=ax.YLim(2)+13;
hold on
plot([0 1000],[-27 -27],'r','LineWidth',2)
inputSpikes=findSpikes(fullSInputTemp,oldDt,newDt,0.2);
inputSpikeTimes=find(inputSpikes(1,:));
for tt=inputSpikeTimes*largeDt
    plot([tt tt],[-27 -17],'r','LineWidth',2)
end
% %plot([0 1000],[143 143],'r','LineWidth',2)
% for tt=[427 452 477 502 526 551 576 601 625 650 677 702 729 753 777]
%     %plot([tt tt],[143 151],'r','LineWidth',2)
%     plot([tt tt],[-27 -15],'r','LineWidth',2)
% end
ax.YLim(1)=ax.YLim(1)-30;
hold off
text(20,-20,'RS subset 90Hz input','FontSize',12,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)

meanCorr=mean(crossCorr,1);
devCorr=std(crossCorr,1,1);

meanCorrEarly=mean(crossCorrEarly);
devCorrEarly=std(crossCorrEarly,1);
meanCorrLate=mean(crossCorrLate);
devCorrLate=std(crossCorrLate,1);

hCorr=figure(1);
clf
subplot(2,1,1)
plotStats(minDiff:crossCorrDt:maxDiff,meanCorrEarly,devCorrEarly)
ax=gca;
ax.XLim=[minDiff maxDiff];
%ax.YTick=[];
axis tight
ax.YLim(1)=0;
ax.Title.String='Before';
%ax.YLabel.String='Crosscorrelation (AU)';
ax.YLim=[0 ax.YLim(2)];
ax.FontSize=20;
ax.FontWeight='bold';

subplot(2,1,2)
plotStats(minDiff:crossCorrDt:maxDiff,meanCorrLate,devCorrLate)
ax=gca;
ax.XLim=[minDiff maxDiff];
%ax.YTick=[];
axis tight
ax.YLim(1)=0;
ax.Title.String='During';
ax.YLabel.String='                         Crosscorrelation (AU)';
ax.YLim=[0 ax.YLim(2)];
ax.FontSize=20;
ax.FontWeight='bold';

if saveOutput
    saveXcorr(folder,filepath,hCorr);
end



