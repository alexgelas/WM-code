dataFolder='simData';
autoCorrMaxTime=1000;
%autoCorrStep=10;
autoCorrStep=1; % June 27th 2018
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

numCellsBase=5;
numColumns=8;
cellNumbering;

topDownStart=600;
topDownDuration=100;

earlyPowerRS=zeros(numSims,numCorrSteps);
latePowerRS=zeros(numSims,numCorrSteps);
earlyPowerIB=zeros(numSims,numCorrSteps);
latePowerIB=zeros(numSims,numCorrSteps);

fStep=1000/(2*autoCorrStep*(numCorrSteps-1));
% fMax=1000/(2*autoCorrStep);
fMax=50; % June 27th 2018

freqAxis=0:fStep:fMax;

minBeta1index=floor(12/fStep);
maxBeta1index=floor(20/fStep);

minBeta2index=floor(20/fStep);
maxBeta2index=floor(30/fStep);

filepath='manyColumns';
load(strcat(dataFolder,'/manyColumns.mat'))
%load(strcat(folder,'/manyColumns RS0.3 IB0.3/manyColumns.mat'))
%load(strcat(folder,'/manyColumns RS0.1 IB0.5/manyColumns.mat'))
calcPowerSpec;
powerRSnoInput=latePowerRS;
powerIBnoInput=latePowerIB;

powerRSpre=earlyPowerRS;
powerIBpre=earlyPowerIB;

meanPowerRSpre=meanEarlyPowerRS;
devPowerRSpre=devEarlyPowerRS;
meanPowerIBpre=meanEarlyPowerIB;
devPowerIBpre=devEarlyPowerIB;

meanDuringPowerRSnoInput=meanDuringPowerRS;
devDuringPowerRSnoInput=devDuringPowerRS;
meanLatePowerRSnoInput=meanLatePowerRS;
devLatePowerRSnoInput=devLatePowerRS;
meanDuringPowerIBnoInput=meanDuringPowerIB;
devDuringPowerIBnoInput=devDuringPowerIB;
meanLatePowerIBnoInput=meanLatePowerIB;
devLatePowerIBnoInput=devLatePowerIB;

filepath='topDown-15Hz-2pulses';
load(strcat(dataFolder,'/topDown-15Hz-2pulses.mat'))
%load(strcat(folder,'/topDown-15Hz RS0.3 IB0.3/topDown-15Hz.mat'))
%load(strcat(folder,'/topDown-15Hz RS0.1 IB0.5/topDown-15Hz.mat'))
calcPowerSpec;
powerRS15Hz=latePowerRS;
powerIB15Hz=latePowerIB;

meanDuringPowerRS15Hz=meanDuringPowerRS;
devDuringPowerRS15Hz=devDuringPowerRS;
meanLatePowerRS15Hz=meanLatePowerRS;
devLatePowerRS15Hz=devLatePowerRS;
meanDuringPowerIB15Hz=meanDuringPowerIB;
devDuringPowerIB15Hz=devDuringPowerIB;
meanLatePowerIB15Hz=meanLatePowerIB;
devLatePowerIB15Hz=devLatePowerIB;

pRSb1_15=powerPeakTest(powerRSpre,powerRS15Hz,minBeta1index,maxBeta1index)
pIBb1_15=powerPeakTest(powerIBpre,powerIB15Hz,minBeta1index,maxBeta1index)

pRSb2_15=powerPeakTest(powerRSpre,powerRS15Hz,minBeta2index,maxBeta2index)
pIBb2_15=powerPeakTest(powerIBpre,powerIB15Hz,minBeta2index,maxBeta2index)

% pRS=powerPeakTest(powerRSnoInput,powerRS15Hz,minBeta1index,maxBeta1index)
% pIB=powerPeakTest(powerIBnoInput,powerIB15Hz,minBeta1index,maxBeta1index)

