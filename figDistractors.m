simTurnOffBetaRSstats;
probaOffRS=probaOff;
ampsRS=amps;
simTurnOffBetaIBstats;
probaOffIB=probaOff;
ampsIB=amps;

if max(abs(ampsRS-ampsIB))>0
    warning('Amplitudes different for RS and IB distractors')
end

h=figure(3);
clf
ax=gca;
hold on
plot(ampsRS,probaOffRS,'LineWidth',2','Color','b')
plot(ampsIB,probaOffIB,'LineWidth',2','Color','r')
hold off
ax.FontWeight='bold';
ax.FontSize=14;
ax.XLabel.String='Inhibitory pulse amplitude';
ax.YLabel.String='Turn off probability';
legend(ax,'RS','IB');

filepath='turnOffBeta-probaGraph-both';

fullFilepath=strcat(folder,'/',filepath);
if saveOutput
    saveas(h,fullFilepath,'fig');
    saveas(h,fullFilepath,'png');
    save(strcat(fullFilepath,'.mat'),'ampsRS','ampsIB','probaOffRS','probaOffIB')
end

% defaultParams; % call first to set parameters not set below
% 
% saveOutput=true;
% 
% numSims=10; % per amplitude value
% 
% amps=[0.01:0.05:1.5];
% numAmps=length(amps);
% 
% probaOffRS=zeros(numAmps,1);
% probaOffIB=zeros(numAmps,1);
% 
% turnOffBeta=1;
% turnOffPulseLength=120;
% 
% turnOffTarget='RS';
% 
% for aa=1:numAmps
%     
%     turnOffAmp=amps(aa)
%     numOffs=0;
%     turnOffTarget='RS';
%     for sim=1:numSims
%         sim
%         networkSim;
%         rastFig=figure(1);
%         clf
%         hold on
%         rastergram;
%         hold off
%         drawnow;
%         turnOffAmp
%         numOffs=numOffs+turnedOff(fullV,150,largeDt)
%     end
%     probaOffRS(aa)=numOffs/numSims
% end
% 
% h=figure(2);
% ax=gca;
% plot(amps,probaOff,'LineWidth',2','Color','b')
% ax.FontWeight='bold';
% ax.FontSize=14;
% ax.XLabel.String='Inhibitory pulse amplitude';
% ax.YLabel.String='Turn off probability';
% 
% fullFilepath=strcat(folder,'/',filepath);
% if saveOutput
%     saveas(h,fullFilepath,'fig');
%     saveas(h,fullFilepath,'png');
%     save(strcat(fullFilepath,'.mat'),'amps','probaOff')
% end