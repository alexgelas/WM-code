folder='figuresSet9';

autoCorrMaxTime=1000; % Must agree with the one used in simulations
autoCorrStep=10; % This, too.

numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

fStep=1000/(2*autoCorrStep*(numCorrSteps-1));
fMax=1000/(2*autoCorrStep);
freqAxis=0:fStep:1000/(2*autoCorrStep);

minBeta1index=floor(12/fStep);
maxBeta1index=floor(20/fStep);

load(strcat(folder,'/topDown-15Hz/topDown-15Hz.mat'))
latePowerRS15Hz=latePowerRS;
latePowerIB15Hz=latePowerIB;
pRS=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)
pIB=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)

load(strcat(folder,'/topDown-25Hz/topDown-25Hz.mat'))
latePowerRS25Hz=latePowerRS;
latePowerIB25Hz=latePowerIB;
pRS=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)
pIB=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)

load(strcat(folder,'/topDown-40Hz/topDown-40Hz.mat'))
latePowerRS40Hz=latePowerRS;
latePowerIB40Hz=latePowerIB;
pRS=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)
pIB=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)

pRS15_25=powerPeakTest(latePowerRS15Hz,latePowerRS25Hz,minBeta1index,maxBeta1index)
pRS15_40=powerPeakTest(latePowerRS15Hz,latePowerRS40Hz,minBeta1index,maxBeta1index)
pRS25_40=powerPeakTest(latePowerRS25Hz,latePowerRS40Hz,minBeta1index,maxBeta1index)
pIB15_25=powerPeakTest(latePowerIB15Hz,latePowerIB25Hz,minBeta1index,maxBeta1index)
pIB15_40=powerPeakTest(latePowerIB15Hz,latePowerIB40Hz,minBeta1index,maxBeta1index)
pIB25_40=powerPeakTest(latePowerIB25Hz,latePowerIB40Hz,minBeta1index,maxBeta1index)
%load(strcat(folder,'/topDown 25Hz lastColLessExc final/topDown-25Hz-lastColLessExc.mat'))
%pRS=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)
%pIB=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)



% load(strcat(folder,'/temporal final/temporalBottomUp.mat'))
% pRS=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)
% pIB=powerPeakTest(earlyPowerRS,latePowerRS,minBeta1index,maxBeta1index)

