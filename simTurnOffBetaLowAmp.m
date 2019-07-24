filepath='turnOffBeta-LowAmp-rastergram';
saveRast=true;

defaultParams; % call first to set parameters not set below

numCellsBase=20;
numColumns=1;

fourTimesRS=true; % Have four times more RS than every other population?

turnOffBeta=1;
inhibitoryPulse1Start=500;
inhibitoryPulse1Length=120;
turnOffTarget='IB';
turnOffAmp=0.5;

numSims=10;

for sim=1:numSims
    sim
    networkSim;
    rastFig=figure(sim);
    clf
    hold on
    rastergram;
    drawnow;
end

fullFilepath=strcat(folder,'/',filepath);
if saveRast
    saveas(rastFig,fullFilepath,'fig');
    saveas(rastFig,fullFilepath,'png');
%    save(strcat(fullFilepath,'.mat'),'relativeMeanFreqs','relativeDevFreqs')
end