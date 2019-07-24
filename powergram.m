oldDt=dt*saveStep;
newDt=oldDt;
%ratio=newDt/oldDt;
spikes=findSpikes(fullV,oldDt,newDt);
%inputSpikes=findSpikes(abs(fullI),oldDt,newDt,10);
inputSpikes=findSpikes(abs(fullI),oldDt,newDt,max(abs(fullI),[],2)/30);

%numCells=size(spikes,1);
%numRS=80;
%numFS=20;
%numLTS=20;
%numIB=20;

for cell=1:numRS+numFS+numLTS
    spikeTimes=find(spikes(cell,:));
    inputSpikeTimes=find(inputSpikes(cell,:));
    %plot(inputSpikeTimes*newDt,(numRS+numFS+numLTS+numIB-cell)*ones(length(inputSpikeTimes),1)+0.2,'.r');
    plot(spikeTimes*newDt,(numRS+numFS+numLTS+numIB-cell)*ones(length(spikeTimes),1),'.b');    
end

for cell=numRS+numFS+numLTS+3*numIB+1:numRS+numFS+numLTS+4*numIB
    spikeTimes=find(spikes(cell,:));
    %plot(inputSpikeTimes*newDt,(numRS+numFS+numLTS+4*numIB-cell)*ones(length(inputSpikeTimes),1),'.r');
    plot(spikeTimes*newDt,(numRS+numFS+numLTS+4*numIB-cell)*ones(length(spikeTimes),1)+0.2,'.b');
end

sd=1/newDt; % 1ms
numSD=3;
%kernLength=2*numSD*sd+1;
% gaussianKern=zeros(kernLength,1);
% for i=1:kernLength
%     gaussianKern(i)=1/(sqrt(2*pi)*sd)*exp(-(i-numSD*sd)^2/(2*sd^2));
% end

simLength=size(spikes,2);

%convMatrix=zeros(lengthKern,size(spikes,2));
convMatrix=zeros(simLength,simLength);
for i=1:simLength
    for j=-numSD*sd:numSD*sd
        if (i+j>=1 && i+j<=simLength)
            convMatrix(i,i+j)=exp(-j^2/(2*sd^2));
        end
    end
end
convMatrix=1/(sqrt(2*pi)*sd)*convMatrix;

smoothenedSpikes=spikes*(convMatrix');

smoothRS=sum(smoothenedSpikes(RS,:),1);
smoothIB=sum(smoothenedSpikes(IBaxon,:),1);
smoothSI=sum(smoothenedSpikes(LTS,:),1);

sumRS=sum(spikes(RS,:),1);
sumIB=sum(spikes(IBaxon,:),1);
sumSI=sum(spikes(LTS,:),1);

figure(1)

spectrogram(sumRS,2048,2000,[0.5:0.5:50],5000)

figure(2)

spectrogram(sumSI,2048,2000,[0.5:0.5:50],5000)

figure(3)

spectrogram(sumIB,2048,2000,[0.5:0.5:50],5000)
