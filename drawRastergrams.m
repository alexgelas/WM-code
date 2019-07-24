defaultParams;
cellNumbering;
folder='figuresSet9';
dataFolder='simData';
numSims=1;
steps=6000;
numColumns=8;
numCellsBase=5;
cellNumbering;

load(strcat(dataFolder,'/topDown-40Hz-mixedOnOff.mat'))
filepath='topDown-40Hz-mixedOnOff'
heading='';
showArrows=1;
arrowsPos=[600 623 651 677 702 729];
sim=1;
fullVtemp=fullVall(:,:,sim);
rastergram2;
ax.YLim(1)=ax.YLim(1)-30;
for i=1:8
    text(1205, (9-i)*20+110,int2str(i), 'clipping', 'off','FontSize',18,'FontWeight','bold');
end
saveRastergram(folder,filepath,rastFig)


load(strcat(dataFolder,'/manyColumns.mat'))
filepath='manyColumns'
heading='No input';
showArrows=0;
sim=1;
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-8Hz.mat'))
filepath='topDown-8Hz'
heading='8 Hz input';
showArrows=1;
arrowsPos=[600 720 832];
sim=5; %20
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-15Hz.mat'))
filepath='topDown-15Hz'
heading='15 Hz input';
showArrows=1;
arrowsPos=[600 670 735];
sim=7; %2
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-25Hz.mat'))
filepath='topDown-25Hz'
heading='25 Hz input';
showArrows=1;
arrowsPos=[600 640 680 723];
sim=16;
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-40Hz.mat'))
filepath='topDown-40Hz'
heading='40 Hz input';
showArrows=1;
arrowsPos=[600 626 649 675 702 729];
sim=9;
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-15Hz-2pulses.mat'))
filepath='topDown-15Hz-2pulses'
heading='15 Hz input';
showArrows=18;
arrowsPos=[600 672];
sim=7; %2
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-25Hz-3pulses.mat'))
filepath='topDown-25Hz-3pulses'
heading='25 Hz input';
showArrows=1;
arrowsPos=[600 637 678];
sim=7;
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-40Hz-4pulses.mat'))
filepath='topDown-40Hz-4pulses'
heading='40 Hz input';
showArrows=1;
arrowsPos=[600 627 653 678];
sim=9;
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-80Hz-short.mat'))
filepath='topDown-80Hz-short'
heading='80 Hz input';
showArrows=1;
arrowsPos=[600 613 627 638 650 662 675 688 700];
sim=3;
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-singlePulse.mat'))
filepath='topDown-singlePulse'
heading='Single pulse input';
showArrows=1;
arrowsPos=[600];
sim=13;
fullVtemp=fullVall(:,:,sim);
rastergram2;

load(strcat(dataFolder,'/topDown-tonic.mat'))
filepath='topDown-tonic'
heading='Tonic (square pulse) input';
showArrows=0;
%arrowsPos=[600 720 832];
sim=1; %20
fullVtemp=fullVall(:,:,sim);
rastergram2;

