defaultParams;
numSims=20;
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

fStep=1000/(2*autoCorrStep*(numCorrSteps-1));
% fMax=1000/(2*autoCorrStep);
fMax=50; % June 27th 2018

freqAxis=0:fStep:fMax;

minBeta1index=floor(12/fStep);
maxBeta1index=floor(20/fStep);

minBeta2index=floor(20/fStep);
maxBeta2index=floor(30/fStep);

earlyPowerRS=zeros(numSims,numCorrSteps);
latePowerRS=zeros(numSims,numCorrSteps);
earlyPowerIB=zeros(numSims,numCorrSteps);
latePowerIB=zeros(numSims,numCorrSteps);

usePrestimulus=0;
loadControl; % Load data and calculate stuff for control case

numCases=5;
powerRS=zeros(numSims,numCorrSteps,numCases);
powerIB=zeros(numSims,numCorrSteps,numCases);

meanDuringPowerRSall=zeros(numCorrSteps,numCases);
meanDuringPowerIBall=zeros(numCorrSteps,numCases);
devDuringPowerRSall=zeros(numCorrSteps,numCases);
devDuringPowerIBall=zeros(numCorrSteps,numCases);
meanLatePowerRSall=zeros(numCorrSteps,numCases);
meanLatePowerIBall=zeros(numCorrSteps,numCases);
devLatePowerRSall=zeros(numCorrSteps,numCases);
devLatePowerIBall=zeros(numCorrSteps,numCases);

tt=1;
load(strcat(dataFolder,'/topDown-15Hz-2pulses.mat'))
loadDataAux
tt=2;
load(strcat(dataFolder,'/topDown-25Hz-3pulses.mat'))
loadDataAux
tt=3;
load(strcat(dataFolder,'/topDown-40Hz-4pulses.mat'))
loadDataAux
tt=4;
load(strcat(dataFolder,'/topDown-80Hz-short.mat'))
loadDataAux
tt=5;
load(strcat(dataFolder,'/topDown-singlePulse.mat'))
loadDataAux

pRSb1=zeros(numCases,1);
pIBb1=zeros(numCases,1);
pRSb2=zeros(numCases,1);
pIBb2=zeros(numCases,1);

peaksb1RS=zeros(numSims,numCases);
peaksb1IB=zeros(numSims,numCases);
peaksb2RS=zeros(numSims,numCases);
peaksb2IB=zeros(numSims,numCases);

for i=1:numCases
    pRSb1(i)=powerPeakTest(powerRScontrol,powerRS(:,:,i),minBeta1index,maxBeta1index);
    pIBb1(i)=powerPeakTest(powerIBcontrol,powerIB(:,:,i),minBeta1index,maxBeta1index);
    pRSb2(i)=powerPeakTest(powerRScontrol,powerRS(:,:,i),minBeta2index,maxBeta2index);
    pIBb2(i)=powerPeakTest(powerIBcontrol,powerIB(:,:,i),minBeta2index,maxBeta2index);
    
    peaksb1RS(:,i)=max(powerRS(:,minBeta1index:maxBeta1index,i),[],2);
    peaksb1IB(:,i)=max(powerIB(:,minBeta1index:maxBeta1index,i),[],2);
    peaksb2RS(:,i)=max(powerRS(:,minBeta2index:maxBeta2index,i),[],2);
    peaksb2IB(:,i)=max(powerIB(:,minBeta2index:maxBeta2index,i),[],2);
end

meanPeakb1RS=mean(peaksb1RS);
meanPeakb1IB=mean(peaksb1IB);
meanPeakb2RS=mean(peaksb2RS);
meanPeakb2IB=mean(peaksb2IB);

devPeakb1RS=std(peaksb1RS);
devPeakb1IB=std(peaksb1IB);
devPeakb2RS=std(peaksb2RS);
devPeakb2IB=std(peaksb2IB);

