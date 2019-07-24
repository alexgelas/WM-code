filepath='turnOffBeta-RS';
saveOutput=true;

defaultParams; % call first to set parameters not set below

%numCellsBase=5;

turnOffBeta=1;
inhibitoryPulse1Start=500;
inhibitoryPulse1Length=120;
inhibitoryPulse1Length=200; % test
turnOffTarget='RS';

numSims=10; % per amplitude value

amps=0.1:0.2:1.5;
%amps=0.8;
numAmps=length(amps);

probaOff=zeros(numAmps,1);

for aa=1:numAmps
    turnOffAmp=amps(aa)
    numOffs=0;
    for sim=1:numSims
        sim
        networkSim;
        rastFig=figure(1);
        clf
        hold on
        rastergram;
        hold off
        drawnow;
        turnOffAmp
        numOffs=numOffs+turnedOff(fullV,150,largeDt)
    end
    probaOff(aa)=numOffs/numSims
end

h=figure(2);
ax=gca;
plot(amps,probaOff,'LineWidth',2','Color','b')
ax.FontWeight='bold';
ax.FontSize=14;
ax.XLabel.String='Inhibitory pulse amplitude';
ax.YLabel.String='Turn off probability';

fullFilepath=strcat(folder,'/',filepath,'-probaGraph');
if saveOutput
    saveas(h,fullFilepath,'fig');
    saveas(h,fullFilepath,'png');
    save(strcat(fullFilepath,'.mat'),'amps','probaOff')
end