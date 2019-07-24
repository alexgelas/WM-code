function h=statsHist(means,devs,minX,maxX,figureNum)

if ~exist('figureNum','var')
    figureNum = 21;
    h=figure(figureNum);
    clf;
else
    h=figure(figureNum);
end
hold on

% Draws a histogram with added error bars. Takes two vectors of same
% length ('means' and 'devs') containing the means and standard deviations
% of each of the bars, as well as the minimum and maximum value of the
% quuantity these correspond to. It produces a figure with length(means)
% bars, with the left side of the first bar at minX and the right side of
% the last one at maxX.

numBars=length(means);
if length(devs)~=numBars
    warning('First and second arguments not of same length.')
end
step=(maxX-minX)/numBars;

%total=sum(meanFreqs);

locations=minX+step/2:step:maxX;


%bar(locations,meanFreqs/total)
bar(locations,means)
% for i=1:numBars
%     xLeft=min+(i-1)*step;
%     area([xLeft xLeft xLeft+1 xLeft+1],[0 meanFreqs(i) meanFreqs(i) 0])
% end
halfErrorBarWidth=step*0.2;
for i=1:numBars
    xPos=minX+(i-0.5)*step;
    plot([xPos xPos],[means(i)-devs(i) means(i)+devs(i)],'Color','red','LineWidth',2)
    plot([xPos-halfErrorBarWidth xPos+halfErrorBarWidth],[means(i)-devs(i) means(i)-devs(i)],'Color','red','LineWidth',2)
    plot([xPos-halfErrorBarWidth xPos+halfErrorBarWidth],[means(i)+devs(i) means(i)+devs(i)],'Color','red','LineWidth',2)
end
%maxBar=max(meanFreqs+devFreqs);
%roundingStep=roundl(maxBar,'u',3)/10;
%add=ceil(20/maxBar)*maxBar/20;
%ymax=ceil(20*max(meanFreqs+devFreqs)/maxBar)*maxBar/20;
ymax=ceil(20*max(means+devs))/20;
axis([minX maxX 0 ymax])
%set(gca,'YTickLabel',[])
%set(gca,'YTickLabel',[],'FontSize',14','FontWeight','b')
%set(gca,'YTickLabelMode','auto')
hold off