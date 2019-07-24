filepath='topDown-tonic'; % step input

defaultParams; % call first to set parameters not set below

saveOutput=true;

steps=6000;
numCellsBase=5;
numColumns=8;

fourTimesRS=true; % Have four times more RS than every other population?

%beta2input=1;
%topDownTurnOffFS=0;
%topDownStart=600;
%topDownDuration=270;
%beta2Freq=8;

%tonicInputExcIB=1;
tonicInputExcIBstep=1;

tonicInputExcIBstart=600;
tonicInputExcIBstop=750;

connectColumns=1;

numSims=20;
stats3