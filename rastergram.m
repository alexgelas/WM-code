oldDt=largeDt*saveStep;
newDt=oldDt;
%ratio=newDt/oldDt;
spikes=findSpikes(fullV,oldDt,newDt);

%inputSpikes=findSpikes(fullInputV(6,:),oldDt,newDt,0);

rastFig=gcf;
clf
hold on

cmap=colormap(jet);

colors=zeros(numColumns,3);
for jj=1:8
    colors(jj,:)=cmap(8*jj,:);
end
% colors(1,:)=cmap(64)
% colors(2,:)=[1 0 0];
% colors(3,:)=[0 1 0];
% colors(4,:)=[1 0 1];
% colors(5,:)=[0.5 0 1];
% colors(6,:)=[1 0.5 0];
% colors(7,:)=[0.5 1 0];
% colors(8,:)=[1 0 0.5];

colors(9,:)=[0 0.5 0.5]; % not used
colors(10,:)=[1 0.5 0.5]; % not used

%numCellsShown=numRS1+numFS1+numLTS1+numIB1+numRS2+numFS2+numLTS2+numIB2;

for col=1:numColumns
    for i=1:colNumRS
        cell=RS(col,i);
        spikeTimes=find(spikes(cell,:));
        %inputSpikeTimes=find(inputSpikes(cell,:));
        plot(spikeTimes*newDt,(numColumns*(colNumFS+colNumLTS+colNumIB)+(numColumns-col+1)*colNumRS-i)*ones(length(spikeTimes),1),'.','Color',colors(col,:));
    end
    for i=1:colNumFS
        cell=FS(col,i);
        spikeTimes=find(spikes(cell,:));
        %inputSpikeTimes=find(inputSpikes(cell,:));
        plot(spikeTimes*newDt,(numColumns*(colNumLTS+colNumIB)+(numColumns-col+1)*colNumFS-i)*ones(length(spikeTimes),1),'.','Color',colors(col,:));
    end
    for i=1:colNumLTS
        cell=LTS(col,i);
        spikeTimes=find(spikes(cell,:));
        %inputSpikeTimes=find(inputSpikes(cell,:));
        plot(spikeTimes*newDt,(numColumns*(colNumIB)+(numColumns-col+1)*colNumLTS-i)*ones(length(spikeTimes),1),'.','Color',colors(col,:));
    end
    for i=1:colNumIB
        cell=IBaxon(col,i);
        spikeTimes=find(spikes(cell,:));
        %inputSpikeTimes=find(inputSpikes(cell,:));
        plot(spikeTimes*newDt,((numColumns-col+1)*colNumIB-i)*ones(length(spikeTimes),1),'.','Color',colors(col,:));
    end
end

inputHeight=numColumns*numCellsBase/2;

inputColor=[1 0 0];
if numColumns>1
    inputColor=[0 0 0];
end

stepsPlot=size(fullV,2);

%if displayInputGamma==-1
%    plot((1:stepsPlot)*dt,fullGammaInputS*inputHeight+numColumns*(colNumRS+colNumFS+colNumLTS+colNumIB+colNumDeepLTS)+1,'lineWidth',2,'Color',inputColor);
%elseif...
if displayInputGamma>0
    plot((1:stepsPlot)*largeDt,fullSInput(displayInputGamma,:)*inputHeight+numColumns*(colNumRS+colNumFS+colNumLTS+colNumIB)+1,'lineWidth',2,'Color',inputColor);
elseif displayInputGamma2>0
    plot((1:stepsPlot)*largeDt,fullSInput(displayInputGamma2,:)*inputHeight+numColumns*(colNumRS+colNumFS+colNumLTS+colNumIB)+1,'lineWidth',2,'Color',inputColor);
end

if displayInputBeta>0
    plot((1:stepsPlot)*largeDt,fullSInput(displayInputBeta,:)*inputHeight-inputHeight-1,'lineWidth',2,'Color',inputColor);
end

if displayInputTonicIB>0
    plot((1:stepsPlot)*largeDt,fullSInput(displayInputTonicIB,:)*inputHeight-inputHeight-1,'lineWidth',2,'Color',inputColor);
end

%if displayInputTonicExcIB>0
%    plot((1:stepsPlot)*largeDt,fullSInput(displayInputTonicExcIB,:)*inputHeight-inputHeight-1,'lineWidth',2,'Color',inputColor);
%end

