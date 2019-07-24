defaultParams;
cellNumbering;
folder='figuresSet9';
numSims=1;
steps=5000;
numColumns=2;
numCellsBase=20;
cellNumbering;

dataFolder='simData';
load(strcat(dataFolder,'/temporalBottomUp.mat'))
filepath='temporalBottomUp';% for saving

numColumns=2;
numCellsBase=20; % make sure
cellNumbering;

calcCorr=1;

minDiff=-80;
maxDiff=80;

oldDt=largeDt*saveStep;
saveDt=oldDt;
crossCorrDt=1;

autoCorrMaxTime=1000;
autoCorrStep=1;
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

begin1=200/saveDt+1;
end1=500/saveDt;
begin2=700/saveDt+1;
end2=1000/saveDt;

if calcCorr
    numSims=10;
    
    crossCorr=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);
    
    earlyCrossCorrRS=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);
    lateCrossCorrRS=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);
    
    earlyCrossCorrIB=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);
    lateCrossCorrIB=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);
    
    earlyPowerRS1=zeros(numSims,numCorrSteps);
    latePowerRS1=zeros(numSims,numCorrSteps);
    earlyPowerIB1=zeros(numSims,numCorrSteps);
    latePowerIB1=zeros(numSims,numCorrSteps);
    
    earlyPowerRS2=zeros(numSims,numCorrSteps);
    latePowerRS2=zeros(numSims,numCorrSteps);
    earlyPowerIB2=zeros(numSims,numCorrSteps);
    latePowerIB2=zeros(numSims,numCorrSteps);
    
    earlyPowerRS=zeros(numSims,numCorrSteps);
    latePowerRS=zeros(numSims,numCorrSteps);
    earlyPowerIB=zeros(numSims,numCorrSteps);
    latePowerIB=zeros(numSims,numCorrSteps);
    
    for sim=1:numSims
        tonicBottomUpStart=tonicBottomUpStartMat(sim);
        earlyCrossCorrRS(sim,:)=crossCorrelogram2(fullVall(RS(1,:),begin1:end1,sim),fullVall(RS(2,:),begin1:end1,sim),saveDt,crossCorrDt,minDiff,maxDiff);
        lateCrossCorrRS(sim,:)=crossCorrelogram2(fullVall(RS(1,:),begin2:end2,sim),fullVall(RS(2,:),begin2:end2,sim),saveDt,crossCorrDt,minDiff,maxDiff);
        
        earlyCrossCorrIB(sim,:)=crossCorrelogram2(fullVall(IBaxon(1,:),begin1:end1,sim),fullVall(IBaxon(2,:),begin1:end1,sim),saveDt,crossCorrDt,minDiff,maxDiff);
        lateCrossCorrIB(sim,:)=crossCorrelogram2(fullVall(IBaxon(1,:),begin2:end2,sim),fullVall(IBaxon(2,:),begin2:end2,sim),saveDt,crossCorrDt,minDiff,maxDiff);
        
        earlyPowerRS1(sim,:)=powerSpectrum(fullVall(RS(1,:),begin1:end1,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        latePowerRS1(sim,:)=powerSpectrum(fullVall(RS(1,:),begin2:end2,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        earlyPowerIB1(sim,:)=powerSpectrum(fullVall(IBaxon(1,:),begin1:end1,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        latePowerIB1(sim,:)=powerSpectrum(fullVall(IBaxon(1,:),begin2:end2,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        
        earlyPowerRS2(sim,:)=powerSpectrum(fullVall(RS(2,:),begin1:end1,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        latePowerRS2(sim,:)=powerSpectrum(fullVall(RS(2,:),begin2:end2,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        earlyPowerIB2(sim,:)=powerSpectrum(fullVall(IBaxon(2,:),begin1:end1,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        latePowerIB2(sim,:)=powerSpectrum(fullVall(IBaxon(2,:),begin2:end2,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        
        earlyPowerRS(sim,:)=powerSpectrum(fullVall(RS,begin1:end1,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        latePowerRS(sim,:)=powerSpectrum(fullVall(RS,begin2:end2,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        earlyPowerIB(sim,:)=powerSpectrum(fullVall(IBaxon,begin1:end1,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        latePowerIB(sim,:)=powerSpectrum(fullVall(IBaxon,begin2:end2,sim),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    end
end


fStep=1000/(2*autoCorrStep*(numCorrSteps-1));
fMax=50;

freqAxis=0:fStep:fMax;

minBeta1index=floor(12/fStep);
maxBeta1index=floor(20/fStep);

meanEarlyPowerRS1=mean(earlyPowerRS1);
devEarlyPowerRS1=std(earlyPowerRS1);
meanLatePowerRS1=mean(latePowerRS1);
devLatePowerRS1=std(latePowerRS1);
meanEarlyPowerIB1=mean(earlyPowerIB1);
devEarlyPowerIB1=std(earlyPowerIB1);
meanLatePowerIB1=mean(latePowerIB1);
devLatePowerIB1=std(latePowerIB1);

meanEarlyPowerRS2=mean(earlyPowerRS2);
devEarlyPowerRS2=std(earlyPowerRS2);
meanLatePowerRS2=mean(latePowerRS2);
devLatePowerRS2=std(latePowerRS2);
meanEarlyPowerIB2=mean(earlyPowerIB2);
devEarlyPowerIB2=std(earlyPowerIB2);
meanLatePowerIB2=mean(latePowerIB2);
devLatePowerIB2=std(latePowerIB2);

meanEarlyPowerRS=mean(earlyPowerRS);
devEarlyPowerRS=std(earlyPowerRS);
meanLatePowerRS=mean(latePowerRS);
devLatePowerRS=std(latePowerRS);
meanEarlyPowerIB=mean(earlyPowerIB);
devEarlyPowerIB=std(earlyPowerIB);
meanLatePowerIB=mean(latePowerIB);
devLatePowerIB=std(latePowerIB);

meanEarlyCorrRS=mean(earlyCrossCorrRS,1);
devEarlyCorrRS=std(earlyCrossCorrRS,1,1);
meanLateCorrRS=mean(lateCrossCorrRS,1);
devLateCorrRS=std(lateCrossCorrRS,1,1);

meanEarlyCorrIB=mean(earlyCrossCorrIB,1);
devEarlyCorrIB=std(earlyCrossCorrIB,1,1);
meanLateCorrIB=mean(lateCrossCorrIB,1);
devLateCorrIB=std(lateCrossCorrIB,1,1);

newMinDiff=-50;
newMaxDiff=50;
totLength=(maxDiff-minDiff)/crossCorrDt+1;

minIndex=(newMinDiff-minDiff)/crossCorrDt+1;
maxIndex=(newMaxDiff-minDiff)/crossCorrDt+1;

func1=earlyCrossCorrIB;
func2=lateCrossCorrIB;

peakRSearly=mean(max(earlyPowerRS(:,minBeta1index:maxBeta1index),[],2));
peakRSlate=mean(max(latePowerRS(:,minBeta1index:maxBeta1index),[],2));
peakIBearly=mean(max(earlyPowerIB(:,minBeta1index:maxBeta1index),[],2));
peakIBlate=mean(max(latePowerIB(:,minBeta1index:maxBeta1index),[],2));

incRS=(peakRSlate-peakRSearly)/peakRSearly
incIB=(peakIBlate-peakIBearly)/peakIBearly
%incIB=(meanLatePowerIB-meanEarlyPowerIB)/meanEarlyPowerIB

%crossCorrMaxTest(func1,func2,minIndex,maxIndex)

hCorr=figure(2);
clf
subplot(1,3,1)
plotStats(minDiff:crossCorrDt:maxDiff,meanEarlyCorrIB,devEarlyCorrIB)
ax=gca;
%ax.YTick=[];
ax.XLim=[minDiff maxDiff];
ax.Title.String='IB - Before';
ax.YLim(1)=0;
xlabel('Time (ms)')
ylabel('Crosscorrelation (AU)')
ax.FontSize=20;
ax.FontWeight='bold';

subplot(1,3,2)
plotStats(minDiff:crossCorrDt:maxDiff,meanLateCorrRS,devLateCorrRS)
ax=gca;
%ax.YTick=[];
ax.XLim=[minDiff maxDiff];
ax.Title.String='RS - After';
ax.YLim(1)=0;
xlabel('Time (ms)')
ax.FontSize=20;
ax.FontWeight='bold';

subplot(1,3,3)
plotStats(minDiff:crossCorrDt:maxDiff,meanLateCorrIB,devLateCorrIB)
ax=gca;
%ax.YTick=[];
ax.XLim=[minDiff maxDiff];
xlabel('Time (ms)')
ax.YLim(1)=0;
ax.Title.String='IB - After';
xlabel('Time (ms)')
ax.FontSize=20;
ax.FontWeight='bold';

drawnow;
    
hPower=figure(1);
clf
subplot(2,2,1)
%plotStats(freqAxis,meanEarlyPowerRS1(1:length(freqAxis)),devEarlyPowerRS1(1:length(freqAxis)),0.1)
plotStats(freqAxis,meanEarlyPowerRS1(1:length(freqAxis)),devEarlyPowerRS1(1:length(freqAxis)))
ax=gca;
ax.Title.String='Before';
ax.YLabel.String='Col 1 RS power (AU)';
ax.YLim(1)=0;
ax.XLim(2)=50;
ax.FontSize=20;
ax.FontWeight='bold';

subplot(2,2,2)
%plotStats(freqAxis,meanLatePowerRS1(1:length(freqAxis)),devLatePowerRS1(1:length(freqAxis)),0.1)
plotStats(freqAxis,meanLatePowerRS1(1:length(freqAxis)),devLatePowerRS1(1:length(freqAxis)))
ax=gca;
ax.Title.String='After';
ax.YLim(1)=0;
ax.XLim(2)=50;
ax.FontSize=20;
ax.FontWeight='bold';

subplot(2,2,3)
%plotStats(freqAxis,meanEarlyPowerRS2(1:length(freqAxis)),devEarlyPowerRS2(1:length(freqAxis)),0.1)
plotStats(freqAxis,meanEarlyPowerRS2(1:length(freqAxis)),devEarlyPowerRS2(1:length(freqAxis)))
ax=gca;
ax.XLabel.String='Frequency (Hz)';
ax.YLabel.String='Col 2 RS power (AU)';
ax.YLim(1)=0;
ax.XLim(2)=50;
ax.FontSize=20;
ax.FontWeight='bold';

subplot(2,2,4)
%plotStats(freqAxis,meanLatePowerRS2(1:length(freqAxis)),devLatePowerRS2(1:length(freqAxis)),0.1)
plotStats(freqAxis,meanLatePowerRS2(1:length(freqAxis)),devLatePowerRS2(1:length(freqAxis)))
ax=gca;
ax.XLabel.String='Frequency (Hz)';
ax.YLim(1)=0;
ax.XLim(2)=50;
ax.FontSize=20;
ax.FontWeight='bold';

drawnow;

hPower2=figure(3);
clf
subplot(2,2,1)
%plotStats(freqAxis,meanEarlyPowerRS(1:length(freqAxis)),devEarlyPowerRS(1:length(freqAxis)),0.1)
plotStats(freqAxis,meanEarlyPowerRS(1:length(freqAxis)),devEarlyPowerRS(1:length(freqAxis)))
ax=gca;
ax.Title.String='Before';
ax.YLabel.String='RS power (AU)';
ax.YLim(1)=0;
ax.XLim(2)=50;
ax.FontSize=20;
ax.FontWeight='bold';

subplot(2,2,2)
%plotStats(freqAxis,meanLatePowerRS(1:length(freqAxis)),devLatePowerRS(1:length(freqAxis)),0.1)
plotStats(freqAxis,meanLatePowerRS(1:length(freqAxis)),devLatePowerRS(1:length(freqAxis)))
ax=gca;
ax.Title.String='After';
ax.YLim(1)=0;
ax.XLim(2)=50;
ax.FontSize=20;
ax.FontWeight='bold';

subplot(2,2,3)
%plotStats(freqAxis,meanEarlyPowerIB(1:length(freqAxis)),devEarlyPowerIB(1:length(freqAxis)),0.1)
plotStats(freqAxis,meanEarlyPowerIB(1:length(freqAxis)),devEarlyPowerIB(1:length(freqAxis)))
ax=gca;
ax.XLabel.String='Frequency (Hz)';
ax.YLabel.String='IB power (AU)';
ax.YLim(1)=0;
ax.XLim(2)=50;
ax.FontSize=20;
ax.FontWeight='bold';

subplot(2,2,4)
%plotStats(freqAxis,meanLatePowerIB(1:length(freqAxis)),devLatePowerIB(1:length(freqAxis)),0.1)
plotStats(freqAxis,meanLatePowerIB(1:length(freqAxis)),devLatePowerIB(1:length(freqAxis)))
ax=gca;
ax.XLabel.String='Frequency (Hz)';
ax.YLim(1)=0;
ax.XLim(2)=50;
ax.FontSize=20;
ax.FontWeight='bold';

minBeta1index=floor(12/fStep);
maxBeta1index=floor(20/fStep);

pRS=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index,'both')
 c pIB=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index,'both')

if saveOutput
    % Power spectrum
    
    fullFilepathPowerSpecSeparately=strcat(folder,'/',filepath,'-powerSpecSeparately');
    hPower.PaperUnits = 'inches';
    hPower.PaperPosition = [0 0 6 5]; % 8 6 before
    saveas(hPower,fullFilepathPowerSpecSeparately,'fig');
    saveas(hPower,fullFilepathPowerSpecSeparately,'png');
    set(hPower,'PaperSize',[hPower.PaperPosition(3), hPower.PaperPosition(4)]);
    print(hPower,fullFilepathPowerSpecSeparately,'-dpdf','-r0')
    
    fullFilepathPowerSpec=strcat(folder,'/',filepath,'-powerSpec');
    hPower2.PaperUnits = 'inches';
    hPower2.PaperPosition = [0 0 6 5];
    saveas(hPower2,fullFilepathPowerSpec,'fig');
    saveas(hPower2,fullFilepathPowerSpec,'png');
    set(hPower2,'PaperSize',[hPower2.PaperPosition(3), hPower2.PaperPosition(4)]);
    print(hPower2,fullFilepathPowerSpec,'-dpdf','-r0')
    
    % Cross correlation
    fullFilepathCorr=strcat(folder,'/',filepath,'-xcorr');
    hCorr.PaperUnits = 'inches';
    %hCorr.PaperPosition = [0 0 18 5]; %16 4 before
    hCorr.PaperPosition = [0 0 15.3 4.25]; % May '19
    saveas(hCorr,fullFilepathCorr,'fig');
    saveas(hCorr,fullFilepathCorr,'png');
    set(hCorr,'PaperSize',[hCorr.PaperPosition(3), hCorr.PaperPosition(4)]);
    print(hCorr,fullFilepathCorr,'-dpdf','-r0')
    
    fullFilepath=strcat(folder,'/',filepath);
    save(strcat(fullFilepath,'.mat'),'earlyCrossCorrRS','lateCrossCorrRS','earlyCrossCorrIB','lateCrossCorrIB','meanEarlyCorrRS','devEarlyCorrRS','meanLateCorrRS','devLateCorrRS','meanEarlyCorrIB','devEarlyCorrIB','meanLateCorrIB','devLateCorrIB','earlyPowerRS1','latePowerRS1','earlyPowerIB1','latePowerIB1','earlyPowerRS2','latePowerRS2','earlyPowerIB2','latePowerIB2','meanEarlyPowerRS1','meanLatePowerRS1','meanEarlyPowerIB1','meanLatePowerIB1','meanEarlyPowerRS2','meanLatePowerRS2','meanEarlyPowerIB2','meanLatePowerIB2','devEarlyPowerRS1','devLatePowerRS1','devEarlyPowerIB1','devLatePowerIB1','devEarlyPowerRS2','devLatePowerRS2','devEarlyPowerIB2','devLatePowerIB2','fullVall');
    
    %saveas(h,fullFilepath,'svg');
    %save(strcat(fullFilepath,'.mat'),'earlyCrossCorrRS','lateCrossCorrRS','earlyCrossCorrIB','lateCrossCorrIB','meanEarlyCorrRS','devEarlyCorrRS','meanLateCorrRS','devLateCorrRS','meanEarlyCorrIB','devEarlyCorrIB','meanLateCorrIB','devLateCorrIB')
end

figure(4)
load(strcat(dataFolder,'/temporalBottomUp.mat'))
filepath='temporalBottomUp'
heading='';
showArrows=0;
%arrowsPos=[600];
sim=10;
fullVtemp=fullVall(:,:,sim);
displayInputBeta=1; % make some space at the bottom
rastergram2;
hold on
ax.YLim(1)=ax.YLim(1)-10;
plot([0 500 500 1000],[-30 -30 -10 -10],'r','LineWidth',2)
hold off
text(50,-15,'col2 IB tonic drive','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)

% hold on
% plot([0 500 500 1000],[-22 -22 -7 -7],'r','LineWidth',2)
% hold off
% ax.XLim(2)=1000;
% ax.YTick=[-10 floor(numColumns*colNumIB/2) floor(numColumns*(colNumIB+colNumLTS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS+colNumRS/4)) floor(numColumns*(colNumIB+colNumLTS+colNumFS+colNumRS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS+colNumRS*3/4))];
% ax.YTickLabel=['\fontsize{20}\color{red}IB tonic ';'    \fontsize{20}\color{black}IB '; '    \fontsize{20}\color{black}SI '; '    \fontsize{20}\color{black}FS '; '    \fontsize{20}\color{red}col2 '; '    \fontsize{20}\color{black}RS '; '   \fontsize{20}\color{blue}col1 '];
if saveOutput
    saveRastergram(folder,filepath,rastFig)
end