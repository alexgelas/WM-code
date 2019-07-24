dataFolder='simData';
autoCorrMaxTime=1000;
%autoCorrStep=10;
autoCorrStep=1; % June 27th 2018
numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

numCellsBase=5;
numColumns=8;
cellNumbering;

topDownStart=600;
topDownDuration=150;

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

%filepath='manyColumns';
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


%filepath='topDown-8Hz';
load(strcat(dataFolder,'/topDown-8Hz.mat'))
%load(strcat(folder,'/topDown-8Hz RS0.3 IB0.3/topDown-8Hz.mat'))
%load(strcat(folder,'/topDown-8Hz RS0.1 IB0.5/topDown-8Hz.mat'))
calcPowerSpec;
powerRS8Hz=latePowerRS;
powerIB8Hz=latePowerIB;

meanDuringPowerRS8Hz=meanDuringPowerRS;
devDuringPowerRS8Hz=devDuringPowerRS;
meanLatePowerRS8Hz=meanLatePowerRS;
devLatePowerRS8Hz=devLatePowerRS;
meanDuringPowerIB8Hz=meanDuringPowerIB;
devDuringPowerIB8Hz=devDuringPowerIB;
meanLatePowerIB8Hz=meanLatePowerIB;
devLatePowerIB8Hz=devLatePowerIB;

pRSb1_8=powerPeakTest(powerRSpre,powerRS8Hz,minBeta1index,maxBeta1index)
pIBb1_8=powerPeakTest(powerIBpre,powerIB8Hz,minBeta1index,maxBeta1index)

pRSb2_8=powerPeakTest(powerRSpre,powerRS8Hz,minBeta2index,maxBeta2index)
pIBb2_8=powerPeakTest(powerIBpre,powerIB8Hz,minBeta2index,maxBeta2index)

% pRS=powerPeakTest(powerRSnoInput,powerRS8Hz,minBeta1index,maxBeta1index)
% pIB=powerPeakTest(powerIBnoInput,powerIB8Hz,minBeta1index,maxBeta1index)

%filepath='topDown-4Hz';
load(strcat(dataFolder,'/topDown-4Hz.mat'))
calcPowerSpec;
powerRS4Hz=latePowerRS;
powerIB4Hz=latePowerIB;

pRSb1_4=powerPeakTest(powerRSpre,powerRS4Hz,minBeta1index,maxBeta1index)
pIBb1_4=powerPeakTest(powerIBpre,powerIB4Hz,minBeta1index,maxBeta1index)

pRSb2_4=powerPeakTest(powerRSpre,powerRS4Hz,minBeta2index,maxBeta2index)
pIBb2_4=powerPeakTest(powerIBpre,powerIB4Hz,minBeta2index,maxBeta2index)

%pRS8_40=powerPeakTest(powerRS8Hz,powerRS40Hz,minBeta1index,maxBeta1index)
%pIB8_40=powerPeakTest(powerIB8Hz,powerIB40Hz,minBeta1index,maxBeta1index)

meanDuringPowerRS4Hz=meanDuringPowerRS;
devDuringPowerRS4Hz=devDuringPowerRS;
meanLatePowerRS4Hz=meanLatePowerRS;
devLatePowerRS4Hz=devLatePowerRS;
meanDuringPowerIB4Hz=meanDuringPowerIB;
devDuringPowerIB4Hz=devDuringPowerIB;
meanLatePowerIB4Hz=meanLatePowerIB;
devLatePowerIB4Hz=devLatePowerIB;


load(strcat(dataFolder,'/topDown-80Hz.mat'))
%load(strcat(folder,'/topDown-40Hz RS0.3 IB0.3/topDown-40Hz.mat'))
%load(strcat(folder,'/topDown-40Hz RS0.1 IB0.5/topDown-40Hz.mat'))
calcPowerSpec;
powerRS80Hz=latePowerRS;
powerIB80Hz=latePowerIB;

