filepath='reduceRStonic';
saveRast=true;

defaultParams; % call first to set parameters not set below

numCellsBase=20;
numColumns=1;

fourTimesRS=true; % Have four times more RS than every other population?

reduceRStonic=1;

numSims=10;
clear('fullVall')
clear('fullSInputAll')
for sim=1:10
    sim
    networkSim;
    fullVall(:,:,sim)=fullV;
    fullSInputAll(:,:,sim)=fullSInput;
    
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
    save(strcat(fullFilepath,'.mat'),'fullVall','fullSInputAll');
%    save(strcat(fullFilepath,'.mat'),'relativeMeanFreqs','relativeDevFreqs')
end