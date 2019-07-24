earlyPowerRS=zeros(numSims,numCorrSteps);
latePowerRS=zeros(numSims,numCorrSteps);
earlyPowerIB=zeros(numSims,numCorrSteps);
latePowerIB=zeros(numSims,numCorrSteps);
duringPowerRS=zeros(numSims,numCorrSteps);
duringPowerIB=zeros(numSims,numCorrSteps);

beginEarly=300/largeDt;
endEarly=600/largeDt;

beginLate=900/largeDt; % (topDownStart+topDownDuration)/largeDt
endLate=1200/largeDt;

for sim=1:numSims
    fullV=fullVall(:,:,sim);
    sim;
    earlyPowerRS(sim,:)=powerSpectrum(fullV(RS,beginEarly+1:endEarly),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    duringPowerRS(sim,:)=powerSpectrum(fullV(RS,topDownStart/largeDt+1:(topDownStart+topDownDuration)/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerRS(sim,:)=powerSpectrum(fullV(RS,beginLate+1:endLate),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    earlyPowerIB(sim,:)=powerSpectrum(fullV(IBaxon,beginEarly+1:endEarly),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    duringPowerIB(sim,:)=powerSpectrum(fullV(IBaxon,topDownStart/largeDt+1:(topDownStart+topDownDuration)/largeDt),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
    latePowerIB(sim,:)=powerSpectrum(fullV(IBaxon,beginLate+1:endLate),largeDt,autoCorrStep,-autoCorrMaxTime,autoCorrMaxTime);
end

meanEarlyPowerRS=mean(earlyPowerRS,1);
devEarlyPowerRS=std(earlyPowerRS,1,1);
meanDuringPowerRS=mean(duringPowerRS,1);
devDuringPowerRS=std(duringPowerRS,1,1);
meanLatePowerRS=mean(latePowerRS,1);
devLatePowerRS=std(latePowerRS,1,1);
meanEarlyPowerIB=mean(earlyPowerIB,1);
devEarlyPowerIB=std(earlyPowerIB,1,1);
meanDuringPowerIB=mean(duringPowerIB,1);
devDuringPowerIB=std(duringPowerIB,1,1);
meanLatePowerIB=mean(latePowerIB,1);
devLatePowerIB=std(latePowerIB,1,1);

