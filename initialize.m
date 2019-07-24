if mathNet
    setupNetworkMath;
    setupInputMath;
else
    setupNetwork;
    setupInput;
end
setupPoisson;
setupCellTypes;
setupSynapseTypes;
[exc, VRest, VNaF, VKDR, VAR, VKM, VCaH, V0, gLeak, gNaF,...
    gKDR, gAR, gKM, gCaH, gRan, alphaMARFactor, betaMARFactor,...
    alphaCaHFactor, betaCaHFactor, alphaKMFactor, betaKMFactor,...
    Itonic, noiseIntensity, capacitance]=...
    setupCells(cellType,typeExc, typeVRest,typeVNaF,typeVKDR,...
    typeVAR,typeVKM,typeVCaH,typeV0,typeGLeak,typeGNaF,typeGKDR,...
    typeGAR,typeGKM,typeGCaH,typeGRan,typeAlphaMARFactor,...
    typeBetaMARFactor,typeAlphaKMFactor,typeBetaKMFactor,...
    typeAlphaCaHFactor,typeBetaCaHFactor,typeItonic,...
    typeNoiseIntensity,typeCapacitance);
Itonic=Itonic+ItonicOffset;
if mathNet
    %noiseIntensity=zeros(length(noiseIntensity),1);
end

[Vrev, rise, decay]=setupSynapses(synapseType,...
    typeVrev,typeRise,typeDecay);
[inputVrev, inputSynRise, inputSynDecay]=...
    setupSynapses(inputSynapseType,typeVrev,typeRise,typeDecay);

%setupPoisson2;

%Itonic=Itonic+1*randn(length(Itonic),1);

%gSyn=gSyn.*(1+0.1*randn(size(gSyn)));

%[numInputGabaBSynapses inputGabaBSource inputGabaBTarget gInputGabaB inputGabaBVrev inputGabaBnumBindingSites inputGabaBhalfActivation inputGabaBReceptorRise inputGabaBReceptorDecay inputGabaBActiveGRise inputGabaBActiveGDecay]=setupInputGabaBSynapses(numRS,numFS,numLTS,numIB,numDeepLTS,paramInputGabaBSynapses);

s=zeros(numSynapses,1); % The dynamic variables of the synapses
synToPost=zeros(numCells,numSynapses); % Indicator matrix of post-synaptic cells of the synapses. A(i,j)=1 if the post-synaptic cell of the j-th synapse is the i-th cell.

gapToPost=zeros(numCells,numGapJunctions); % Indicator matrix of post-synaptic cells of the synapses. A(i,j)=1 if the post-synaptic cell of the j-th synapse is the i-th cell.

sInput=zeros(numInputSynapses,1);
inputToPost=zeros(numCells,numInputSynapses);

sPoisson=zeros(numPoisson,1);
sPoissonToPost=zeros(numCells,numPoisson);

if numSynapses>0
    for j=1:numSynapses
        synToPost(postSyn(j),j)=1;
    end
end
    
if numGapJunctions>0    
    for j=1:numGapJunctions
        gapToPost(postGap(j),j)=1;
    end
end

if numInputSynapses>0
    for j=1:numInputSynapses
        inputToPost(inputTarget(j),j)=1;
    end
end

if numPoisson>0
    for j=1:numPoisson
        sPoissonToPost(postPoisson(j),j)=1;
    end
end

movedSlow=zeros(1,steps);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initial State

%V=(-100+20*rand(numCells,1)).*ones(numCells,1);
V=(-100+10*rand(numCells,1)).*ones(numCells,1);
V(RS)=(-75+5*rand(size(RS)));
% h=0.1*abs(rand(numCells,1)); % h is the usual Na deactivating 'gate'
% m=0.1*abs(rand(numCells,1)); % m is the usual K activating 'gate'
% %mAR=0.01*abs(rand(numCells,1)); % h-current - Used till Sep 19th 2017
% mAR=0.0+0.02*abs(rand(numCells,1)); % mAR is h-current
% mKM=0.0*abs(rand(numCells,1)); % mKM is m-current
% mCaH=0.01*abs(rand(numCells,1)); % mCaH is high-threshold calcium current

h=0.05*abs(rand(numCells,1)); % h is the usual Na deactivating 'gate'
m=0.05*abs(rand(numCells,1)); % m is the usual K activating 'gate'
%mAR=0.01*abs(rand(numCells,1)); % h-current - Used till Sep 19th 2017
%mAR=0.0+0.01*abs(rand(numCells,1)); % mAR is h-current
mAR=0.0+0.001*abs(rand(numCells,1)); % mAR is h-current
%mKM=0.0*abs(rand(numCells,1)); % mKM is m-current
mKM=0.05*abs(rand(numCells,1)); % mKM is m-current
mCaH=0.01*abs(rand(numCells,1)); % mCaH is high-threshold calcium current

for col=1:numColumns
    if colNumRS>0
        for i=1:colNumRS
            cell=RS(col,i);
            %mAR(cell)=0.03+0.04*rand(1);
            mAR(cell)=0.035+0.025*rand(1);
            V(cell)=-70+10*rand(1);
        end
    end
    if colNumFS>0
        for i=1:colNumFS
            cell=FS(col,i);
            V(cell)=-110+10*rand(1);
        end
    end
    if colNumLTS>0
        for i=1:colNumLTS
            cell=LTS(col,i);
            mAR(cell)=0.02+0.04*rand(1);
        end
    end
end

I=zeros(numCells,1);        % Periodic input current
Isyn=zeros(numCells,1);     % Synaptic currents
Igap=zeros(numCells,1);     % Gap junction currents, including intercompartmental currents within same cell

newV=zeros(numCells,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize inputV

numInputs=20+numColumns;
inputV=-70*ones(numInputs,1);

nextInp6=20;
nextInp4=topDownStart;

noiseFactor=5;

colStartIB=160*rand(numColumns,1); % in ms

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Record full history

fullV=zeros(numCells,steps/saveStep);
% fullH=zeros(numCells,steps/saveStep);
% fullM=zeros(numCells,steps/saveStep);
if mathNet
    fullMAR=zeros(numCells,steps/saveStep);
    fullMKM=zeros(numCells,steps/saveStep);
end
% fullMCaH=zeros(numCells,steps/saveStep);
% fullI=zeros(numCells,steps/saveStep);
% fullJ=zeros(numCells,steps/saveStep);
% fullIsyn=zeros(numCells,steps/saveStep);
% fullIgap=zeros(numCells,steps/saveStep);
fullInputV=zeros(numInputs,steps/saveStep);
fullSInput=zeros(numInputSynapses,steps/saveStep);

%VsumRS=zeros(steps,1);
%VsumFS=zeros(steps,1);
%Isum=zeros(steps,1);

% fullSynCurrents=zeros(numSynapses,steps/saveStep);
% 
% fullSynapses=zeros(numSynapses,steps/saveStep);