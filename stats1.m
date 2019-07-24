%histMax=1.2*1000/gammaFreq;

histFreqs=zeros(numSims,histMax);

% For a single column only!!

for sim=1:numSims
    sim
    networkSim;
    
    amps=100;
    stepsPlot=size(fullV,2);
        
    axonStart=IBaxon(1);
    axonEnd=IBaxon(colNumIB);
    
    histFreqs(sim,:)=phaseHist(fullV(axonStart:axonEnd,:),fullInputV(6,:),dt,histMax);

    meanFreqs=mean(histFreqs(1:sim,:));
    devFreqs=std(histFreqs(1:sim,:),1);
    
    relativeMeanFreqs=meanFreqs/sum(meanFreqs);
    relativeDevFreqs=devFreqs/sum(meanFreqs);

    h=statsHist(relativeMeanFreqs,relativeDevFreqs,0,30);
    
    xlabel('Time (ms) from last input pulse','FontSize',14','FontWeight','bold')
    ylabel('Relative freq','FontSize',14','FontWeight','bold')
    drawnow;
end

meanFreqs=mean(histFreqs);
devFreqs=std(histFreqs,1);

relativeMeanFreqs=meanFreqs/sum(meanFreqs);
relativeDevFreqs=devFreqs/sum(meanFreqs);

h=statsHist(relativeMeanFreqs,relativeDevFreqs,0,30);
figure(h)

xlabel('Time (ms) from last input pulse','FontSize',14','FontWeight','bold')
fullFilepath=strcat(folder,'/',filepath,'-hist');
if saveHist
    h.PaperUnits = 'inches';
    h.PaperPosition = [0 0 6 3];
    saveas(h,fullFilepath,'fig');
    saveas(h,fullFilepath,'png');
    save(strcat(fullFilepath,'.mat'),'relativeMeanFreqs','relativeDevFreqs')
end