hold on
plot([0 600 600 750 750 1200],[-25 -25 -10 -10 -25 -25],'black','LineWidth',2)
ax.YLim(1)=ax.YLim(1)-30;
hold off
%text(50,-20,'IB tonic current','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)


defaultParams;
folder='figuresSet9';
dataFolder='simData';
numSims=10;
showArrows=0;
steps=5000;
numColumns=8;
numCellsBase=5;
cellNumbering;

load(strcat(dataFolder,'/onOffColumns.mat'))
filepath='onOffColumns'
heading='';
sim=1;
fullVtemp=fullV(:,:,sim); % saved as fullV, not fullVAll!
rastergram2;

defaultParams;
folder='figuresSet9';
dataFolder='simData';
numSims=10;
reduceRStonic=1;
showArrows=0;
steps=5000;
numColumns=1;
numCellsBase=20;
cellNumbering;

load(strcat(dataFolder,'/reduceRStonic.mat'))
filepath='reduceRStonic'
heading='';
sim=1;
fullVtemp=fullV(:,:,sim); % saved as fullV, not fullVAll!
rastergram2;

hold on
plot([0 300 800 1000],[-7 -7 -25 -25],'r','LineWidth',2)
ax.YLim(1)=ax.YLim(1)-30;
hold off
text(50,-20,'RS tonic current','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)


defaultParams;
folder='figuresSet9';
dataFolder='simData';
numSims=10;
showArrows=0;
steps=5000;
numColumns=1;
numCellsBase=20;
cellNumbering;

load(strcat(dataFolder,'/turnOffBeta-IB.mat'))
filepath='turnOffBeta-IB'
heading='';
sim=1;
fullVtemp=fullVall(:,:,sim);
rastergram2;

hold on
ax.YLim(1)=ax.YLim(1)-30;
tempX=[inf*ones(1,5000) 0:0.1:500];
tempY=-25+20*exp(-(tempX/150));
plot(0:0.1:1000,tempY,'r','LineWidth',2);
hold off
text(50,-15,'IPSC to IB cells','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)


load(strcat(dataFolder,'/turnOffBeta-IB-tempInput.mat'))
filepath='turnOffBeta-IB-tempInput'
heading='';
sim=1;
fullVtemp=fullVall(:,:,sim);
fullSInputTemp=fullSInputAll(:,:,sim);
rastergram2;

hold on
plot([0 1000],[-57 -57],'r','LineWidth',2)
%plot([0 1000],[143 143],'r','LineWidth',2)
inputSpikes=findSpikes(fullSInputTemp,oldDt,newDt,0.2);
inputSpikeTimes=find(inputSpikes(1,:));
for tt=inputSpikeTimes*largeDt
    plot([tt tt],[-57 -40],'r','LineWidth',2)
end
ax.YLim(1)=ax.YLim(1)-60;
ax.YLim(2)=ax.YLim(2)-13;
tempX=[inf*ones(1,5000) 0:0.1:500];
tempY=-25+20*exp(-(tempX/150));
plot(0:0.1:1000,tempY,'r','LineWidth',2);
%plot([0 1000],[-27 -27],'r','LineWidth',2)
hold off
%text(20,-40,{'RS subset ','40Hz input'},'FontSize',16,'FontWeight','bold')
%text(20,-40,'RS subset 40Hz input','FontSize',16,'FontWeight','bold')
text(100,-36,'RS subset','FontSize',16,'FontWeight','bold')
text(100,-47,'40Hz input','FontSize',16,'FontWeight','bold')

text(50,-15,'IPSC to IB cells','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)



load(strcat(dataFolder,'/turnOffBeta-IB-excIB.mat'))
filepath='turnOffBeta-IB-excIB'
heading='';
sim=1;
fullVtemp=fullVall(:,:,sim);
fullSInputTemp=fullSInputAll(:,:,sim);
rastergram2;

hold on
plot([0 50 50 1000],[-57 -57 -40 -40],'r','LineWidth',2)
ax.YLim(1)=ax.YLim(1)-60;
ax.YLim(2)=ax.YLim(2); % -13
tempX=[inf*ones(1,5000) 0:0.1:500];
tempY=-25+20*exp(-(tempX/150));
plot(0:0.1:1000,tempY,'r','LineWidth',2);
%plot([0 1000],[-27 -27],'r','LineWidth',2)
hold off
text(70,-50,'IB cells tonic drive','FontSize',16,'FontWeight','bold')

text(50,-15,'IPSC to IB cells','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)




load(strcat(dataFolder,'/turnOffBeta-RS.mat'))
filepath='turnOffBeta-RS'
heading='';
sim=1;
fullVtemp=fullVall(:,:,sim);
rastergram2;

hold on
ax.YLim(1)=ax.YLim(1)-30;
tempX=[inf*ones(1,5000) 0:0.1:500];
tempY=-25+20*exp(-(tempX/150));
plot(0:0.1:1000,tempY,'r','LineWidth',2);
hold off
text(50,-15,'IPSC to RS cells','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)


load(strcat(dataFolder,'/turnOffBeta-RS-tempInput.mat'))
filepath='turnOffBeta-RS-tempInput'
heading='';
sim=2;
fullVtemp=fullVall(:,:,sim);
fullSInputTemp=fullSInputAll(:,:,sim);
rastergram2;

hold on
plot([0 1000],[-57 -57],'r','LineWidth',2)
inputSpikes=findSpikes(fullSInputTemp,oldDt,newDt,0.2);
inputSpikeTimes=find(inputSpikes(1,:));
for tt=inputSpikeTimes*largeDt
    plot([tt tt],[-57 -40],'r','LineWidth',2)
end
ax.YLim(1)=ax.YLim(1)-60;
ax.YLim(2)=ax.YLim(2)-13;
tempX=[inf*ones(1,5000) 0:0.1:500];
tempY=-25+20*exp(-(tempX/150));
plot(0:0.1:1000,tempY,'r','LineWidth',2);
%plot([0 1000],[-27 -27],'r','LineWidth',2)
hold off
%text(20,-40,{'RS subset ','40Hz input'},'FontSize',16,'FontWeight','bold')
%text(20,-40,'RS subset 40Hz input','FontSize',16,'FontWeight','bold')
text(100,-36,'RS subset','FontSize',16,'FontWeight','bold')
text(100,-47,'40Hz input','FontSize',16,'FontWeight','bold')
text(50,-15,'IPSC to RS cells','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)


load(strcat(dataFolder,'/turnOffBeta-RS-excIB.mat'))
filepath='turnOffBeta-RS-excIB'
heading='';
sim=1;
fullVtemp=fullVall(:,:,sim);
fullSInputTemp=fullSInputAll(:,:,sim);
rastergram2;

hold on
plot([0 50 50 1000],[-57 -57 -40 -40],'r','LineWidth',2)
ax.YLim(1)=ax.YLim(1)-60;
ax.YLim(2)=ax.YLim(2);
tempX=[inf*ones(1,5000) 0:0.1:500];
tempY=-25+20*exp(-(tempX/150));
plot(0:0.1:1000,tempY,'r','LineWidth',2);
%plot([0 1000],[-27 -27],'r','LineWidth',2)
hold off
text(70,-50,'IB cells tonic drive','FontSize',16,'FontWeight','bold')

text(50,-15,'IPSC to RS cells','FontSize',16,'FontWeight','bold')
saveRastergram(folder,filepath,rastFig)