filepath='topDown-25Hz-3pulses';
load(strcat(dataFolder,'/topDown-25Hz-3pulses.mat'))
%load(strcat(folder,'/topDown-25Hz RS0.3 IB0.3/topDown-25Hz.mat'))
%load(strcat(folder,'/topDown-25Hz RS0.1 IB0.5/topDown-25Hz.mat'))
calcPowerSpec;
powerRS25Hz=latePowerRS;
powerIB25Hz=latePowerIB;

pRSb1_25=powerPeakTest(powerRSpre,powerRS25Hz,minBeta1index,maxBeta1index)
pIBb1_25=powerPeakTest(powerIBpre,powerIB25Hz,minBeta1index,maxBeta1index)

pRSb2_25=powerPeakTest(powerRSpre,powerRS25Hz,minBeta2index,maxBeta2index)
pIBb2_25=powerPeakTest(powerIBpre,powerIB25Hz,minBeta2index,maxBeta2index)

meanDuringPowerRS25Hz=meanDuringPowerRS;
devDuringPowerRS25Hz=devDuringPowerRS;
meanLatePowerRS25Hz=meanLatePowerRS;
devLatePowerRS25Hz=devLatePowerRS;
meanDuringPowerIB25Hz=meanDuringPowerIB;
devDuringPowerIB25Hz=devDuringPowerIB;
meanLatePowerIB25Hz=meanLatePowerIB;
devLatePowerIB25Hz=devLatePowerIB;

filepath='topDown-40Hz-4pulses';
load(strcat(dataFolder,'/topDown-40Hz-4pulses.mat'))
%load(strcat(folder,'/topDown-40Hz RS0.3 IB0.3/topDown-40Hz.mat'))
%load(strcat(folder,'/topDown-40Hz RS0.1 IB0.5/topDown-40Hz.mat'))
calcPowerSpec;
powerRS40Hz=latePowerRS;
powerIB40Hz=latePowerIB;

pRSb1_40=powerPeakTest(powerRSpre,powerRS40Hz,minBeta1index,maxBeta1index)
pIBb1_40=powerPeakTest(powerIBpre,powerIB40Hz,minBeta1index,maxBeta1index)

pRSb2_40=powerPeakTest(powerRSpre,powerRS40Hz,minBeta2index,maxBeta2index)
pIBb2_40=powerPeakTest(powerIBpre,powerIB40Hz,minBeta2index,maxBeta2index)

%pRS15_40=powerPeakTest(powerRS15Hz,powerRS40Hz,minBeta1index,maxBeta1index)
%pIB15_40=powerPeakTest(powerIB15Hz,powerIB40Hz,minBeta1index,maxBeta1index)

meanDuringPowerRS40Hz=meanDuringPowerRS;
devDuringPowerRS40Hz=devDuringPowerRS;
meanLatePowerRS40Hz=meanLatePowerRS;
devLatePowerRS40Hz=devLatePowerRS;
meanDuringPowerIB40Hz=meanDuringPowerIB;
devDuringPowerIB40Hz=devDuringPowerIB;
meanLatePowerIB40Hz=meanLatePowerIB;
devLatePowerIB40Hz=devLatePowerIB;



filepath='topDown-singlePulse';
load(strcat(dataFolder,'/topDown-singlePulse.mat'))
%load(strcat(folder,'/topDown-40Hz RS0.3 IB0.3/topDown-40Hz.mat'))
%load(strcat(folder,'/topDown-40Hz RS0.1 IB0.5/topDown-40Hz.mat'))
calcPowerSpec;
powerRSsinglePulse=latePowerRS;
powerIBsinglePulse=latePowerIB;

pRSb1_single=powerPeakTest(powerRSnoInput,powerRSsinglePulse,minBeta1index,maxBeta1index)
pIBb1_single=powerPeakTest(powerIBnoInput,powerIBsinglePulse,minBeta1index,maxBeta1index)

pRSb2_single=powerPeakTest(powerRSnoInput,powerRSsinglePulse,minBeta2index,maxBeta2index)
pIBb2_single=powerPeakTest(powerIBnoInput,powerIBsinglePulse,minBeta2index,maxBeta2index)

