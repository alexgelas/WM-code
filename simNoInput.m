filepath='noInput';
saveOutput=true;

defaultParams; % call first to set parameters not set below

numCellsBase=20;
numColumns=1;

fourTimesRS=true; % Have four times more RS than every other population?

numSims=1;

for sim=1:numSims
    sim
    networkSim;
    rastFig=figure(sim);
    clf
    hold on
    rastergram;
    drawnow;
end