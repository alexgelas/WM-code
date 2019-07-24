% Isyn=synToPost*(gSyn.*s.*(V(postSyn)-Vrev));
% 
% Igap=gapToPost*(gGap.*(V(postGap)-V(preGap)));
% 
% % "I" formerly included gabaB type input
% I=inputToPost*(gInput.*sInput.*(V(inputTarget)-inputVrev));
% 
% Inoise=0.01*noiseIntensity.*randn(numCells,1)*largeDt^(1/2);
% 
% Ipoisson=noiseFactor*sPoissonToPost*(gPoisson.*sPoisson.*(V(postPoisson)-VrevPoisson));
% 
% J=I+Isyn+Igap+Inoise+Itonic+Ipoisson;

J=calcJ(V,synToPost,gSyn,s,Vrev,postSyn,gapToPost,...
            gGap,preGap,postGap,inputToPost,gInput,sInput,...
            inputVrev,inputTarget,noiseIntensity,sPoisson,...
            noiseFactor,sPoissonToPost,VrevPoisson,gPoisson,...
            postPoisson,Itonic,largeDt);

%m0=m0Calc(V,exc);

dVdt=Vstep(V,h,m,mAR,mKM,mCaH,J,...
    VRest,VNaF,VKDR,VAR,VKM,VCaH,...
    gLeak,gNaF,gKDR,gAR,gKM,gCaH,...
    capacitance,exc,1);
% 1./capacitance.*( ...
%     -J...
%     -gLeak.*(V-VRest) ...
%     -gNaF.*m0.^3.*h.*(V-VNaF) ...
%     -gKDR.*m.^4.*(V-VKDR) ...
%     -gAR.*mAR.*(V-VAR) ...
%     -gKM.*mKM.*(V-VKM) ...
%     -gCaH.*mCaH.^2.*(V-VCaH) ...%+noise...
%     );

dsdt=synapse(s,rise,decay,V(preSyn),1)-s;%-s./decay +(1-s)./rise.*(1+tanh(V(preSyn)/10))/2;
dsInputdt=synapse(sInput,inputSynRise,inputSynDecay,inputV(inputSource),1)-sInput;%-sInput./inputSynDecay +(1-sInput)./inputSynRise.*(1+tanh(inputV(inputSource)/10))/2;

if max(abs(dVdt))<5 && max(abs(dsdt))<1 && max(abs(dsInputdt))<1
    V=V+largeDt*dVdt;
    
    [dh,dm,dMAR,dMKM,dMCaH]=...
        internalCurrentsStep(V,h,m,mAR,mKM,mCaH,V0,...
        alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
        alphaCaHFactor,betaCaHFactor,exc,largeDt);
    
    h=h+dh;
    m=m+dm;
    mAR=mAR+dMAR;
    mKM=mKM+dMKM;
    mCaH=mCaH+dMCaH;
    
%     [V, h, m, mAR, mKM, mCaH]=...
%     updateCellsSmall(V,h,m,mAR,mKM,mCaH,J,...
%     VRest,VNaF,VKDR,VAR,VKM,VCaH,V0,...
%     gLeak,gNaF,gKDR,gAR,gKM,gCaH,...
%     alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
%     alphaCaHFactor,betaCaHFactor,capacitance,exc,largeDt);

    s=s+dsdt*largeDt;%synapse(s,rise,decay,V(preSyn),largeDt);
    sInput=sInput+dsInputdt*largeDt;%synapse(sInput,inputSynRise,inputSynDecay,inputV(inputSource),largeDt);
    sPoisson=sPoisson-largeDt*sPoisson./decayPoisson+min(1,poissrnd(lambdaPoisson*largeDt));
    %inputGabaBReceptor=synapse2(inputGabaBReceptor,inputGabaBReceptorRise,inputGabaBReceptorDecay,inputGabaBV(inputGabaBSource),largeDt);
    %inputGabaBActiveG=GproteinUpdate(inputGabaBActiveG,inputGabaBReceptor.*inputGabaBActiveGRise,inputGabaBActiveGDecay,largeDt);
    
%     if i<400/largeDt
%         %s(2161:2185)=zeros(25,1);
%         tempLen=length(preSyn);
%         s(tempLen-99:tempLen)=zeros(100,1);
%     end
else
    movedSlow(i)=1;
    
    for smallStep=1:numSmallSteps
        
        J=calcJ(V,synToPost,gSyn,s,Vrev,postSyn,gapToPost,...
            gGap,preGap,postGap,inputToPost,gInput,sInput,...
            inputVrev,inputTarget,noiseIntensity,sPoisson,...
            noiseFactor,sPoissonToPost,VrevPoisson,gPoisson,...
            postPoisson,Itonic,smallDt);
        
        V=V+Vstep(V,h,m,mAR,mKM,mCaH,J,...
            VRest,VNaF,VKDR,VAR,VKM,VCaH,...
            gLeak,gNaF,gKDR,gAR,gKM,gCaH,...
            capacitance,exc,smallDt);
        
        [dh,dm,dMAR,dMKM,dMCaH]=...
            internalCurrentsStep(V,h,m,mAR,mKM,mCaH,V0,...
            alphaMARFactor,betaMARFactor,alphaKMFactor,betaKMFactor,...
            alphaCaHFactor,betaCaHFactor,exc,smallDt);
        
        h=h+dh;
        m=m+dm;
        mAR=mAR+dMAR;
        mKM=mKM+dMKM;
        mCaH=mCaH+dMCaH;
        
        s=synapse(s,rise,decay,V(preSyn),smallDt);
        sInput=synapse(sInput,inputSynRise,inputSynDecay,inputV(inputSource),smallDt);
        sPoisson=sPoisson-smallDt*sPoisson./decayPoisson+min(1,poissrnd(lambdaPoisson*smallDt));
        
%         if i<400/largeDt
%             %s(2161:2185)=zeros(25,1);
%             tempLen=length(preSyn);
%             s(tempLen-99:tempLen)=zeros(100,1);
%         end
    end
end

    