meanDuringPowerRSsinglePulse=meanDuringPowerRS;
devDuringPowerRSsinglePulse=devDuringPowerRS;
meanLatePowerRSsinglePulse=meanLatePowerRS;
devLatePowerRSsinglePulse=devLatePowerRS;
meanDuringPowerIBsinglePulse=meanDuringPowerIB;
devDuringPowerIBsinglePulse=devDuringPowerIB;
meanLatePowerIBsinglePulse=meanLatePowerIB;
devLatePowerIBsinglePulse=devLatePowerIB;



peakb1RSnoInput=mean(max(powerRSnoInput(:,minBeta1index:maxBeta1index),[],2));
peakb1RSpre=mean(max(powerRSpre(:,minBeta1index:maxBeta1index),[],2));
peakb1RS15Hz=mean(max(powerRS15Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1RS25Hz=mean(max(powerRS25Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1RS40Hz=mean(max(powerRS40Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1RSsinglePulse=mean(max(powerRSsinglePulse(:,minBeta1index:maxBeta1index),[],2));

peakb1IBnoInput=mean(max(powerIBnoInput(:,minBeta1index:maxBeta1index),[],2));
peakb1IBpre=mean(max(powerIBpre(:,minBeta1index:maxBeta1index),[],2));
peakb1IB15Hz=mean(max(powerIB15Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1IB25Hz=mean(max(powerIB25Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1IB40Hz=mean(max(powerIB40Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1IBsinglePulse=mean(max(powerIBsinglePulse(:,minBeta1index:maxBeta1index),[],2));

peakb2RSnoInput=mean(max(powerRSnoInput(:,minBeta2index:maxBeta2index),[],2));
peakb2RSpre=mean(max(powerRSpre(:,minBeta2index:maxBeta2index),[],2));
peakb2RS15Hz=mean(max(powerRS15Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2RS25Hz=mean(max(powerRS25Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2RS40Hz=mean(max(powerRS40Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2RSsinglePulse=mean(max(powerRSsinglePulse(:,minBeta2index:maxBeta2index),[],2));

peakb2IBnoInput=mean(max(powerIBnoInput(:,minBeta2index:maxBeta2index),[],2));
peakb2IBpre=mean(max(powerIBpre(:,minBeta2index:maxBeta2index),[],2));
peakb2IB15Hz=mean(max(powerIB15Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2IB25Hz=mean(max(powerIB25Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2IB40Hz=mean(max(powerIB40Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2IBsinglePulse=mean(max(powerIBsinglePulse(:,minBeta2index:maxBeta2index),[],2));

incb1RS15Hz=(peakb1RS15Hz-peakb1RSpre)/peakb1RSpre
incb1RS25Hz=(peakb1RS25Hz-peakb1RSpre)/peakb1RSpre
incb1RS40Hz=(peakb1RS40Hz-peakb1RSpre)/peakb1RSpre
incb1RSsinglePulse=(peakb1RSsinglePulse-peakb1RSpre)/peakb1RSpre

incb1IB15Hz=(peakb1IB15Hz-peakb1IBpre)/peakb1IBpre
incb1IB25Hz=(peakb1IB25Hz-peakb1IBpre)/peakb1IBpre
incb1IB40Hz=(peakb1IB40Hz-peakb1IBpre)/peakb1IBpre
incb1IBsinglePulse=(peakb1IBsinglePulse-peakb1IBpre)/peakb1IBpre

incb2RS15Hz=(peakb2RS15Hz-peakb2RSpre)/peakb2RSpre
incb2RS25Hz=(peakb2RS25Hz-peakb2RSpre)/peakb2RSpre
incb2RS40Hz=(peakb2RS40Hz-peakb2RSpre)/peakb2RSpre
incb2RSsinglePulse=(peakb2RSsinglePulse-peakb2RSpre)/peakb2RSpre

incb2IB15Hz=(peakb2IB15Hz-peakb2IBpre)/peakb2IBpre
incb2IB25Hz=(peakb2IB25Hz-peakb2IBpre)/peakb2IBpre
incb2IB40Hz=(peakb2IB40Hz-peakb2IBpre)/peakb2IBpre
incb2IBsinglePulse=(peakb2IBsinglePulse-peakb2IBpre)/peakb2IBpre


hStacked=figure(11);
clf
%subplot(1,2,1)
hold on
%plot(freqAxis,meanLatePowerRSnoInput(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanPowerRSpre(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerRS15Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerRS25Hz(1:length(freqAxis)),'LineWidth',2,'Color',[0.9 0.9 0])
plot(freqAxis,meanLatePowerRS40Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerRSsinglePulse(1:length(freqAxis)),'LineWidth',2)
hold off
ax=gca;
ax.Title.String='RS';
%ax.XLabel.String='Frequency (Hz)';
ax.YLabel.String='Power (AU)';
ax.FontSize=22;
ax.FontWeight='bold';
ax.XTick=[0 20 40];
ax.XTickLabel={'0','20','40 Hz'};
ax.YLim(1)=0;
leg=legend('Control    ','15 Hz      ','25 Hz      ','40 Hz      ','Single Pulse');
leg.Box='Off';
leg.Location='eastoutside';
% subplot(1,2,2)

hStackedB=figure(12);
clf
hold on
%plot(freqAxis,meanLatePowerIBnoInput(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanPowerIBpre(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerIB15Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerIB25Hz(1:length(freqAxis)),'LineWidth',2,'Color',[0.9 0.9 0])
plot(freqAxis,meanLatePowerIB40Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerIBsinglePulse(1:length(freqAxis)),'LineWidth',2)
hold off
ax=gca;
ax.Title.String='IB';
ax.XTick=[0 20 40];
ax.XTickLabel={'0','20','40 Hz'};
leg=legend('Control    ','15 Hz      ','25 Hz      ','40 Hz      ','Single Pulse');
leg.Box='Off';
leg.Location='eastoutside';
leg.Visible='Off';
%ax.XLabel.String='Frequency (Hz)';
ax.YLabel.String='Power (AU)';
ax.FontSize=22;
ax.FontWeight='bold';
ax.YLim(1)=0;


if saveOutput
    fullFilepathPowerSpec=strcat(folder,'/topDown-powerSpecSummaryA-Supp');
    fullFilepathPowerSpecB=strcat(folder,'/topDown-powerSpecSummaryB-Supp');
    fullFilepathPowerSpecDuring=strcat(folder,'/topDown-powerSpecSummaryDuringA-Supp');
    fullFilepathPowerSpecDuringB=strcat(folder,'/topDown-powerSpecSummaryDuringB-Supp');
    
    hStacked.PaperUnits='inches';
    hStackedB.PaperUnits='inches';
    hStackedDuring.PaperUnits='inches';
    hStackedDuringB.PaperUnits='inches';
    hStacked.PaperPosition=[0 0 10 4];
    hStackedB.PaperPosition=[0 0 10 4];
    hStackedDuring.PaperPosition=[0 0 10 4];
    hStackedDuringB.PaperPosition=[0 0 10 4];
    
    saveas(hStacked,fullFilepathPowerSpec,'fig');
    saveas(hStacked,fullFilepathPowerSpec,'png');
    saveas(hStacked,fullFilepathPowerSpec,'emf');
    saveas(hStackedB,fullFilepathPowerSpecB,'fig');
    saveas(hStackedB,fullFilepathPowerSpecB,'png');
    saveas(hStackedB,fullFilepathPowerSpecB,'emf');
%     saveas(hStackedDuring,fullFilepathPowerSpecDuring,'fig');
%     saveas(hStackedDuring,fullFilepathPowerSpecDuring,'png');
%     saveas(hStackedDuring,fullFilepathPowerSpecDuring,'emf');
%     saveas(hStackedDuringB,fullFilepathPowerSpecDuringB,'fig');
%     saveas(hStackedDuringB,fullFilepathPowerSpecDuringB,'png');
%     saveas(hStackedDuringB,fullFilepathPowerSpecDuringB,'emf');
end