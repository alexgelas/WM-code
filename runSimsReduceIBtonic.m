filepath='reduceIBtonic-rastergram';
saveRast=true;

defaultParams; % call first to set parameters not set below

numCellsBase=20;
numColumns=1;

fourTimesRS=true; % Have four times more RS than every other population?

reduceRStonic=0;
reduceIBtonic=1;

histMax=30;
numSims=10;

for sim=1:10
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