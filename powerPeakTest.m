function pRanksum = powerPeakTest(spec1,spec2,minIndex,maxIndex,tail)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

if (~exist('tail', 'var'))
    tail='left'
end
    
[peaks1,peakIndices1]=max(spec1(:,minIndex:maxIndex),[],2);
[peaks2,peakIndices2]=max(spec2(:,minIndex:maxIndex),[],2);

%figure(10)
%boxplot([peaks1 peaks2])
pRanksum=ranksum(peaks1,peaks2,'tail',tail);
%[tRS,pRS]=ttest2(peaks1,peaks2);

end