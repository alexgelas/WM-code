folder='figuresSet9';

%autoCorrMaxTime=1000; % Must agree with the one used in simulations
%autoCorrStep=10; % This, too.

%numCorrSteps=floor(autoCorrMaxTime/autoCorrStep)+1;

% fStep=1000/(2*autoCorrStep*(size(spec1,2)-1));
% fMax=1000/(2*autoCorrStep);    
% freqAxis=0:fStep:1000/(2*autoCorrStep);


minDiff=-100; % Must agree with value used to compute crossCorr
maxDiff=100; % Same
crossCorrDt=1; % Same

newMinDiff=-50;
newMaxDiff=50;

totLength=(maxDiff-minDiff)/crossCorrDt+1;

minIndex=(newMinDiff-minDiff)/crossCorrDt+1;
maxIndex=(newMaxDiff-minDiff)/crossCorrDt+1;

load(strcat(folder,'/temporalBottomUp/temporalBottomUp.mat'))

func1=earlyCrossCorrIB;
func2=lateCrossCorrIB;

crossCorrMaxTest(func1,func2,minIndex,maxIndex)
