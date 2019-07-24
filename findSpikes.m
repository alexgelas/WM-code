function spikes=findSpikes(V,oldDt,newDt,threshold)
% Takes the voltage recording with time step oldDt and produces the
% binary time series of whether a spike occurs or not with time step newDt

if nargin<4
    threshold=0;
end
ndims(threshold);
ratio=newDt/oldDt;

numRows=size(V,1);
newLength=floor(size(V,2)/ratio); % If it's not an integer number of bins, we truncate at the end. It would probably be nicer to add a last bin with what is left.


if size(threshold,1)>1
    extThreshold=threshold*ones(1,newLength);
else
    extThreshold=threshold;
end

maxV=zeros(numRows,newLength);
for i=1:newLength
    maxV(:,i)=max(V(:,(i-1)*ratio+1:i*ratio),[],2);
end

spikesTemp=maxV>extThreshold; % 0mV threshold to call it a spike
shiftedSpikesTemp=[false(numRows,1) spikesTemp(:,1:(newLength-1))];
%size(spikesTemp)
%size(~shiftedSpikesTemp)
spikes=spikesTemp & (~shiftedSpikesTemp);
