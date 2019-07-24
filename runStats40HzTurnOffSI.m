filepath='40Hz-turnOffSI';

defaultParams; % call first to set parameters not set below

numCellsBase=20;
numColumns=1;

fourTimesRS=true; % Have four times more RS than every other population?

% gammaInput=1;
% gammaFreq=40;

gammaInput2=1;
startGamma2=400;
endGamma2=800;
maxColsGammaInput2=1;

turnOffSI=1;
inhibitoryPulse2Start=500;
inhibitoryPulse2Length=150;

numSims=10;

clear('fullVall');

minDiff=-80;
maxDiff=80;

oldDt=largeDt*saveStep;
crossCorrDt=1;

autoCorrMaxTime=1000;
autoCorrStep=10;
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

crossCorrEarly=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);
crossCorrLate=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);


% Early is before inhibitory pulse
% Late is from the beginning of the inhibitory pulse, for 100 (?)ms
earlyPowerRS=zeros(numSims,numCorrSteps);
latePowerRS=zeros(numSims,numCorrSteps);
earlyPowerIB=zeros(numSims,numCorrSteps);
latePowerIB=zeros(numSims,numCorrSteps);

% earlyPowerRS2=zeros(numSims,numCorrSteps);
% latePowerRS2=zeros(numSims,numCorrSteps);
% earlyPowerIB2=zeros(numSims,numCorrSteps);
% latePowerIB2=zeros(numSims,numCorrSteps);

for sim=1:numSims
    sim
    networkSim;
    fullVall(:,:,sim)=fullV;
    fullSInputAll(:,:,sim)=fullSInput;
    
    crossCorrEarly(sim,:)=crossCorrelogram2(fullV(RS(1,:),1:inhibitoryPulse2Start/largeDt),fullV(IBaxon(1,:),1:inhibitoryPulse2Start/largeDt),oldDt,crossCorrDt,minDiff,maxDiff);
    crossCorrLate(sim,:)=crossCorrelogram2(fullV(RS(1,:),inhibitoryPulse2Start/largeDt+1:(inhibitoryPulse2Start+inhibitoryPulse2Length)/largeDt),fullV(IBaxon(1,:),inhibitoryPulse2Start/largeDt+1:(inhibitoryPulse2Start+inhibitoryPulse2Length)/largeDt),oldDt,crossCorrDt,minDiff,maxDiff);
    
    meanCorrEarly=mean(crossCorrEarly(1:sim,:));
    devCorrEarly=std(crossCorrEarly(1:sim,:),1);
    
    meanCorrLate=mean(crossCorrLate(1:sim,:));
    devCorrLate=std(crossCorrLate(1:sim,:),1);
    
    hCorr=figure(2);
    clf
    subplot(2,1,1)
    plotStats(minDiff:crossCorrDt:maxDiff,meanCorrEarly,devCorrEarly)
    ax=gca;
    ax.YLim(1)=0;
    ax.FontWeight='bold';
    ax.FontSize=14;
    ax.Title.String='Before';
    ax.YLabel.String='RS-IB cross-correlation';
    ax.YLabel.FontSize=12;
    subplot(2,1,2)
    plotStats(minDiff:crossCorrDt:maxDiff,meanCorrLate,devCorrLate)
    ax=gca;
    ax.YLim(1)=0;
    ax.FontWeight='bold';
    ax.FontSize=14;
    ax.Title.String='During';
    ax.YLabel.String='RS-IB cross-correlation';
    ax.YLabel.FontSize=12;
    drawnow;
    
    earlyPowerRS(sim,:)=powerSpectrum(fullV(RS(1,:),1:inhibitoryPulse2Start/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerRS(sim,:)=powerSpectrum(fullV(RS(1,:),inhibitoryPulse2Start/largeDt+1:(inhibitoryPulse2Start+inhibitoryPulse2Length)/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    earlyPowerIB(sim,:)=powerSpectrum(fullV(IBaxon(1,:),1:inhibitoryPulse2Start/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerIB(sim,:)=powerSpectrum(fullV(IBaxon(1,:),inhibitoryPulse2Start/largeDt+1:(inhibitoryPulse2Start+inhibitoryPulse2Length)/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);

    meanEarlyPowerRS=mean(earlyPowerRS);
    devEarlyPowerRS=std(earlyPowerRS);
    meanLatePowerRS=mean(latePowerRS);
    devLatePowerRS=std(latePowerRS);
    meanEarlyPowerIB=mean(earlyPowerIB);
    devEarlyPowerIB=std(earlyPowerIB);
    meanLatePowerIB=mean(latePowerIB);
    devLatePowerIB=std(latePowerIB);
    
    fStep=1000/(2*autoCorrStep*(length(meanEarlyPowerRS)-1));
    fMax=1000/(2*autoCorrStep);
    
    freqAxis=0:fStep:fMax;
    
    h=figure(1);
    clf
    subplot(2,2,1)
    plotStats(freqAxis,meanEarlyPowerRS,devEarlyPowerRS,0.1)
    ax=gca;
    ax.YLim(1)=0;
    ax.Title.String='Before';
    ax.YLabel.String='RS power';
    subplot(2,2,2)
    plotStats(freqAxis,meanLatePowerRS,devLatePowerRS,0.1)
    ax=gca;
    ax.YLim(1)=0;
    ax.Title.String='During';
    subplot(2,2,3)
    plotStats(freqAxis,meanEarlyPowerIB,devEarlyPowerIB,0.1)
    ax=gca;
    ax.YLim(1)=0;
    ax.XLabel.String='Frequency (Hz)';
    ax.YLabel.String='IB power';
    subplot(2,2,4)
    plotStats(freqAxis,meanLatePowerIB,devLatePowerIB,0.1)
    ax=gca;
    ax.YLim(1)=0;
    ax.XLabel.String='Frequency (Hz)';

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
   
    fullFilepath=strcat(folder,'/',filepath);
    
    % Cross correlation
    saveXcorr(folder,filepath,hCorr);
    
    % Power spectrum
    fullFilepathPowerSpec=strcat(folder,'/',filepath,'-powerSpec');
    hPower.PaperUnits = 'inches';
    hPower.PaperPosition = [0 0 12 6];
    saveas(h,fullFilepathPowerSpec,'fig');
    saveas(h,fullFilepathPowerSpec,'png');
    
    % save all
    save(strcat(fullFilepath,'.mat'),'crossCorrEarly','crossCorrLate','meanCorrEarly','meanCorrLate','devCorrEarly','devCorrLate','earlyPowerRS','latePowerRS','earlyPowerIB','latePowerIB','meanEarlyPowerRS','devEarlyPowerRS','meanLatePowerRS','devLatePowerRS','meanEarlyPowerIB','devEarlyPowerIB','meanLatePowerIB','devLatePowerIB','fullVall','fullSInputAll','displayInputGamma2','displayInputTonicSI');
end

