filepath='temporalBottomUp';

defaultParams; % call first to set parameters not set below

saveOutput=true;

%steps=1000
numCellsBase=20;
numColumns=2;

fourTimesRS=true; % Have four times more RS than every other population?

%uniDirectionalConnect=1;
temporalBottomUp=1;
%tonicBottomUpStart=400;

numSims=10;

tonicBottomUpStartMat=500+floor(70*rand(numSims,1));

clear('fullVall');

minDiff=-100;
maxDiff=100;

oldDt=largeDt*saveStep;
saveDt=oldDt;
crossCorrDt=1;

autoCorrMaxTime=1000;
autoCorrStep=1;
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

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
    sim
    tonicBottomUpStart=tonicBottomUpStartMat(sim);
    networkSim;
    fullVall(:,:,sim)=fullV;
    
    %temp=crossCorrelogram2(fullV(RS(1,:),:),fullV(RS(2,:),:),oldDt,crossCorrDt,minDiff,maxDiff);
    %crossCorr(sim,:)=crossCorrelogram2(fullV(RS(1,:),:),fullV(RS(2,:),:),oldDt,crossCorrDt,minDiff,maxDiff);
    earlyCrossCorrRS(sim,:)=crossCorrelogram2(fullV(RS(1,:),1:tonicBottomUpStart/saveDt),fullV(RS(2,:),1:tonicBottomUpStart/saveDt),saveDt,crossCorrDt,minDiff,maxDiff);
    lateCrossCorrRS(sim,:)=crossCorrelogram2(fullV(RS(1,:),tonicBottomUpStart/saveDt+1:end),fullV(RS(2,:),tonicBottomUpStart/saveDt+1:end),saveDt,crossCorrDt,minDiff,maxDiff);
    
    earlyCrossCorrIB(sim,:)=crossCorrelogram2(fullV(IBaxon(1,:),1:tonicBottomUpStart/saveDt),fullV(IBaxon(2,:),1:tonicBottomUpStart/saveDt),saveDt,crossCorrDt,minDiff,maxDiff);
    lateCrossCorrIB(sim,:)=crossCorrelogram2(fullV(IBaxon(1,:),tonicBottomUpStart/saveDt+1:end),fullV(IBaxon(2,:),tonicBottomUpStart/saveDt+1:end),saveDt,crossCorrDt,minDiff,maxDiff);
    
    meanEarlyCorrRS=mean(earlyCrossCorrRS(1:sim,:),1);
    devEarlyCorrRS=std(earlyCrossCorrRS(1:sim,:),1,1);
    meanLateCorrRS=mean(lateCrossCorrRS(1:sim,:),1);
    devLateCorrRS=std(lateCrossCorrRS(1:sim,:),1,1);
    
    meanEarlyCorrIB=mean(earlyCrossCorrIB(1:sim,:),1);
    devEarlyCorrIB=std(earlyCrossCorrIB(1:sim,:),1,1);
    meanLateCorrIB=mean(lateCrossCorrIB(1:sim,:),1);
    devLateCorrIB=std(lateCrossCorrIB(1:sim,:),1,1);
    
    hCorr=figure(2);
    clf
    subplot(1,3,1)
    plotStats(minDiff:crossCorrDt:maxDiff,meanEarlyCorrIB,devEarlyCorrIB)
%     hold on
%     plot(minDiff:crossCorrDt:maxDiff,meanEarlyCorrIB,'LineWidth',2)
%     plot(minDiff:crossCorrDt:maxDiff,meanEarlyCorrIB+devEarlyCorrIB,'r')
%     plot(minDiff:crossCorrDt:maxDiff,meanEarlyCorrIB-devEarlyCorrIB,'r')
%     hold off
    ax=gca;
%     ax.FontSize=14;
%     ax.FontWeight='bold';
    ax.Title.String='IB - Before';
    ax.YLim(1)=0;
    %ax.Title.String='Before';
    xlabel('Time (ms)')
    %ylabel('IB-IB crosscorrelation')
    ylabel('Crosscorrelation')
    
    subplot(1,3,2)
    plotStats(minDiff:crossCorrDt:maxDiff,meanLateCorrRS,devLateCorrRS)
%     hold on
%     plot(minDiff:crossCorrDt:maxDiff,meanLateCorrRS,'LineWidth',2)
%     plot(minDiff:crossCorrDt:maxDiff,meanLateCorrRS+devLateCorrRS,'r')
%     plot(minDiff:crossCorrDt:maxDiff,meanLateCorrRS-devLateCorrRS,'r')
%     hold off
    ax=gca;
