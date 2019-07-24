function [ output_args ] = plotStats( xVals,means,devs,Ymax)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%numPlots=size(means,1);
hold on
plot(xVals,means,'LineWidth',2,'Color','black')
plot(xVals,means+devs,'LineWidth',1,'Color',[0.6 0.6 0.6])
plot(xVals,means-devs,'LineWidth',1,'Color',[0.6 0.6 0.6])
hold off
ax=gca;
ax.XTick=[-80 -40 0 40 80];
ax.XTickLabel={'-80', '-40', '0', '40', '80 ms'};
% if exist('Ymin','var')
%     ax.YLim(1)=Ymin;
% end
if exist('Ymax','var')
    ax.YLim(2)=Ymax;
end
ax.FontWeight='bold';
ax.FontSize=14;
end