filepath='40Hz';

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

numSims=10;

clear('fullVall');

minDiff=-80;
maxDiff=80;

oldDt=largeDt*saveStep;
crossCorrDt=1;

autoCorrMaxTime=1000;
autoCorrStep=1;
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

crossCorrEarly=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);
crossCorrLate=zeros(numSims,(maxDiff-minDiff)/crossCorrDt+1);

% Early is before startGamma2
% Late is startGamma2 till endGamm2
earlyPowerRS=zeros(numSims,numCorrSteps);
latePowerRS=zeros(numSims,numCorrSteps);
earlyPowerIB=zeros(numSims,numCorrSteps);
latePowerIB=zeros(numSims,numCorrSteps);

fullGammaInputSall=zeros(numSims,steps/saveStep);
fullTonicSIinputSall=zeros(numSims,steps/saveStep);

for sim=1:numSims
    sim
    networkSim;
    fullVall(:,:,sim)=fullV;
    fullSInputAll(:,:,sim)=fullSInput;
    crossCorrEarly(sim,:)=crossCorrelogram2(fullV(RS(1,:),1:startGamma2/largeDt),fullV(IBaxon(1,:),1:startGamma2/largeDt),oldDt,crossCorrDt,minDiff,maxDiff);
    crossCorrLate(sim,:)=crossCorrelogram2(fullV(RS(1,:),startGamma2/largeDt+1:endGamma2/largeDt),fullV(IBaxon(1,:),startGamma2/largeDt+1:endGamma2/largeDt),oldDt,crossCorrDt,minDiff,maxDiff);
    
    meanCorrEarly=mean(crossCorrEarly(1:sim,:));
    devCorrEarly=std(crossCorrEarly(1:sim,:),1);
    
    meanCorrLate=mean(crossCorrLate(1:sim,:));
    devCorrLate=std(crossCorrLate(1:sim,:),1);
    
    hCorr=figure(2);
    clf
    subplot(2,1,1)
    plotStats(minDiff:crossCorrDt:maxDiff,meanCorrEarly,devCorrEarly)
    ax=gca;
    ax.Title.String='Before';
    ax.YLabel.String='RS-IB cross-correlation';
    ax.YLabel.FontSize=12;
    ax.YLim=[0 ax.YLim(2)];
    subplot(2,1,2)
    plotStats(minDiff:crossCorrDt:maxDiff,meanCorrLate,devCorrLate)
    ax=gca;
    ax.Title.String='During';
    ax.YLabel.String='RS-IB cross-correlation';
    ax.YLabel.FontSize=12;
    ax.YLim=[0 ax.YLim(2)];
    drawnow;
    

    h2=figure(10+sim);
    clf
    rastergram
    drawnow;
    if saveOutput
        saveRastergram(folder,filepath,h2,sim)
    end
    
end

if saveOutput
    fullFilepath=strcat(folder,'/',filepath);
    save(strcat(fullFilepath,'.mat'),'meanCorrEarly','meanCorrLate','devCorrEarly','devCorrLate','fullVall','fullSInputAll','displayInputGamma2','startGamma2','endGamma2');
    saveXcorr(folder,filepath,hCorr);
end

% if saveOutput
%     % Cross correlation
%     fullFilepath=strcat(folder,'/',filepath);
%     saveXcorr(folder,filepath,hCorr);
%     
%     save(strcat(fullFilepath,'.mat'),'meanCorrEarly','meanCorrLate','devCorrEarly','devCorrLate','fullVall');
% %     fullFilepathXcorr=strcat(folder,'/',filepath,'-xcorr');
% %     hCorr.PaperUnits = 'inches';
% %     hCorr.PaperPosition = [0 0 6 5];
% %     saveas(hCorr,fullFilepathXcorr,'fig');
% %     saveas(hCorr,fullFilepathXcorr,'png');
%     
% 
% %     % Power spectrum
% %     fullFilepathPowerSpec=strcat(folder,'/',filepath,'-powerSpec');
% %     hPower.PaperUnits = 'inches';
% %     hPower.PaperPosition = [0 0 12 6];
% %     saveas(h,fullFilepathPowerSpec,'fig');
% %     saveas(h,fullFilepathPowerSpec,'png');
%     
%     %save(strcat(fullFilepath,'.mat'),'meanEarlyPowerRS','meanLatePowerRS','meanEarlyPowerIB','meanLatePowerIB','devEarlyPowerRS','devLatePowerRS','devEarlyPowerIB','devLatePowerIB','fullVall');
%     
% end