pRSb1_80=powerPeakTest(powerRSnoInput,powerRS80Hz,minBeta1index,maxBeta1index)
pIBb1_80=powerPeakTest(powerIBnoInput,powerIB80Hz,minBeta1index,maxBeta1index)

pRSb2_80=powerPeakTest(powerRSnoInput,powerRS80Hz,minBeta2index,maxBeta2index)
pIBb2_80=powerPeakTest(powerIBnoInput,powerIB80Hz,minBeta2index,maxBeta2index)

meanDuringPowerRS80Hz=meanDuringPowerRS;
devDuringPowerRS80Hz=devDuringPowerRS;
meanLatePowerRS80Hz=meanLatePowerRS;
devLatePowerRS80Hz=devLatePowerRS;
meanDuringPowerIB80Hz=meanDuringPowerIB;
devDuringPowerIB80Hz=devDuringPowerIB;
meanLatePowerIB80Hz=meanLatePowerIB;
devLatePowerIB80Hz=devLatePowerIB;

%filepath='topDown-tonic';
load(strcat(dataFolder,'/topDown-tonic.mat'))
%load(strcat(folder,'/topDown-25Hz RS0.3 IB0.3/topDown-25Hz.mat'))
%load(strcat(folder,'/topDown-25Hz RS0.1 IB0.5/topDown-25Hz.mat'))
calcPowerSpec;
powerRStonic=latePowerRS;
powerIBtonic=latePowerIB;

pRSb1_tonic=powerPeakTest(powerRSpre,powerRStonic,minBeta1index,maxBeta1index)
pIBb1_tonic=powerPeakTest(powerIBpre,powerIBtonic,minBeta1index,maxBeta1index)

pRSb2_tonic=powerPeakTest(powerRSpre,powerRStonic,minBeta2index,maxBeta2index)
pIBb2_tonic=powerPeakTest(powerIBpre,powerIBtonic,minBeta2index,maxBeta2index)

meanDuringPowerRStonic=meanDuringPowerRS;
devDuringPowerRStonic=devDuringPowerRS;
meanLatePowerRStonic=meanLatePowerRS;
devLatePowerRStonic=devLatePowerRS;
meanDuringPowerIBtonic=meanDuringPowerIB;
devDuringPowerIBtonic=devDuringPowerIB;
meanLatePowerIBtonic=meanLatePowerIB;
devLatePowerIBtonic=devLatePowerIB;