incb1RS=(meanPeakb1RS'-meanPeakb1RScontrol)/meanPeakb1RScontrol;
incb1IB=(meanPeakb1IB'-meanPeakb1IBcontrol)/meanPeakb1IBcontrol;
incb2RS=(meanPeakb2RS'-meanPeakb2RScontrol)/meanPeakb2RScontrol;
incb2IB=(meanPeakb2IB'-meanPeakb2IBcontrol)/meanPeakb2IBcontrol;

% pRSb1noInputToPre=powerPeakTest(powerRSpre,powerRSnoInput,minBeta1index,maxBeta1index)
% pIBb1noInputToPre=powerPeakTest(powerIBpre,powerIBnoInput,minBeta1index,maxBeta1index)
% pRSb2noInputToPre=powerPeakTest(powerRSpre,powerRSnoInput,minBeta2index,maxBeta2index)
% pIBb2noInputToPre=powerPeakTest(powerIBpre,powerIBnoInput,minBeta2index,maxBeta2index)


pRSb1
pRSb2
pIBb1
pIBb2

incb1RS
incb2RS
incb1IB
incb2IB

if saveOutput
    fullFilepathExcel=strcat(folder,'/topDown-stats-Supp.xls');
    T=table(pRSb1,pIBb1,pRSb2,pIBb2,incb1RS,incb1IB,incb2RS,incb2IB);
    writetable(T,fullFilepathExcel);
    fullFilepathAnalysisResults=strcat(folder,'/topDown-analysisResults-Supp');
    save(strcat(fullFilepathAnalysisResults,'.mat'),'powerRS','powerIB','meanLatePowerRSall','meanLatePowerIBall','devLatePowerRSall','devLatePowerIBall',...
        'powerRScontrol','powerIBcontrol','meanPowerRScontrol','devPowerRScontrol','meanPowerIBcontrol','devPowerIBcontrol',...
        'peaksb1RScontrol','peaksb1IBcontrol','peaksb2RScontrol','peaksb2IBcontrol',...
        'meanPeakb1RScontrol','meanPeakb1IBcontrol','meanPeakb2RScontrol','meanPeakb2IBcontrol',...
        'devPeakb1RScontrol','devPeakb1IBcontrol','devPeakb2RScontrol','devPeakb2IBcontrol')
end

hStacked=figure(11);
clf
%subplot(1,2,1)
hold on
for i=1:numCases
    plot(freqAxis,meanLatePowerRSall(1:length(freqAxis),i),'LineWidth',1)
end
plot(freqAxis,meanPowerRScontrol(1:length(freqAxis)),'LineWidth',1,'LineStyle','--','Color','black');
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
leg=legend('15 Hz  ','25 Hz  ','40 Hz  ','80 Hz  ','Single ','Control');
leg.Box='Off';
leg.Location='eastoutside';
% subplot(1,2,2)

hStackedB=figure(12);
clf
%subplot(1,2,1)
hold on
for i=1:numCases
    plot(freqAxis,meanLatePowerIBall(1:length(freqAxis),i),'LineWidth',1)
end
plot(freqAxis,meanPowerIBcontrol(1:length(freqAxis)),'LineWidth',1,'LineStyle','--','Color','black');
hold off

ax=gca;
ax.Title.String='IB';
ax.XTick=[0 20 40];
ax.XTickLabel={'0','20','40 Hz'};
leg=legend('15 Hz  ','25 Hz  ','40 Hz  ','80 Hz  ','Single ','Control');
leg.Box='Off';
leg.Location='eastoutside';
leg.Visible='On';
%ax.XLabel.String='Frequency (Hz)';
ax.YLabel.String='Power (AU)';
ax.FontSize=22;
ax.FontWeight='bold';
ax.YLim(1)=0;


if saveOutput
    fullFilepathPowerSpec=strcat(folder,'/topDown-powerSpecSummaryA-Supp');
    fullFilepathPowerSpecB=strcat(folder,'/topDown-powerSpecSummaryB-Supp');
        
    hStacked.PaperUnits = 'inches';
    %hStacked.PaperPosition = [0 0 6 3.5];
    hStacked.PaperPosition = [0 0 7 3];
    hStackedB.PaperUnits = 'inches';
    %hStackedB.PaperPosition = [0 0 6 3.5];
    hStackedB.PaperPosition = [0 0 7 3];
    
    saveas(hStacked,fullFilepathPowerSpec,'fig');
    saveas(hStacked,fullFilepathPowerSpec,'png');
    saveas(hStacked,fullFilepathPowerSpec,'emf');
    saveas(hStackedB,fullFilepathPowerSpecB,'fig');
    saveas(hStackedB,fullFilepathPowerSpecB,'png');
    saveas(hStackedB,fullFilepathPowerSpecB,'emf');
    
    set(hStacked,'PaperSize',[hStacked.PaperPosition(3), hStacked.PaperPosition(4)]);
    print(hStacked,fullFilepathPowerSpec,'-dpdf','-r0')
    set(hStackedB,'PaperSize',[hStackedB.PaperPosition(3), hStackedB.PaperPosition(4)]);
    print(hStackedB,fullFilepathPowerSpecB,'-dpdf','-r0')
end