% movedSlow(i)=1;
numSmallSteps=largeDt/smallDt;
for smallStep=1:numSmallSteps
    
    J=calcJ(V,synToPost,gSyn,s,Vrev,postSyn,gapToPost,gGap,preGap,postGap,inputToPost,gInput,sInput,inputVrev,inputTarget,noiseIntensity,sPoisson,noiseFactor,sPoissonToPost,VrevPoisson,gPoisson,postPoisson,Itonic,smallDt);
    
    V_k1=Vstep(V,h,m,mAR,mKM,mCaH,J,...
        VRest,VNaF,VKDR,VAR,VKM,VCaH,...
        gLeak,gNaF,gKDR,gAR,gKM,gCaH,...
        capacitance,exc,smallDt);
    
    [h_k1,m_k1,mAR_k1,mKM_k1,mCaH_k1]=...
        internalCurrentsStep(V,h,m,mAR,mKM,mCaH,V0,...
        alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
        alphaCaHFactor,betaCaHFactor,exc,smallDt);
    
    s_k1=synapse(s,rise,decay,V(preSyn),smallDt)-s;
    sInput_k1=synapse(sInput,inputSynRise,inputSynDecay,inputV(inputSource),smallDt)-sInput;
    sPoisson_k1=expDecay(sPoisson,0,decayPoisson,smallDt)+min(1,poissrnd(lambdaPoisson*smallDt))-sPoisson;
    
    V1=V+V_k1;
    h1=h+h_k1;
    m1=m+m_k1;
    mAR1=mAR+mAR_k1;
    mKM1=mKM+mKM_k1;
    mCaH1=mCaH+mCaH_k1;
    s1=s+s_k1;
    sInput1=sInput+sInput_k1;
    sPoisson1=sPoisson+sPoisson_k1;
    
    J1=calcJ(V1,synToPost,gSyn,s1,Vrev,postSyn,gapToPost,gGap,preGap,postGap,inputToPost,gInput,sInput1,inputVrev,inputTarget,noiseIntensity,sPoisson1,noiseFactor,sPoissonToPost,VrevPoisson,gPoisson,postPoisson,Itonic,smallDt);
    
    V_k2=Vstep(V1,h1,m1,mAR1,mKM1,mCaH1,J1,...
        VRest,VNaF,VKDR,VAR,VKM,VCaH,...
        gLeak,gNaF,gKDR,gAR,gKM,gCaH,...
        capacitance,exc,smallDt);
    
    [h_k2,m_k2,mAR_k2,mKM_k2,mCaH_k2]=...
        internalCurrentsStep(V1,h1,m1,mAR1,mKM1,mCaH1,V0,...
        alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
        alphaCaHFactor,betaCaHFactor,exc,smallDt);
    
    s_k2=synapse(s1,rise,decay,V1(preSyn),smallDt)-s1;
    sInput_k2=synapse(sInput1,inputSynRise,inputSynDecay,inputV(inputSource),smallDt)-sInput1;
    sPoisson_k2=expDecay(sPoisson1,0,decayPoisson,smallDt)+min(1,poissrnd(lambdaPoisson*smallDt))-sPoisson1;
    
    V=V+(V_k1+V_k2)/2;
    h=h+(h_k1+h_k2)/2;
    m=m+(m_k1+m_k2)/2;
    mAR=mAR+(mAR_k1+mAR_k2)/2;
    mKM=mKM+(mKM_k1+mKM_k2)/2;
    mCaH=mCaH+(mCaH_k1+mCaH_k2)/2;
    s=s+(s_k1+s_k2)/2;
    sInput=sInput+(sInput_k1+sInput_k2)/2;
    sPoisson=sPoisson+(sPoisson_k1+sPoisson_k2)/2;
        
%     else
%         
%         J=calcJ(V,synToPost,gSyn,s,Vrev,postSyn,gapToPost,gGap,preGap,postGap,inputToPost,gInput,sInput,inputVrev,inputTarget,noiseIntensity,sPoisson,noiseFactor,sPoissonToPost,VrevPoisson,gPoisson,postPoisson,Itonic,smallDt);
%         
%         V=updateVsmall(V,h,m,mAR,mKM,mCaH,J,...
%             VRest,VNaF,VKDR,VAR,VKM,VCaH,...
%             gLeak,gNaF,gKDR,gAR,gKM,gCaH,...
%             capacitance,exc,smallDt);
%         
%   [dh,dm,dMAR,dMKM,dMCaH]=...
%       internalCurrentsStep(V,h,m,mAR,mKM,mCaH,V0,...
%       alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
%       alphaCaHFactor,betaCaHFactor,exc,smallDt);
% 
% h=h+dh;
% m=m+dm;
% mAR=mAR+dMAR;
% mKM=mKM+dMKM;
% mCaH=mCaH+dMCaH;
%         
%         s=synapse(s,rise,decay,V(preSyn),smallDt);
%         sInput=synapse(sInput,inputSynRise,inputSynDecay,inputV(inputSource),smallDt);
%         sPoisson=expDecay(sPoisson,0,decayPoisson,smallDt)+min(1,poissrnd(lambdaPoisson*smallDt));
%         
%     end
end