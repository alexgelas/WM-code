function pRanksum = crossCorrMaxTest(func1,func2,minIndex,maxIndex)

[peaks1,peakIndices1]=max(func1(:,minIndex:maxIndex),[],2);
[peaks2,peakIndices2]=max(func2(:,minIndex:maxIndex),[],2);

peakIndices1
peakIndices2
%figure(10)
%boxplot([peaks1 peaks2])
pRanksum=ranksum(peakIndices1,peakIndices2);
%[tRS,pRS]=ttest2(peaks1,peaks2);

end