function powerSpec=powerSpectrum(V,oldDt,newDt,minDiff,maxDiff)

% Takes the voltage traces of a group of neurons (each neuron's trace is
% one line in V) and produces the power spectrum. oldDt is the time step in
% V, while newDt is the time step of the autocorrelation function, which is
% also the sampling period.
% (minDiff,maxDiff) are the limits of the autocorrelation function (minDiff
% should be negative).


%minDiff=-150;
%maxDiff=300;
autoCorr=crossCorrelogram2(V,V,oldDt,newDt,minDiff,maxDiff);

numNegativeSteps=max(-minDiff,0)/newDt;
numPositiveSteps=min(maxDiff,maxDiff-minDiff)/newDt;
% figure(4)
% clf
% plot(newDt*(-numNegativeSteps:numPositiveSteps),autoCorr);
fourierTemp=fft(autoCorr);

fSamp = 1000/newDt;            % Sampling frequency
%Tsamp=1/fSamp;
L = length(autoCorr);             % Length of signal

halfLength=floor(L/2);

P2 = abs(fourierTemp/L);
P1 = P2(1:halfLength+1);
P1(2:end-1) = 2*P1(2:end-1);
powerSpec=P1;

% f = fSamp*(0:halfLength)/(2*halfLength);
% 
% figure(3)
% clf
% plot(f,powerSpec,'LineWidth',2)
% ax=gca;
% ax.FontSize=12;
% ax.FontWeight='bold';
% ax.XLabel.String ='Frequency (Hz)';
% %ax.YLabel.String =;