if displayInputTonicSI>0
    plot((1:stepsPlot)*largeDt,fullSInput(displayInputTonicSI,:)*inputHeight-inputHeight-1,'lineWidth',2,'Color',inputColor);
end
ax=gca;
box off;
ax.YTick=[];
ax.FontWeight='bold';
ax.TickLength=[0 0];
%%ax.Visible='Off';
ax.YColor='white';
ax.FontSize=14;
%ax.FontColor='black';
%set(gca,'YTick',[floor(numColumns*colNumIB/2) floor(numColumns*(colNumIB+colNumLTS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS+colNumRS/2))])
ax.YTick=[floor(numColumns*colNumIB/2) floor(numColumns*(colNumIB+colNumLTS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS/2)) floor(numColumns*(colNumIB+colNumLTS+colNumFS+colNumRS/2))];
ax.YTickLabel=['\fontsize{20}\color{black}IB '; '\fontsize{20}\color{black}SI '; '\fontsize{20}\color{black}FS '; '\fontsize{20}\color{black}RS '];

%set(gca,'YTickLabel',['\color{black}IB '; '\color{black}SI '; '\color{black}FS '; '\color{black}RS '],'FontWeight','b','FontSize',20)
axis([0 min(steps*largeDt, 1200) -1-1.3*(inputHeight)*(displayInputBeta+displayInputTonicIB+displayInputTonicSI>0) numColumns*(colNumRS+colNumFS+colNumLTS+colNumIB)+1.3*(inputHeight)*((displayInputGamma+displayInputGamma2)>0)])
%axis([500 1000 1 numRS+numFS+numLTS+numIB])

% if numColumns>1
%     for col=1:numColumns-1
%         lineX=[0 size(spikes,2)*newDt];
%         lineY=[col*colNumIB col*colNumIB];
%         line(lineX,lineY,'Color','black','LineWidth',0.2)
%         
%         lineX=[0 size(spikes,2)*newDt];
%         lineY=[numColumns*colNumIB+col*colNumLTS numColumns*colNumIB+col*colNumLTS];
%         line(lineX,lineY,'Color','black','LineWidth',0.2)
%         
%         lineX=[0 size(spikes,2)*newDt];
%         lineY=[numColumns*(colNumIB+colNumLTS)+col*colNumFS numColumns*(colNumIB+colNumLTS)+col*colNumFS];
%         line(lineX,lineY,'Color','black','LineWidth',0.2)
%         
%         lineX=[0 size(spikes,2)*newDt];
%         lineY=[numColumns*(colNumIB+colNumLTS+colNumFS)+col*colNumRS numColumns*(colNumIB+colNumLTS+colNumFS)+col*colNumRS];
%         line(lineX,lineY,'Color','black','LineWidth',0.2)
%     end
% end

lineX=[0 size(spikes,2)*newDt];
lineY=[0 0];
line(lineX,lineY,'Color','black','LineWidth',0.5)

lineX=[0 size(spikes,2)*newDt];
lineY=[numColumns*colNumIB numColumns*colNumIB];
line(lineX,lineY,'Color','black','LineWidth',0.5)

lineX=[0 size(spikes,2)*newDt];
lineY=[numColumns*(colNumLTS+colNumIB) numColumns*(colNumLTS+colNumIB)];
line(lineX,lineY,'Color','black','LineWidth',0.5)

lineX=[0 size(spikes,2)*newDt];
lineY=[numColumns*(colNumFS+colNumLTS+colNumIB) numColumns*(colNumFS+colNumLTS+colNumIB)];
line(lineX,lineY,'Color','black','LineWidth',0.5)

lineX=[0 size(spikes,2)*newDt];
lineY=[numColumns*(colNumRS+colNumFS+colNumLTS+colNumIB) numColumns*(colNumRS+colNumFS+colNumLTS+colNumIB)];
line(lineX,lineY,'Color','black','LineWidth',0.5)

ax=gca;
ax.XTick=[0 400 800 1200];
ax.XTickLabel={'0', '0.4' , '0.8', '1.2 s'};
title(heading,'FontSize',26);
if saveOutput
    saveRastergram(folder,filepath,rastFig)
end

%fullFilepathRaster=strcat(folder,'/',filepath,'-rastergram');
% if saveOutput
%     saveRastergram(folder,filepath,rastFig)
%     rastFig.Units='inches';
%     rastFig.Position=[0 0 6 5];
%     saveas(rastFig,fullFilepathRaster,'fig');
%     saveas(rastFig,fullFilepathRaster,'png');
% end