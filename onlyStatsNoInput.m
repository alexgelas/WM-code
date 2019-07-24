dataFolder='simData';
load(strcat(dataFolder,'/noInput.mat'))
filepath='noInput';
numSims=10;

numCellsBase=20;
numColumns=1;
fourTimesRS=true;
cellNumbering;

heading='';
sim=1;
fullVtemp=fullVall(:,:,sim);
hRast=figure(3);
clf
rastergram2

minDiff=-80;
maxDiff=80;

oldDt=saveDt;%=largeDt*saveStep;
crossCorrDt=1;

autoCorrMaxTime=1000;
autoCorrStep=1;
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

crossCorr=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);

powerRS=zeros(numSims,numCorrSteps);
powerIB=zeros(numSims,numCorrSteps);

begin=200/saveDt+1;

for sim=1:numSims
    fullV=fullVall(:,:,sim);
    %fullSInput=fullSInputall(:,:,sim);
    crossCorr(sim,:)=crossCorrelogram2(fullV(RS,begin:end),fullV(IBaxon,begin:end),oldDt,crossCorrDt,minDiff,maxDiff);
    powerRS(sim,:)=powerSpectrum(fullV(RS,begin:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    powerIB(sim,:)=powerSpectrum(fullV(IBaxon,begin:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
end

meanCorr=mean(crossCorr,1);
devCorr=std(crossCorr,1,1);

meanPowerRS=mean(powerRS,1);
devPowerRS=std(powerRS,1,1);
meanPowerIB=mean(powerIB,1);
devPowerIB=std(powerIB,1,1);

hCorr=figure(1);
clf
plotStats(minDiff:crossCorrDt:maxDiff,meanCorr,devCorr)
ax=gca;
ax.XLim=[minDiff maxDiff];
%ax.YTick=[];
ax.YLim(1)=0;
xlabel('Time (ms)')
ax.Title.String='RS-IB crosscorrelation';
ax.YLabel.String={'Crosscorre-','lation (AU)'};%'Crosscorrelation (AU)';
ax.FontSize=20;
ax.FontWeight='bold';

    
fStep=1000/(2*autoCorrStep*(numCorrSteps-1));
fMax=50;

freqAxis=0:fStep:fMax;

hPower=figure(2);
clf
subplot(1,2,1)
plotStats(freqAxis,meanPowerRS(1:length(freqAxis)),devPowerRS(1:length(freqAxis)))
ax=gca;
ax.XLabel.String='Frequency (Hz)';
ax.Title.String='RS';
ax.YLabel.String='Power (AU)';
ax.FontSize=20;
ax.FontWeight='bold';
ax.YLim(1)=0;
subplot(1,2,2)
plotStats(freqAxis,meanPowerIB(1:length(freqAxis)),devPowerIB(1:length(freqAxis)))
ax=gca;
ax.XLabel.String='Frequency (Hz)';
ax.Title.String='IB';
ax.YLim(1)=0;
ax.FontSize=20;
ax.FontWeight='bold';



if saveOutput
%     % save all data
%     fullFilepath=strcat(folder,'/',filepath);
%     save(strcat(fullFilepath,'.mat'),'crossCorr','meanCorr','devCorr','powerRS','powerIB','meanPowerRS','devPowerRS','meanPowerIB','devPowerIB','fullVall');
    saveXcorr(folder,filepath,hCorr);
    hCorr.PaperUnits = 'inches';
    hCorr.PaperPosition = [0 0 6 2.5];
    fullFilepathXcorr=strcat(folder,'/',filepath,'-xcorr');
    saveas(hCorr,fullFilepathXcorr,'fig');
    saveas(hCorr,fullFilepathXcorr,'png');
    set(hCorr,'PaperSize',[hCorr.PaperPosition(3), hCorr.PaperPosition(4)]);
    print(hCorr,fullFilepathXcorr,'-dpdf','-r0')
    
    % Power spectrum
    hPower.PaperUnits = 'inches';
    hPower.PaperPosition = [0 0 6 2.5];
    
    fullFilepathPower=strcat(folder,'/',filepath,'-powerSpec');
    
    saveas(hPower,fullFilepathPower,'fig');
    saveas(hPower,fullFilepathPower,'png');
    set(hPower,'PaperSize',[hPower.PaperPosition(3), hPower.PaperPosition(4)]);
    print(hPower,fullFilepathPower,'-dpdf','-r0')
end
