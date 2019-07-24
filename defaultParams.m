steps=5000;

largeDt=0.2;
saveStep=1;%max(1,0.1/largeDt);%/smallDt;
saveDt=largeDt*saveStep;

folder='figuresSet9';
saveOutput=true;
%folder='testFigs';

nameSuffix='';
mathNet=0;

numCellsBase=20;
numColumns=1;

fourTimesRS=true; % Have four times more RS than every other population?

gammaInput=0;
gammaFreq=40;
%gammaJitter=0.2; % max offset of period as a percentage % Value till June 14th 2018
gammaJitter=0.1; % Changed on June 14th 2018

morePoisson=0;

gammaInput2=0;
startGamma2=0;
endGamma2=0;
maxColsGammaInput2=1;

beta2input=0;
topDownTurnOffFS=0;
beta2Freq=25;
connectColumns=0;
topDownStart=600;
topDownDuration=150;
numMaxColsInput=100;
mixedTopDown=0; % The first and third quarters of columns get top down, the rest don't.

turnOffBeta=0;
inhibitoryPulse1Length=120;
inhibitoryPulse1Start=500;
turnOffTarget='IB';
turnOffAmp=2;

hyperpolLTS=0; % During the whole simulation
turnOffSI=0; % Turn off temporarily
inhibitoryPulse2Start=500;
inhibitoryPulse2Length=150;

tonicInputExcIB=0;
tonicInputExcIBstep=0;
tonicInputExcIBstart=0;
tonicInputExcIBstop=0;

IBmoreExcitable=false;
IBmoreExcFactor=1;
IBlessExcitable=false;
IBmuchLessExcitable=false;
FSmoreExcitable=false;
FSlessExcitable=false;
RSmoreExcitable=false;
RSlessExcitable=false;
RSmuchLessExcitable=false;
lastColLessExc=false;

reduceRStonic=0;
reduceIBtonic=0;

synapticBeta=0;

separateLayers=0;

displayInputGamma=0;
displayInputGamma2=0;
displayInputBeta=0;
displayInputTonicIB=0;
displayInputTonicSI=0;

heading='';
showArrows=0;

temporalBottomUp=0;
tonicBottomUpStart=400;

beta1Freq=15;
beta1Input=0;