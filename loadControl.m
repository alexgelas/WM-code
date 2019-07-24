load(strcat(dataFolder,'/manyColumns.mat'))
calcPowerSpec;

powerRSpre=earlyPowerRS;
powerIBpre=earlyPowerIB;

powerRSnoInput=latePowerRS;
powerIBnoInput=latePowerIB;

meanPowerRSpre=meanEarlyPowerRS;
devPowerRSpre=devEarlyPowerRS;
meanPowerIBpre=meanEarlyPowerIB;
devPowerIBpre=devEarlyPowerIB;

meanPowerRSnoInput=meanLatePowerRS;
devPowerRSnoInput=devLatePowerRS;
meanPowerIBnoInput=meanLatePowerIB;
devPowerIBnoInput=devLatePowerIB;

peaksb1RSpre=max(powerRSpre(:,minBeta1index:maxBeta1index),[],2);
peaksb1IBpre=max(powerIBpre(:,minBeta1index:maxBeta1index),[],2);
peaksb2RSpre=max(powerRSpre(:,minBeta2index:maxBeta2index),[],2);
peaksb2IBpre=max(powerIBpre(:,minBeta2index:maxBeta2index),[],2);

peaksb1RSnoInput=max(powerRSnoInput(:,minBeta1index:maxBeta1index),[],2);
peaksb1IBnoInput=max(powerIBnoInput(:,minBeta1index:maxBeta1index),[],2);
peaksb2RSnoInput=max(powerRSnoInput(:,minBeta2index:maxBeta2index),[],2);
peaksb2IBnoInput=max(powerIBnoInput(:,minBeta2index:maxBeta2index),[],2);


meanPeakb1RSpre=mean(peaksb1RSpre);
meanPeakb1IBpre=mean(peaksb1IBpre);
meanPeakb2RSpre=mean(peaksb2RSpre);
meanPeakb2IBpre=mean(peaksb2IBpre);

meanPeakb1RSnoInput=mean(peaksb1RSnoInput);
meanPeakb1IBnoInput=mean(peaksb1IBnoInput);
meanPeakb2RSnoInput=mean(peaksb2RSnoInput);
meanPeakb2IBnoInput=mean(peaksb2IBnoInput);


devPeakb1RSpre=std(peaksb1RSpre);
devPeakb1IBpre=std(peaksb1IBpre);
devPeakb2RSpre=std(peaksb2RSpre);
devPeakb2IBpre=std(peaksb2IBpre);

devPeakb1RSnoInput=std(peaksb1RSnoInput);
devPeakb1IBnoInput=std(peaksb1IBnoInput);
devPeakb2RSnoInput=std(peaksb2RSnoInput);
devPeakb2IBnoInput=std(peaksb2IBnoInput);

if usePrestimulus
    powerRScontrol=powerRSpre;
    powerIBcontrol=powerIBpre;
    meanPowerRScontrol=meanPowerRSpre;
    devPowerRScontrol=devPowerRSpre;
    meanPowerIBcontrol=meanPowerIBpre;
    devPowerIBcontrol=devPowerIBpre;
    peaksb1RScontrol=peaksb1RSpre;
    peaksb1IBcontrol=peaksb1IBpre;
    peaksb2RScontrol=peaksb2RSpre;
    peaksb2IBcontrol=peaksb2IBpre;
    meanPeakb1RScontrol=meanPeakb1RSpre;
    meanPeakb1IBcontrol=meanPeakb1IBpre;
    meanPeakb2RScontrol=meanPeakb2RSpre;
    meanPeakb2IBcontrol=meanPeakb2IBpre;
    devPeakb1RScontrol=devPeakb1RSpre;
    devPeakb1IBcontrol=devPeakb1IBpre;
    devPeakb2RScontrol=devPeakb2RSpre;
    devPeakb2IBcontrol=devPeakb2IBpre;
else
    powerRScontrol=powerRSnoInput;
    powerIBcontrol=powerIBnoInput;
    meanPowerRScontrol=meanPowerRSnoInput;
    devPowerRScontrol=devPowerRSnoInput;
    meanPowerIBcontrol=meanPowerIBnoInput;
    devPowerIBcontrol=devPowerIBnoInput;
    
    peaksb1RScontrol=peaksb1RSnoInput;
    peaksb1IBcontrol=peaksb1IBnoInput;
    peaksb2RScontrol=peaksb2RSnoInput;
    peaksb2IBcontrol=peaksb2IBnoInput;
    
    meanPeakb1RScontrol=meanPeakb1RSnoInput;
    meanPeakb1IBcontrol=meanPeakb1IBnoInput;
    meanPeakb2RScontrol=meanPeakb2RSnoInput;
    meanPeakb2IBcontrol=meanPeakb2IBnoInput;
    
    devPeakb1RScontrol=devPeakb1RSnoInput;
    devPeakb1IBcontrol=devPeakb1IBnoInput;
    devPeakb2RScontrol=devPeakb2RSnoInput;
    devPeakb2IBcontrol=devPeakb2IBnoInput;
end