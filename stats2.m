numSims=10;

hRS=figure(1);
clf;
hold on
hIB=figure(2);
clf
hold on
lala=figure(11);
clf
hold on
maxRSbar=0;
maxIBbar=0;
for sim=1:numSims
    sim
    networkSim;
    figure(1)
    subplot(10,1,sim)
    freqs=absTimeHist(fullV(RS,:),largeDt);
    maxRSbar=max(maxRSbar,max(freqs));
    RSaxes(sim)=gca;
    ax=gca;
    ax.XLim=[0 steps*largeDt];
    ax.XAxis.Visible='off';
    ax.YAxis.Visible='off';
    ax.Position(4)=0.06;
%     ax.YLabel.String=sim;
%     ax.YLabel.Rotation=0;
%     ax.YLabel.Visible='on';
    drawnow;
    if sim==numSims
        ax.XAxis.Visible='on';
        ax.XAxis.FontWeight='bold';
    end
    figure(2)
    subplot(10,1,sim)
    freqs=absTimeHist(fullV(IBaxon,:),largeDt);
    maxIBbar=max(maxIBbar,max(freqs));
    IBaxes(sim)=gca;
    ax=gca;
    ax.XLim=[0 steps*largeDt];
    ax.XAxis.Visible='off';
    ax.YAxis.Visible='off';
    ax.Position(4)=0.06;
    if sim==numSims
        ax.XAxis.Visible='on';
        ax.XAxis.FontWeight='bold';
    end
    drawnow;
    figure(10+sim)
    clf
    rastergram
    drawnow;
end

for sim=1:numSims
    RSaxes(sim).YLim=[0 maxRSbar];
    IBaxes(sim).YLim=[0 maxIBbar];
end

fullFilepathRS=strcat(folder,'/',filepath,'-RS');
fullFilepathIB=strcat(folder,'/',filepath,'-IB');
fullFilepathRastergram=strcat(folder,'/',filepath,'-rastergram');
if saveRast
    saveas(hRS,fullFilepathRS,'fig');
    saveas(hRS,fullFilepathRS,'png');
    saveas(hIB,fullFilepathIB,'fig');
    saveas(hIB,fullFilepathIB,'png');
    saveas(lala,fullFilepathRastergram,'fig');
    saveas(lala,fullFilepathRastergram,'png');
%    save(strcat(fullFilepath,'.mat'),'relativeMeanFreqs','relativeDevFreqs')
end

%save('parameters.mat','')
