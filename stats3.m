autoCorrMaxTime=1000;
autoCorrStep=1;
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;


if exist('simStart','var')
    simStart
else
    warning('simStart not set. Starting from sim number 1')
    simStart=1;
end

if simStart==1
    clear('fullVall');
    clear('fullSInputAll');
    earlyPowerRS=zeros(numSims,numCorrSteps);
    latePowerRS=zeros(numSims,numCorrSteps);
    earlyPowerIB=zeros(numSims,numCorrSteps);
    latePowerIB=zeros(numSims,numCorrSteps);
    if lastColLessExc
        earlyPowerRSlast=zeros(numSims,numCorrSteps);
        latePowerRSlast=zeros(numSims,numCorrSteps);
        earlyPowerIBlast=zeros(numSims,numCorrSteps);
        latePowerIBlast=zeros(numSims,numCorrSteps);
    end
    syncs=zeros(numSims,1);
    syncs2=zeros(numSims,1);
else
    fullFilepath=strcat(folder,'/',filepath);
    load(strcat(fullFilepath,'.mat'),'-mat');
end

for sim=simStart:numSims
    sim
    networkSim;
    fullVall(:,:,sim)=fullV;
    fullSInputAll(:,:,sim)=fullSInput;
    
    %figure(1)
    earlyPowerRS(sim,:)=powerSpectrum(fullV(RS,1:topDownStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerRS(sim,:)=powerSpectrum(fullV(RS,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    earlyPowerIB(sim,:)=powerSpectrum(fullV(IBaxon,1:topDownStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerIB(sim,:)=powerSpectrum(fullV(IBaxon,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        
    meanEarlyPowerRS=mean(earlyPowerRS(1:sim,:),1);
    devEarlyPowerRS=std(earlyPowerRS(1:sim,:),1,1);
    meanLatePowerRS=mean(latePowerRS(1:sim,:),1);
    devLatePowerRS=std(latePowerRS(1:sim,:),1,1);
    meanEarlyPowerIB=mean(earlyPowerIB(1:sim,:),1);
    devEarlyPowerIB=std(earlyPowerIB(1:sim,:),1,1);
    meanLatePowerIB=mean(latePowerIB(1:sim,:),1);
    devLatePowerIB=std(latePowerIB(1:sim,:),1,1);
    
    if lastColLessExc
        earlyPowerRSlast(sim,:)=powerSpectrum(fullV(RS(numColumns,:),1:topDownStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        latePowerRSlast(sim,:)=powerSpectrum(fullV(RS(numColumns,:),(topDownStart+topDownDuration)/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        earlyPowerIBlast(sim,:)=powerSpectrum(fullV(IBaxon(numColumns,:),1:topDownStart/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        latePowerIBlast(sim,:)=powerSpectrum(fullV(IBaxon(numColumns,:),(topDownStart+topDownDuration)/largeDt+1:end),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
        
        meanEarlyPowerRSlast=mean(earlyPowerRSlast);
        devEarlyPowerRSlast=std(earlyPowerRSlast);
        meanLatePowerRSlast=mean(latePowerRSlast);
        devLatePowerRSlast=std(latePowerRSlast);
        meanEarlyPowerIBlast=mean(earlyPowerIBlast);
        devEarlyPowerIBlast=std(earlyPowerIBlast);
        meanLatePowerIBlast=mean(latePowerIBlast);
        devLatePowerIBlast=std(latePowerIBlast);
        
    end

    
    fStep=1000/(2*autoCorrStep*(length(meanEarlyPowerRS)-1));
    fMax=50;
    
    freqAxis=0:fStep:fMax;
    
    h=figure(1);
    clf
    subplot(2,2,1)
    plotStats(freqAxis,meanEarlyPowerRS(1:length(freqAxis)),devEarlyPowerRS(1:length(freqAxis)),0.1)
    ax=gca;
    ax.Title.String='Before';
    ax.YLabel.String='RS power';
    ax.YLim(1)=0;
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
    subplot(2,2,4)
    plotStats(freqAxis,meanLatePowerIB(1:length(freqAxis)),devLatePowerIB(1:length(freqAxis)),0.1)
    ax=gca;
    ax.XLabel.String='Frequency (Hz)';
    ax.YLim(1)=0;

    drawnow;

    h2=figure(10+sim);
    clf
    rastergram
    drawnow;
    
    syncRS(sim)=syncMeasure(fullV(RS,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,1)
    syncRS2(sim)=syncMeasure2(fullV(RS,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,1)
    syncIB(sim)=syncMeasure(fullV(IBaxon,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,1)
    syncIB2(sim)=syncMeasure2(fullV(IBaxon,(topDownStart+topDownDuration)/largeDt+1:end),largeDt,1)
    
    meanSyncRS=mean(syncRS(1:sim))
    meanSyncRS2=mean(syncRS2(1:sim))
    devSyncRS=std(syncRS(1:sim))
    devSyncRS2=std(syncRS2(1:sim))
    meanSyncIB=mean(syncIB(1:sim))
    meanSyncIB2=mean(syncIB2(1:sim))
    devSyncIB=std(syncIB(1:sim))
    devSyncIB2=std(syncIB2(1:sim))
    
    if saveOutput
        fullFilepath=strcat(folder,'/',filepath);
        fullFilepathRastergram=strcat(folder,'/',filepath,'-rastergram-',int2str(sim));
        fullFilepathPowerSpec=strcat(folder,'/',filepath,'-powerSpec');

        saveas(h2,fullFilepathRastergram,'fig');
        saveas(h2,fullFilepathRastergram,'png');
        
        saveas(h,fullFilepathPowerSpec,'fig');
        saveas(h,fullFilepathPowerSpec,'png');
        
        if lastColLessExc
            save(strcat(fullFilepath,'.mat'),'earlyPowerRS','earlyPowerIB','latePowerRS','latePowerIB','meanEarlyPowerRS','meanLatePowerRS','meanEarlyPowerIB','meanLatePowerIB','devEarlyPowerRS','devLatePowerRS','devEarlyPowerIB','devLatePowerIB','earlyPowerRSlast','earlyPowerIBlast','latePowerRSlast','latePowerIBlast','meanEarlyPowerRSlast','meanLatePowerRSlast','meanEarlyPowerIBlast','meanLatePowerIBlast','devEarlyPowerRSlast','devLatePowerRSlast','devEarlyPowerIBlast','devLatePowerIBlast','fullVall');
        else
            save(strcat(fullFilepath,'.mat'),'earlyPowerRS','earlyPowerIB','latePowerRS','latePowerIB','meanEarlyPowerRS','meanLatePowerRS','meanEarlyPowerIB','meanLatePowerIB','devEarlyPowerRS','devLatePowerRS','devEarlyPowerIB','devLatePowerIB','fullVall');
        end
    end
end

if saveOutput
    fullFilepath=strcat(folder,'/',filepath);
    fullFilepathPowerSpec=strcat(folder,'/',filepath,'-powerSpec');
    h.PaperUnits='inches';
    h.PaperPosition=[0 0 6 5];
    saveas(h,fullFilepathPowerSpec,'fig');
    saveas(h,fullFilepathPowerSpec,'png');
    if lastColLessExc
        save(strcat(fullFilepath,'.mat'),'earlyPowerRS','earlyPowerIB','latePowerRS','latePowerIB','meanEarlyPowerRS','meanLatePowerRS','meanEarlyPowerIB','meanLatePowerIB','devEarlyPowerRS','devLatePowerRS','devEarlyPowerIB','devLatePowerIB','earlyPowerRSlast','earlyPowerIBlast','latePowerRSlast','latePowerIBlast','meanEarlyPowerRSlast','meanLatePowerRSlast','meanEarlyPowerIBlast','meanLatePowerIBlast','devEarlyPowerRSlast','devLatePowerRSlast','devEarlyPowerIBlast','devLatePowerIBlast','fullVall','fullSInputAll','displayInputBeta');
    else
        save(strcat(fullFilepath,'.mat'),'earlyPowerRS','earlyPowerIB','latePowerRS','latePowerIB','meanEarlyPowerRS','meanLatePowerRS','meanEarlyPowerIB','meanLatePowerIB','devEarlyPowerRS','devLatePowerRS','devEarlyPowerIB','devLatePowerIB','fullVall','fullSInputAll','displayInputBeta');
    end
end


%save('parameters.mat','')
