% Run after onlyStatsTopDownNewSupp
labels={'Control','   15Hz','   25Hz','   40Hz','   80Hz',' Single'};
h(1)=figure(36);
clf
boxplot([peaksb1RScontrol peaksb1RS],'PlotStyle','compact','Labels',{'','','','','',''},'Colors',[0 0 0],'jitter',0.1)
hold on
boxplot([peaksb1IBcontrol peaksb1IB],'PlotStyle','compact','Labels',{'','','','','',''},'Colors',[0 0 1],'jitter',0.1,'Positions',(1.2:1:6.2))
plot(0,0,'black','LineWidth',2)
plot(0,0,'blue','LineWidth',2)
hold off
ax(1)=gca;
ax(1).Title.String='beta1 peak power';
legend('RS','IB','Location','eastoutside')

h(2)=figure(37);
boxplot([peaksb2RScontrol peaksb2RS],'PlotStyle','compact','Labels',{'','','','','',''},'Colors',[0 0 0],'jitter',0.1)
hold on
boxplot([peaksb1IBcontrol peaksb1IB],'PlotStyle','compact','Labels',{'','','','','',''},'Colors',[0 0 1],'jitter',0.1,'Positions',(1.2:1:6.2))
plot(0,0,'black','LineWidth',2)
plot(0,0,'blue','LineWidth',2)
hold off
ax(2)=gca;
ax(2).Title.String='beta2 peak power';
legend('RS','IB','Location','eastoutside')

%ax(1).YLabel.String='Power (AU)';
%ax(2).XTickLabels=labels;
%ax(2).XTickLabelRotation=90;
for i=1:2
    ax(i).YLabel.String='Power (AU)';
    ax(i).XTick=1:8;
    %ax.XTickLabel={'0','20','40 Hz'};
    ax(i).YLim(1)=0;
    ax(i).FontSize=20;
    ax(i).FontWeight='bold';
    ax(i).XTickLabels=labels;
    ax(i).XTickLabelRotation=90;
end

fullFilepathTemp={strcat(folder,'/topDown-bplots-b1'),strcat(folder,'/topDown-supp-bplots-b2')};

if saveOutput
    h(1).PaperUnits='inches';
    h(2).PaperUnits='inches';
    h(1).PaperPosition=[0 0 6 3]; % 4.7
    h(2).PaperPosition=[0 0 6 3]; % 3.6
    for i=1:2
       %h(i).PaperUnits='inches';
       %h(i).PaperPosition=[0 0 4 4];
       tempString=fullFilepathTemp(i);
       set(h(i),'PaperSize',[h(i).PaperPosition(3), h(i).PaperPosition(4)]);
    end
end
print(h(1),strcat(folder,'/topDown-supp-bplots-b1'),'-dpdf','-r0')
print(h(2),strcat(folder,'/topDown-supp-bplots-b2'),'-dpdf','-r0')
       