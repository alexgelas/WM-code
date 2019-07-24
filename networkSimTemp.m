tic

%smallDt=0.005;
smallDt=0.01;
largeDt=0.2;
dt=largeDt;
saveStep=1; % larger than one might mess up with some functions, especially visualization %max(1,0.1/largeDt);%/smallDt;
numSmallSteps=largeDt/smallDt;

steps=2000;
quickRun=true;

folder='figuresSet3';

turnOffSI=0;
separateLayers=0;


setupCellTypes;
setupSynapseTypes;
setupNetwork;
setupInput;
setupPoisson;
[exc, VRest, VNaF, VKDR, VAR, VKM, VCaH, V0, gLeak, gNaF, gKDR, gAR, gKM, gCaH, gRan, alphaMARFactor, betaMARFactor, alphaCaHFactor, betaCaHFactor, alphaKMFactor, betaKMFactor, Itonic, noiseIntensity, capacitance]=setupCells(cellType,typeExc, typeVRest,typeVNaF,typeVKDR,typeVAR,typeVKM,typeVCaH,typeV0,typeGLeak,typeGNaF,typeGKDR,typeGAR,typeGKM,typeGCaH,typeGRan,typeAlphaMARFactor,typeBetaMARFactor,typeAlphaKMFactor,typeBetaKMFactor,typeAlphaCaHFactor,typeBetaCaHFactor,typeItonic,typeNoiseIntensity,typeCapacitance);
Itonic=Itonic+ItonicOffset;
[Vrev, rise, decay]=setupSynapses(synapseType,typeVrev,typeRise,typeDecay);
[inputVrev, inputSynRise, inputSynDecay]=setupSynapses(inputSynapseType,typeVrev,typeRise,typeDecay);

%setupPoisson2;

%Itonic=Itonic+1*randn(length(Itonic),1);

%gSyn=gSyn.*(1+0.1*randn(size(gSyn)));

%[numInputGabaBSynapses inputGabaBSource inputGabaBTarget gInputGabaB inputGabaBVrev inputGabaBnumBindingSites inputGabaBhalfActivation inputGabaBReceptorRise inputGabaBReceptorDecay inputGabaBActiveGRise inputGabaBActiveGDecay]=setupInputGabaBSynapses(numRS,numFS,numLTS,numIB,numDeepLTS,paramInputGabaBSynapses);

%[numGaps preGap postGap gGap]=setupGapJunctions(numRS,numFS,numLTS,numIB,numDeepLTS,paramSet);

s=zeros(numSynapses,1); % The dynamic variable of the synapses

sInput=zeros(numInputSynapses,1);

%inputGabaBReceptor=zeros(numInputGabaBSynapses,1);
%inputGabaBActiveG=zeros(numInputGabaBSynapses,1);

sPoisson=zeros(numPoisson,1);

synToPost=zeros(numCells,numSynapses); % Indicator matrix of post-synaptic cells of the synapses. A(i,j)=1 if the post-synaptic cell of the j-th synapse is the i-th cell.
gapToPost=zeros(numCells,numGapJunctions); % Indicator matrix of post-synaptic cells of the synapses. A(i,j)=1 if the post-synaptic cell of the j-th synapse is the i-th cell.
inputToPost=zeros(numCells,numInputSynapses);
%inputGabaBToPost=zeros(numCells,numInputGabaBSynapses);

sPoissonToPost=zeros(numCells,numPoisson);

for j=1:numSynapses
    synToPost(postSyn(j),j)=1;
end

for j=1:numGapJunctions
    gapToPost(postGap(j),j)=1;
end

for j=1:numInputSynapses
    inputToPost(inputTarget(j),j)=1;
end

%for j=1:numInputGabaBSynapses
%    inputGabaBToPost(inputGabaBTarget(j),j)=1;
%end

for j=1:numPoisson
    sPoissonToPost(postPoisson(j),j)=1;
end

[V, h, m, mAR, mKM, mCaH, I, Isyn, Igap, newV]=initialize(numCells);

for col=1:numColumns
    for i=1:colNumRS
        cell=RS(col,i);
        %mAR(cell)=0.025+0.04*rand(1);
        mAR(cell)=0.025+0.04*rand(1);
    end
    for i=1:colNumFS
        cell=FS(col,i);
        V(cell)=-110+10*rand(1);
    end
    for i=1:colNumLTS
        cell=LTS(col,i);
        mAR(cell)=0.02+0.04*rand(1);
    end
