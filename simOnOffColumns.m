filepath='onOffColumns';

defaultParams; % call first to set parameters not set below

saveOutput=true;

steps=5000;
numCellsBase=5;
numColumns=8;

fourTimesRS=true; % Have four times more RS than every other population?

connectColumns=1;
lastColLessExc=1;

numSims=1;

networkSim;
%fullVall(:,:,sim)=fullV;
%fullSInputAll(:,:,sim)=fullSInput;
    
%fullVtemp=fullV

if saveOutput
    fullFilepath=strcat(folder,'/',filepath);
    save(strcat(fullFilepath,'.mat'),'fullV','numColumns','numCellsBase');
end

fullVtemp=fullV;
%rastergram2;