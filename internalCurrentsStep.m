function [dH, dM, dMAR, dMKM, dMCaH]=...
    internalCurrentsStep(V,h,m,mAR,mKM,mCaH,V0,...
    alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
    alphaCaHFactor,betaCaHFactor,exc,dt)

hInf=hInfCalc(V,exc);
tauH=tauHCalc(V,exc);
[alphaH, betaH]=tauToAlpha(tauH,hInf);
%newH=expDecay(h,hInf,tauH,dt);
dH=expDecay2(h,alphaH,betaH,dt)-h;

mInf=mInfCalc(V,exc);
tauM=tauMCalc(V,exc);
[alphaM, betaM]=tauToAlpha(tauM,mInf);
%newM=expDecay(m,mInf,tauM,dt);
dM=expDecay2(m,alphaM,betaM,dt)-m;

mARInf=mARInfCalc(V,V0);
tauMAR=tauMARCalc(V);
[alphaMAR, betaMAR]=tauToAlpha(tauMAR,mARInf);
%newMAR=expDecay(mAR,mARInf,tauMAR,dt);
alphaMAR=alphaMAR.*alphaMARFactor;
betaMAR=betaMAR.*betaMARFactor;
dMAR=expDecay2(mAR,alphaMAR,betaMAR,dt)-mAR;

alphaKM=alphaKMFactor.*0.02./(1+exp((-V-20)/5));
betaKM=betaKMFactor.*0.01.*exp((-V-43)/18);
dMKM=expDecay2(mKM,alphaKM,betaKM,dt)-mKM;

% alphaCaH=alphaCaHFactor.*4.8./(1+exp(-0.072*(V-5)));
% betaCaH=betaCaHFactor.*0.06.*(V+8.9)./(exp((V+8.9)/5)-1);
alphaCaH=alphaCaHFactor.*1.6./(1+exp(-0.072*(V-5)));
betaCaH=betaCaHFactor.*0.02.*(V+8.9)./(exp((V+8.9)/5)-1);
dMCaH=expDecay2(mCaH,alphaCaH,betaCaH,dt)-mCaH;