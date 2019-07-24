minDiff=-80;
maxDiff=80;

oldDt=largeDt*saveStep;
crossCorrDt=1;

autoCorrMaxTime=1000;
autoCorrStep=10;
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

crossCorr=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);

powerRS=zeros(numSims,numCorrSteps);
powerIB=zeros(numSims,numCorrSteps);

clear('fullVall');

% Caution: The crosscorrelogram does not distinguish between columns.
% Treats them all together.

%fullGammaInputSall=zeros(numSims,steps/saveStep);

for sim=1:numSims
    sim
    networkSim;
    fullVall(:,:,sim)=fullV;
    fullSInputAll(:,:,sim)=fullSInput;
    %fullGammaInputSall(sim,:)=fullSInput(displayInputGamma2,:);
    %amps=100;
    stepsPlot=size(fullV,2);
    
    crossCorr(sim,:)=crossCorrelogram2(fullV(RS,:),fullV(IBaxon,:),oldDt,crossCorrDt,minDiff,maxDiff);
    %crossCorr(sim,:)=crossCorrelogram2(fullInputV(6,:),fullV(IBaxon,:),oldDt,crossCorrDt,minDiff,maxDiff);
    
    %histFreqs(sim,:)=phaseHist(fullV(axonStart:axonEnd,:),fullInputV(6,:),dt,histMax);

    meanCorr=mean(crossCorr(1:sim,:),1);
    devCorr=std(crossCorr(1:sim,:),1,1);
    
    %relativeMeanCorr=meanCorr/sum(meanCorr);
    %relativeDevCorr=devCorr/sum(meanCorr);
    
    hCorr=figure(22);
    clf
    plotStats(minDiff:crossCorrDt:maxDiff,meanCorr,devCorr)
%     clf
%     hold on
%     plot(minDiff:crossCorrDt:maxDiff,meanCorr,'LineWidth',2)
%     plot(minDiff:crossCorrDt:maxDiff,meanCorr+devCorr,'r')
%     plot(minDiff:crossCorrDt:maxDiff,meanCorr-devCorr,'r')
%     hold off
    ax=gca;
    ax.YLim(1)=0;
    xlabel('Time (ms)')
    ylabel('RS-IB crosscorrelation')
    drawnow;
    
    powerRS(sim,:)=powerSpectrum(fullV(RS,:),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    powerIB(sim,:)=powerSpectrum(fullV(IBaxon,:),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    
    meanPowerRS=mean(powerRS(1:sim,:),1);
    devPowerRS=std(powerRS(1:sim,:),1,1);
    meanPowerIB=mean(powerIB(1:sim,:),1);
    devPowerIB=std(powerIB(1:sim,:),1,1);
    
    fStep=1000/(2*autoCorrStep*(length(meanPowerRS)-1));
    fMax=50;
    
    freqAxis=0:fStep:fMax;
    
    hPower=figure(1);
    clf
    subplot(1,2,1)
    plotStats(freqAxis,meanPowerRS(1:length(freqAxis)),devPowerRS(1:length(freqAxis)))
    ax=gca;
    ax.XLabel.String='Frequency (Hz)';
    ax.Title.String='RS';
    ax.YLabel.String='Power';
    ax.YLim(1)=0;
    subplot(1,2,2)
    plotStats(freqAxis,meanPowerIB(1:length(freqAxis)),devPowerIB(1:length(freqAxis)))
    ax=gca;
    ax.XLabel.String='Frequency (Hz)';
    ax.Title.String='IB';
    ax.YLim(1)=0;
    drawnow;
    
    h2=figure(10+sim);
    clf
    rastergram
    drawnow;
    fullFilepathRastergram=strcat(folder,'/',filepath,'-rastergram-',int2str(sim));
    if saveOutput
        h2.Units='inches';
        h2.Position=[0 0 6 5];
        saveas(h2,fullFilepathRastergram,'fig');
        saveas(h2,fullFilepathRastergram,'png');
    end
end

if saveOutput
    % save all data
    fullFilepath=strcat(folder,'/',filepath);
    save(strcat(fullFilepath,'.mat'),'crossCorr','meanCorr','devCorr','powerRS','powerIB','meanPowerRS','devPowerRS','meanPowerIB','devPowerIB','fullVall','fullSInputAll','displayInputGamma2');
    saveXcorr(folder,filepath,hCorr);
    
    % Crosscorrelogram
    
%     hCorr.PaperUnits = 'inches';
%     hCorr.PaperPosition = [0 0 6 5];
%     
%     fullFilepathCorr=strcat(folder,'/',filepath,'-xcorr');    
%     saveas(hCorr,fullFilepathCorr,'fig');
%     saveas(hCorr,fullFilepathCorr,'png');
    
    % Power spectrum
    hPower.PaperUnits = 'inches';
    hPower.PaperPosition = [0 0 12 5];
    
    fullFilepathPower=strcat(folder,'/',filepath,'-powerSpec');
    
    saveas(hPower,fullFilepathPower,'fig');
    saveas(hPower,fullFilepathPower,'png');
    
end