peakb1RSnoInput=mean(max(powerRSnoInput(:,minBeta1index:maxBeta1index),[],2));
peakb1RSpre=mean(max(powerRSpre(:,minBeta1index:maxBeta1index),[],2));
peakb1RS8Hz=mean(max(powerRS8Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1RS80Hz=mean(max(powerRS80Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1RS4Hz=mean(max(powerRS4Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1RStonic=mean(max(powerRStonic(:,minBeta1index:maxBeta1index),[],2));
% 
peakb1IBnoInput=mean(max(powerIBnoInput(:,minBeta1index:maxBeta1index),[],2));
peakb1IBpre=mean(max(powerIBpre(:,minBeta1index:maxBeta1index),[],2));
peakb1IB8Hz=mean(max(powerIB8Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1IB80Hz=mean(max(powerIB80Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1IB4Hz=mean(max(powerIB4Hz(:,minBeta1index:maxBeta1index),[],2));
peakb1IBtonic=mean(max(powerIBtonic(:,minBeta1index:maxBeta1index),[],2));
% 
peakb2RSnoInput=mean(max(powerRSnoInput(:,minBeta2index:maxBeta2index),[],2));
peakb2RSpre=mean(max(powerRSpre(:,minBeta2index:maxBeta2index),[],2));
peakb2RS8Hz=mean(max(powerRS8Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2RS80Hz=mean(max(powerRS80Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2RS4Hz=mean(max(powerRS4Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2RStonic=mean(max(powerRStonic(:,minBeta2index:maxBeta2index),[],2));

peakb2IBnoInput=mean(max(powerIBnoInput(:,minBeta2index:maxBeta2index),[],2));
peakb2IBpre=mean(max(powerIBpre(:,minBeta2index:maxBeta2index),[],2));
peakb2IB8Hz=mean(max(powerIB8Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2IB80Hz=mean(max(powerIB80Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2IB4Hz=mean(max(powerIB4Hz(:,minBeta2index:maxBeta2index),[],2));
peakb2IBtonic=mean(max(powerIBtonic(:,minBeta2index:maxBeta2index),[],2));

incb1RS8Hz=(peakb1RS8Hz-peakb1RSpre)/peakb1RSpre
incb1RS80Hz=(peakb1RS80Hz-peakb1RSpre)/peakb1RSpre
incb1RS4Hz=(peakb1RS4Hz-peakb1RSpre)/peakb1RSpre
incb1RStonic=(peakb1RStonic-peakb1RSpre)/peakb1RSpre

incb1IB8Hz=(peakb1IB8Hz-peakb1IBpre)/peakb1IBpre
incb1IB80Hz=(peakb1IB80Hz-peakb1IBpre)/peakb1IBpre
incb1IB4Hz=(peakb1IB4Hz-peakb1IBpre)/peakb1IBpre
incb1IBtonic=(peakb1IBtonic-peakb1IBpre)/peakb1IBpre

incb2RS8Hz=(peakb2RS8Hz-peakb2RSpre)/peakb2RSpre
incb2RS80Hz=(peakb2RS80Hz-peakb2RSpre)/peakb2RSpre
incb2RS4Hz=(peakb2RS4Hz-peakb2RSpre)/peakb2RSpre
incb2RStonic=(peakb2RStonic-peakb2RSpre)/peakb2RSpre

incb2IB8Hz=(peakb2IB8Hz-peakb2IBpre)/peakb2IBpre
incb2IB80Hz=(peakb2IB80Hz-peakb2IBpre)/peakb2IBpre
incb2IB4Hz=(peakb2IB4Hz-peakb2IBpre)/peakb2IBpre
incb2IBtonic=(peakb2IBtonic-peakb2IBpre)/peakb2IBpre

hStacked=figure(11);
clf
%subplot(1,2,1)
hold on
%plot(freqAxis,meanLatePowerRSnoInput(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanPowerRSpre(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerRS4Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerRS8Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerRS80Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerRStonic(1:length(freqAxis)),'LineWidth',2)
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
leg=legend('Control','4 Hz   ','8 Hz   ','80 Hz  ','Tonic  ');
leg.Box='Off';
leg.Location='eastoutside';
% subplot(1,2,2)

hStackedB=figure(12);
clf
hold on
%plot(freqAxis,meanLatePowerIBnoInput(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanPowerIBpre(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerIB4Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerIB8Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerIB80Hz(1:length(freqAxis)),'LineWidth',2)
plot(freqAxis,meanLatePowerIBtonic(1:length(freqAxis)),'LineWidth',2)
hold off
ax=gca;
ax.Title.String='IB';
ax.XTick=[0 20 40];
ax.XTickLabel={'0','20','40 Hz'};
leg=legend('Control','4 Hz   ','8 Hz   ','80 Hz  ','Tonic  ');
leg.Box='Off';
leg.Location='eastoutside';
leg.Visible='On';
%ax.XLabel.String='Frequency (Hz)';
ax.YLabel.String='Power (AU)';
ax.FontSize=22;
ax.FontWeight='bold';
ax.YLim(1)=0;


if saveOutput
    fullFilepathPowerSpec=strcat(folder,'/topDown-powerSpecSummaryA-Supp-new');
    fullFilepathPowerSpecB=strcat(folder,'/topDown-powerSpecSummaryB-Supp-new');
    fullFilepathPowerSpecDuring=strcat(folder,'/topDown-powerSpecSummaryDuringA-Supp-new');
    fullFilepathPowerSpecDuringB=strcat(folder,'/topDown-powerSpecSummaryDuringB-Supp-new');
    
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