%     ax.FontSize=14;
%     ax.FontWeight='bold';
    ax.Title.String='RS - After';
    ax.YLim(1)=0;
    xlabel('Time (ms)')
    %xlabel('Time (ms)','FontSize',14','FontWeight','bold')
    %ylabel('Col 1 RS- Col 2 RS cross correlation','FontSize',12','FontWeight','bold')
    
    subplot(1,3,3)
    plotStats(minDiff:crossCorrDt:maxDiff,meanLateCorrIB,devLateCorrIB)
%     hold on
%     plot(minDiff:crossCorrDt:maxDiff,meanLateCorrIB,'LineWidth',2)
%     plot(minDiff:crossCorrDt:maxDiff,meanLateCorrIB+devLateCorrIB,'r')
%     plot(minDiff:crossCorrDt:maxDiff,meanLateCorrIB-devLateCorrIB,'r')
%     hold off
    ax=gca;
%     ax.FontSize=14;
%     ax.FontWeight='bold';
    xlabel('Time (ms)')
    ax.YLim(1)=0;
    ax.Title.String='IB - After';
    %ax.Title.String='After';
    xlabel('Time (ms)')
    %ylabel('IB-IB crosscorrelation','FontSize',12','FontWeight','bold')
    
    drawnow;
    
    earlyPowerRS1(sim,:)=powerSpectrum(fullV(RS(1,:),1:tonicBottomUpStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerRS1(sim,:)=powerSpectrum(fullV(RS(1,:),tonicBottomUpStart/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    earlyPowerIB1(sim,:)=powerSpectrum(fullV(IBaxon(1,:),1:tonicBottomUpStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerIB1(sim,:)=powerSpectrum(fullV(IBaxon(1,:),tonicBottomUpStart/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    
    earlyPowerRS2(sim,:)=powerSpectrum(fullV(RS(2,:),1:tonicBottomUpStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerRS2(sim,:)=powerSpectrum(fullV(RS(2,:),tonicBottomUpStart/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    earlyPowerIB2(sim,:)=powerSpectrum(fullV(IBaxon(2,:),1:tonicBottomUpStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerIB2(sim,:)=powerSpectrum(fullV(IBaxon(2,:),tonicBottomUpStart/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    
    earlyPowerRS(sim,:)=powerSpectrum(fullV(RS,1:tonicBottomUpStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerRS(sim,:)=powerSpectrum(fullV(RS,tonicBottomUpStart/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    earlyPowerIB(sim,:)=powerSpectrum(fullV(IBaxon,1:tonicBottomUpStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerIB(sim,:)=powerSpectrum(fullV(IBaxon,tonicBottomUpStart/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);

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
    
    fStep=1000/(2*autoCorrStep*(length(meanEarlyPowerRS1)-1));
    fMax=50;
    
    freqAxis=0:fStep:fMax;
    
    hPower=figure(1);
    clf
    subplot(2,2,1)
    plotStats(freqAxis,meanEarlyPowerRS1(1:length(freqAxis)),devEarlyPowerRS1(1:length(freqAxis)),0.1)
    ax=gca;
    ax.Title.String='Before';
    ax.YLabel.String='Col 1 RS power';
    ax.YLim(1)=0;
    %ax.YLabel.FontSize=12;
    subplot(2,2,2)
    plotStats(freqAxis,meanLatePowerRS1(1:length(freqAxis)),devLatePowerRS1(1:length(freqAxis)),0.1)
    ax=gca;
    ax.Title.String='After';
    ax.YLim(1)=0;
    subplot(2,2,3)
    plotStats(freqAxis,meanEarlyPowerRS2(1:length(freqAxis)),devEarlyPowerRS2(1:length(freqAxis)),0.1)
    ax=gca;
    ax.XLabel.String='Frequency (Hz)';
    ax.YLabel.String='Col 2 RS power';
    ax.YLim(1)=0;
    %ax.YLabel.FontSize=12;
    subplot(2,2,4)
    plotStats(freqAxis,meanLatePowerRS2(1:length(freqAxis)),devLatePowerRS2(1:length(freqAxis)),0.1)
    ax=gca;
    ax.XLabel.String='Frequency (Hz)';
    ax.YLim(1)=0;

    drawnow;
    
    hPower2=figure(3);
    clf
    subplot(2,2,1)
    plotStats(freqAxis,meanEarlyPowerRS(1:length(freqAxis)),devEarlyPowerRS(1:length(freqAxis)),0.1)
    ax=gca;
    ax.Title.String='Before';
    ax.YLabel.String='RS power';
    ax.YLim(1)=0;
    %ax.YLabel.FontSize=12;
    subplot(2,2,2)
    plotStats(freqAxis,meanLatePowerRS(1:length(freqAxis)),devLatePowerRS(1:length(freqAxis)),0.1)
    ax=gca;
    ax.Title.String='After';
    ax.YLim(1)=0;
    subplot(2,2,3)
    plotStats(freqAxis,meanEarlyPowerIB(1:length(freqAxis)),devEarlyPowerIB(1:length(freqAxis)),0.1)
    ax=gca;
    ax.XLabel.String='Frequency (Hz)';
    ax.YLabel.String='IB power';
    ax.YLim(1)=0;
    %ax.YLabel.FontSize=12;
    subplot(2,2,4)
    plotStats(freqAxis,meanLatePowerIB(1:length(freqAxis)),devLatePowerIB(1:length(freqAxis)),0.1)
    ax=gca;
    ax.XLabel.String='Frequency (Hz)';
    ax.YLim(1)=0;
    
    
    h2=figure(10+sim);
    clf
    rastergram
    drawnow;
    fullFilepathRastergram=strcat(folder,'/',filepath,'-rastergram-',int2str(sim));
    if saveOutput
        saveas(h2,fullFilepathRastergram,'fig');
        saveas(h2,fullFilepathRastergram,'png');
    end
end

if saveOutput
    % Power spectrum
    
    fullFilepathPowerSpecSeparately=strcat(folder,'/',filepath,'-powerSpecSeparately');
    hPower.PaperUnits = 'inches';
    hPower.PaperPosition = [0 0 6 5]; % 8 6 before
    saveas(hPower,fullFilepathPowerSpecSeparately,'fig');
    saveas(hPower,fullFilepathPowerSpecSeparately,'png');
    
    fullFilepathPowerSpec=strcat(folder,'/',filepath,'-powerSpec');
    hPower2.PaperUnits = 'inches';
    hPower2.PaperPosition = [0 0 6 5];
    saveas(hPower2,fullFilepathPowerSpec,'fig');
    saveas(hPower2,fullFilepathPowerSpec,'png');
    
    % Cross correlation
    fullFilepathCorr=strcat(folder,'/',filepath,'-xcorr');
    hCorr.PaperUnits = 'inches';
    hCorr.PaperPosition = [0 0 18 5]; %16 4 before
    saveas(hCorr,fullFilepathCorr,'fig');
    saveas(hCorr,fullFilepathCorr,'png');
    
    fullFilepath=strcat(folder,'/',filepath);
    save(strcat(fullFilepath,'.mat'),'tonicBottomUpStartMat','earlyCrossCorrRS','lateCrossCorrRS','earlyCrossCorrIB','lateCrossCorrIB','meanEarlyCorrRS','devEarlyCorrRS','meanLateCorrRS','devLateCorrRS','meanEarlyCorrIB','devEarlyCorrIB','meanLateCorrIB','devLateCorrIB','earlyPowerRS1','latePowerRS1','earlyPowerIB1','latePowerIB1','earlyPowerRS2','latePowerRS2','earlyPowerIB2','latePowerIB2','meanEarlyPowerRS1','meanLatePowerRS1','meanEarlyPowerIB1','meanLatePowerIB1','meanEarlyPowerRS2','meanLatePowerRS2','meanEarlyPowerIB2','meanLatePowerIB2','devEarlyPowerRS1','devLatePowerRS1','devEarlyPowerIB1','devLatePowerIB1','devEarlyPowerRS2','devLatePowerRS2','devEarlyPowerIB2','devLatePowerIB2','fullVall');
    
    %saveas(h,fullFilepath,'svg');
    %save(strcat(fullFilepath,'.mat'),'earlyCrossCorrRS','lateCrossCorrRS','earlyCrossCorrIB','lateCrossCorrIB','meanEarlyCorrRS','devEarlyCorrRS','meanLateCorrRS','devLateCorrRS','meanEarlyCorrIB','devEarlyCorrIB','meanLateCorrIB','devLateCorrIB')
end




% % Saving in rastergram.m file
% fullFilepath=strcat(folder,'/',filepath);
% if saveRast
%     saveas(rastFig,fullFilepath,'fig');
%     saveas(rastFig,fullFilepath,'png');
% %    save(strcat(fullFilepath,'.mat'),'relativeMeanFreqs','relativeDevFreqs')
% end