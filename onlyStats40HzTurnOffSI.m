dataFolder='simData';
load(strcat(dataFolder,'/40Hz-turnOffSI.mat'))
filepath='40Hz-turnOffSI';
numSims=10;

numCellsBase=20;
numColumns=1;
fourTimesRS=true;
cellNumbering;

heading='';
sim=7;
fullVtemp=fullVall(:,:,sim);
figure(4);
clf
rastergram2
%ax.YLim(2)=ax.YLim(2)+13;
hold on
plot([0 1000],[-27 -27],'r','LineWidth',2)
%plot([0 1000],[143 143],'r','LineWidth',2)
for tt=[427 452 477 502 526 551 576 601 625 650 677 702 729 753 777]
    %plot([tt tt],[143 151],'r','LineWidth',2)
    plot([tt tt],[-27 -10],'r','LineWidth',2)
end
%ax.YTick=[floor(numColumns*colNumIB/2) floor(numColumns*(colNumIB+colNumLTS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS+colNumRS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS+colNumRS)+5)];
%ax.YTickLabel=[' \fontsize{20}\color{black}IB '; ' \fontsize{20}\color{black}SI '; ' \fontsize{20}\color{black}FS '; ' \fontsize{20}\color{black}RS '; '\fontsize{20}\color{red}input '];
%ax.YLim(2)=ax.YLim(2)+13;
%ax.YTick=[-15 floor(numColumns*colNumIB/2) floor(numColumns*(colNumIB+colNumLTS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS+colNumRS/2))];
%ax.YTickLabel=['\fontsize{20}\color{red}input ';' \fontsize{20}\color{black}IB '; ' \fontsize{20}\color{black}SI '; ' \fontsize{20}\color{black}FS '; ' \fontsize{20}\color{black}RS '];
ax.YLim(1)=ax.YLim(1)-60;
tempX=[inf*ones(1,5000) 0:0.1:500];
tempY=-55+20*exp(-(tempX/150));
plot(0:0.1:1000,tempY,'r','LineWidth',2);
plot([0 1000],[-27 -27],'r','LineWidth',2)
hold off
text(20,-20,'RS subset 40Hz input','FontSize',12,'FontWeight','bold')
text(50,-45,'IPSC to SI cells','FontSize',12,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)


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
    %fullSInput=fullSInputall(:,:,sim);
    %crossCorr(sim,:)=crossCorrelogram2(fullV(RS,begin:end),fullV(IBaxon,begin:end),oldDt,crossCorrDt,minDiff,maxDiff);
    %crossCorr(sim,:)=crossCorrelogram2(fullV(RS,:),fullV(IBaxon,:),oldDt,crossCorrDt,minDiff,maxDiff);
    crossCorrEarly(sim,:)=crossCorrelogram2(fullV(RS(1,:),begin:startGamma2/largeDt),fullV(IBaxon(1,:),begin:startGamma2/largeDt),oldDt,crossCorrDt,minDiff,maxDiff);
    crossCorrLate(sim,:)=crossCorrelogram2(fullV(RS(1,:),inhibitoryPulse2Start/largeDt+1:(inhibitoryPulse2Start+inhibitoryPulse2Length)/largeDt),fullV(IBaxon(1,:),inhibitoryPulse2Start/largeDt+1:(inhibitoryPulse2Start+inhibitoryPulse2Length)/largeDt),oldDt,crossCorrDt,minDiff,maxDiff);
    %powerRS(sim,:)=powerSpectrum(fullV(RS,:),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    %powerIB(sim,:)=powerSpectrum(fullV(IBaxon,:),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
end

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
ax.FontSize=20;
ax.FontWeight='bold';
ax.YLim=[0 ax.YLim(2)];


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

drawnow;

% fStep=1000/(2*autoCorrStep*(numCorrSteps-1));
% fMax=100;
% 
% freqAxis=0:fStep:fMax;

% hPower=figure(2);
% clf
% subplot(1,2,1)
% plotStats(freqAxis,meanPowerRS(1:length(freqAxis)),devPowerRS(1:length(freqAxis)))
% ax=gca;
% ax.XLabel.String='Frequency (Hz)';
% ax.Title.String='RS';
% ax.YLabel.String='Power';
% ax.YLim(1)=0;
% subplot(1,2,2)
% plotStats(freqAxis,meanPowerIB(1:length(freqAxis)),devPowerIB(1:length(freqAxis)))
% ax=gca;
% ax.XLabel.String='Frequency (Hz)';
% ax.Title.String='IB';
% ax.YLim(1)=0;
% drawnow;

% hRast=figure(3);
% clf
% rastergram
% drawnow;
    
if saveOutput
    saveXcorr(folder,filepath,hCorr);
end



