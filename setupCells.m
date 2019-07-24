function [exc, VRest, VNaF, VKDR, VAR, VKM, VCaH, V0, gLeak, gNaF, gKDR, gAR, gKM, gCaH, gRan, alphaMARFactor, betaMARFactor, alphaCaHFactor, betaCaHFactor, alphaKMFactor, betaKMFactor, Itonic, noiseIntensity, capacitance]=setupCells(cellType,typeExc, typeVRest,typeVNaF,typeVKDR,typeVAR,typeVKM,typeVCaH,typeV0,typeGLeak,typeGNaF,typeGKDR,typeGAR,typeGKM,typeGCaH,typeGRan,typeAlphaMARFactor,typeBetaMARFactor,typeAlphaKMFactor,typeBetaKMFactor,typeAlphaCaHFactor,typeBetaCaHFactor,typeItonic,typeNoiseIntensity,typeCapacitance)

% Produces a list of cells the network, specifying their characteristics.

numCells=length(cellType);

exc=zeros(numCells,1);

VRest=zeros(numCells,1);
VNaF=zeros(numCells,1);
VKDR=zeros(numCells,1);
VAR=zeros(numCells,1);
VKM=zeros(numCells,1);
VCaH=zeros(numCells,1);
V0=zeros(numCells,1);

gLeak=zeros(numCells,1);
gNaF=zeros(numCells,1);
gKDR=zeros(numCells,1);
gAR=zeros(numCells,1);
gKM=zeros(numCells,1);
gCaH=zeros(numCells,1);
gRan=zeros(numCells,1);



alphaMARFactor=ones(numCells,1);
betaMARFactor=ones(numCells,1);
alphaCaHFactor=ones(numCells,1);
betaCaHFactor=ones(numCells,1);
alphaKMFactor=ones(numCells,1);
betaKMFactor=ones(numCells,1);

noiseIntensity=zeros(numCells,1);
Itonic=zeros(numCells,1);
capacitance=zeros(numCells,1);
for i=1:numCells
    
    exc(i)=typeExc(cellType(i));
    VRest(i)=typeVRest(cellType(i));
    VNaF(i)=typeVNaF(cellType(i));
    VKDR(i)=typeVKDR(cellType(i));
    VAR(i)=typeVAR(cellType(i));
    VKM(i)=typeVKM(cellType(i));
    VCaH(i)=typeVCaH(cellType(i));
    V0(i)=typeV0(cellType(i));
    
    gLeak(i)=typeGLeak(cellType(i));
    gNaF(i)=typeGNaF(cellType(i));
    gKDR(i)=typeGKDR(cellType(i));
    gAR(i)=typeGAR(cellType(i));
    gKM(i)=typeGKM(cellType(i));
    gCaH(i)=typeGCaH(cellType(i));
    gRan(i)=typeGRan(cellType(i));
    
    alphaMARFactor(i)=typeAlphaMARFactor(cellType(i));
    betaMARFactor(i)=typeBetaMARFactor(cellType(i));
    alphaCaHFactor(i)=typeAlphaCaHFactor(cellType(i));
    betaCaHFactor(i)=typeBetaCaHFactor(cellType(i));
    alphaKMFactor(i)=typeAlphaKMFactor(cellType(i));
    betaKMFactor(i)=typeBetaKMFactor(cellType(i));
    
    noiseIntensity(i)=typeNoiseIntensity(cellType(i));
    Itonic(i)=typeItonic(cellType(i)); %+randn();
    capacitance(i)=typeCapacitance(cellType(i));
end
%Itonic=Itonic+0.5*randn(numCells,1);