end

numInputs=10+numColumns;
inputV=-70*ones(numInputs,1);

%numGabaBInputs=1;
%inputGabaBV=-70*ones(numGabaBInputs,1); % better described as transmitter released in the synaptic cleft, not voltage

% cap h-current
mARmax=Inf*ones(numCells,1);
for cell=1:numRS
    %mARmax(cell)=0.02;
end

% RS: h
% Basket: -
% LTS: h
% Apical dendrite: h, m, Ca
% Basal dendrite: h, m, Ca
% Soma: -
% Axon: m

movedSlow=zeros(1,steps);

% Record full history
fullV=zeros(numCells,steps/saveStep);
% fullH=zeros(numCells,steps/saveStep);
% fullM=zeros(numCells,steps/saveStep);
% fullMAR=zeros(numCells,steps/saveStep);
% fullMKM=zeros(numCells,steps/saveStep);
% fullMCaH=zeros(numCells,steps/saveStep);
% fullI=zeros(numCells,steps/saveStep);
% fullJ=zeros(numCells,steps/saveStep);
% fullIsyn=zeros(numCells,steps/saveStep);
% fullIgap=zeros(numCells,steps/saveStep);
fullInputV=zeros(numInputs,steps/saveStep);
% fullSInput=zeros(numInputSynapses,steps/saveStep);

%VsumRS=zeros(steps,1);
%VsumFS=zeros(steps,1);
%Isum=zeros(steps,1);

% fullSynCurrents=zeros(numSynapses,steps/saveStep);
% 
% fullSynapses=zeros(numSynapses,steps/saveStep);

lastInp=0;
nextInp=45;
lastInp2=0;
nextInp2=70;

nextInp5=50;
inp5width=3.5;

ltsDelay=0.5;

nextInp6=20;
nextInp6b=20+ltsDelay;
nextInp4=305;
cyclesSkipped=0;
%nextInp7=50;
cyclesSkipped8=0;

noiseFactor=5;

for i=1:steps
    
    if mod(i,200/largeDt)==0 && i<=1000/largeDt
        i
    end
    
    if mod(i,500/largeDt)==0  && i>1000/largeDt
        i
    end
    
    if i==1/largeDt% || i==650/largeDt
        inputV(7)=100;
    end

    inputV=expDecay(inputV,-70,1,dt);

    for col=1:numColumns
        if i==(col*15+5)/largeDt;
            inputV(10+col)=100;
        end
    end
    
    if mod(i,1000/(gammaFreq*dt))<1
        inputV(8)=inputV(8)+100;
    end

    if mod(i,nextInp6/dt)<1
        inputV(6)=inputV(6)+100;
        nextInp6=nextInp6+0.8*1000/gammaFreq+0.4*1000/gammaFreq*rand(1);
        %nextInp6=nextInp6+1*1000/45+0*1000/45*rand(1);        
    end
    
    if i==305/largeDt% || i==650/largeDt
        inputV(3)=100;
    end
    
    if mod(i,nextInp4/dt)<1
        if i*dt>300 && i*dt<455
            inputV(4)=inputV(4)+100;
        end
        nextInp4=nextInp4+0.9*1000/beta2Freq+0.2*1000/beta2Freq*rand(1);
        %nextInp4=nextInp4+1*1000/beta2Freq+0*1000/beta2Freq*rand(1);
    end
    
    if i==500/largeDt% || i==650/largeDt
        inputV(2)=100;
    end
    
    noiseFactor=expDecay(noiseFactor,1,50,largeDt);
    
    if quickRun
        update;
    else
        update2;
    end

    if mod(i,saveStep)==0
        ii=i/saveStep;
        
        fullV(:,ii)=V;
%         fullI(:,ii)=I;
%         fullH(:,ii)=h;
%         fullM(:,ii)=m;
%         fullMAR(:,ii)=mAR;
%         fullMKM(:,ii)=mKM;
%         fullMCaH(:,ii)=mCaH;
% 
%         fullJ(:,ii)=J;
%         fullSynapses(:,ii)=s;
%         fullIgap(:,ii)=Igap;
%         fullIsyn(:,ii)=Isyn;
        fullInputV(:,ii)=inputV;
%         fullSInput(:,ii)=sInput;
%         %fullIinput(:,ii)=Iinput;        
    end
    
end

elapsedTime=toc