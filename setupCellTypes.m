%function [numTypeIndices typeExc typeVRest typeVNaF typeVKDR typeVAR typeVKM typeVCaH typeV0 typeGLeak typeGNaF typeGKDR typeGAR typeGKM typeGCaH typeGRan typeAlphaMARFactor typeBetaMARFactor typeAlphaKMFactor typeBetaKMFactor typeAlphaCaHFactor typeBetaCaHFactor typeItonic typeNoiseIntensity typeCapacitance]=setuptypeIndexs(paramSet)

% Produces a list of cell types, specifying their characteristics. This is
% a database that will be used for creating the actual cells in our
% network.

numTypeIndices=16;

% RS: h
% Basket: -
% LTS: h
% Apical dendrite: h, m, Ca
% Basal dendrite: h, m, Ca
% Soma: -
% Axon: m
% Deep LTS: h

% 1: RS
% 2: FS
% 3: LTS (superficial)
% 4: IB apical dendrite
% 5: IB basal dendrite
% 6: IB soma
% 7: IB axon
% 8: Deep LTS
% 9: Single comparment IB (like axon)

% 15: Deep RS
% 16: Deep FS

VRest_RS=-70;
VNaF_RS=50;
VKDR_RS=-95;
VAR_RS=-35;
%VKM_RS=;
%VCaH_RS=;
V0_RS=87.5;

VRest_FS=-65;
VNaF_FS=50;
VKDR_FS=-100;
%VAR_FS=;
%VKM_FS=;
%VCaH_FS=;
%V0_FS=;

VRest_LTS=-65;
VNaF_LTS=50;
VKDR_LTS=-100;
VAR_LTS=-35;
%VKM_LTS=;
%VCaH_LTS=;
V0_LTS=75;

VRest_IBapical=-70;
VNaF_IBapical=50;
VKDR_IBapical=-95;
VAR_IBapical=-25;
VKM_IBapical=-95;
VCaH_IBapical=125;
V0_IBapical=75;

VRest_IBbasal=-70;
VNaF_IBbasal=50;
VKDR_IBbasal=-95;
VAR_IBbasal=-25;
VKM_IBbasal=-95;
VCaH_IBbasal=125;
V0_IBbasal=75;

VRest_IBsoma=-70;
VNaF_IBsoma=50;
VKDR_IBsoma=-95;
%VAR_IBsoma=;
%VKM_IBsoma=;
%VCaH_IBsoma=;
%V0_IBsoma=;
    
VRest_IBaxon=-70;
VNaF_IBaxon=50;
VKDR_IBaxon=-95;
%VAR_IBaxon=;
VKM_IBaxon=-95;
%VCaH_IBaxon=;
%V0_IBaxon=;

VRest_deepLTS=-65;
VNaF_deepLTS=50;
VKDR_deepLTS=-100;
VAR_deepLTS=-35;
%VKM_deepLTS=;
%VCaH_deepLTS=;
V0_deepLTS=75;
    
gLeak_RS=1;
gNaF_RS=200;
gKDR_RS=20;
gAR_RS=25; % Value till May 15th 2018: 25
gAR_RS=40; % fork
%gAR_RS=18; % Changed May 15th 2018 (also increased alphaMARfactor_RS) - In
%the end I rolled back
%gKM_RS=;
%gCaH_RS=;

gLeak_FS=1;
gNaF_FS=200;
gKDR_FS=20;

gLeak_LTS=6;
gNaF_LTS=200;
gKDR_LTS=10;
gAR_LTS=50;

gLeak_IBapical=2;
gNaF_IBapical=125;
gKDR_IBapical=10;
gAR_IBapical=155; % Mark's value (155)
if ~mathNet
    gAR_IBapical=180; % used standard - and again June 20th
end
% gAR_IBapical=200; % fork June 13th-19th
gKM_IBapical=0.75;
gCaH_IBapical=6.5;

gLeak_IBbasal=2;
gNaF_IBbasal=125;
gKDR_IBbasal=10;
gAR_IBbasal=115;
gKM_IBbasal=0.75;
gCaH_IBbasal=6.5;
    
gLeak_IBsoma=1;
gNaF_IBsoma=50;
gKDR_IBsoma=10;
    
gLeak_IBaxon=0.25;
gNaF_IBaxon=100;
gKDR_IBaxon=5;
gKM_IBaxon=1.5;

gLeak_deepLTS=6;
gNaF_deepLTS=200;
gKDR_deepLTS=10;
gAR_deepLTS=25; % half of that for superficial LTS



% gRan probably not used

gRan_RS=0;
gRan_FS=0;
gRan_LTS=0;
gRan_IBapical=0;
gRan_IBbasal=0;
%gRan_IBbasal=125;
%gRan_IBbasal=1; % test
gRan_IBsoma=0;
gRan_IBaxon=0;
gRan_deepLTS=0;

alphaMARFactor_RS=1.75; % Original value 1.75
%alphaMARFactor_RS=10; % Used standard (May 15th 2018)
%alphaMARFactor_RS=3; % Used for a long time (value 3)
alphaMARFactor_RS=3.5; % test fork
betaMARFactor_RS=0.5;
%betaMARFactor_RS=1.5; % May 15th 2018
betaMARFactor_RS=1; % test fork
alphaCaHFactor_RS=1;
betaCaHFactor_RS=1;
alphaKMFactor_RS=1;
betaKMFactor_RS=1;

alphaMARFactor_FS=1;
betaMARFactor_FS=1;
alphaCaHFactor_FS=1;
betaCaHFactor_FS=1;
alphaKMFactor_FS=1;
betaKMFactor_FS=1;

alphaMARFactor_LTS=1;
betaMARFactor_LTS=1;
alphaCaHFactor_LTS=1;
betaCaHFactor_LTS=1;
alphaKMFactor_LTS=1;
betaKMFactor_LTS=1;

alphaMARFactor_IBapical=2.75; % Used in fork, like in Mark's code
%alphaMARFactor_IBapical=3; % used standard - Mark's code: 2.75
betaMARFactor_IBapical=3;
alphaCaHFactor_IBapical=3;
betaCaHFactor_IBapical=3;
alphaKMFactor_IBapical=1;
betaKMFactor_IBapical=1;

alphaMARFactor_IBbasal=2.75; %  % Used in fork, like in Mark's code
if ~mathNet
    %alphaMARFactor_IBbasal=3; % used standard
end
betaMARFactor_IBbasal=3;
alphaCaHFactor_IBbasal=3;
betaCaHFactor_IBbasal=3;
alphaKMFactor_IBbasal=1;
betaKMFactor_IBbasal=1;

alphaMARFactor_IBsoma=1;
betaMARFactor_IBsoma=1;
alphaCaHFactor_IBsoma=1;
betaCaHFactor_IBsoma=1;
alphaKMFactor_IBsoma=1;
betaKMFactor_IBsoma=1;

alphaMARFactor_IBaxon=1;
betaMARFactor_IBaxon=1;
alphaCaHFactor_IBaxon=1;
betaCaHFactor_IBaxon=1;
alphaKMFactor_IBaxon=1.5;
betaKMFactor_IBaxon=1.25;

alphaMARFactor_deepLTS=1;
betaMARFactor_deepLTS=1;
alphaCaHFactor_deepLTS=1;
betaCaHFactor_deepLTS=1;
alphaKMFactor_deepLTS=1;
betaKMFactor_deepLTS=1;

noiseSigma_RS=3;
noiseSigma_FS=1;
noiseSigma_LTS=1;
noiseSigma_IBapical=0.1;
noiseSigma_IBbasal=0.1;
noiseSigma_IBsoma=0;
noiseSigma_IBaxon=0.5;
noiseSigma_deepLTS=0.1;


% noiseSigma_RS=0;
% noiseSigma_FS=0;
% noiseSigma_LTS=0;
% noiseSigma_IBapical=0;
% noiseSigma_IBbasal=0;
% noiseSigma_IBsoma=0;
% noiseSigma_IBaxon=0;


RStonic=1; % I used -3 in older versions, for a long time
FStonic=35; % prescribed value, not easily excitable
LTStonic=35; % test - used the most

IBapicalTonic=25.5;
IBbasalTonic=42.5;
IBsomaTonic=-4.5;
IBaxonTonic=-0.4; % Prescribed value

deepLTStonic=35;



typeExc=zeros(numTypeIndices,1);
typeVRest=zeros(numTypeIndices,1);
typeVNaF=zeros(numTypeIndices,1);
typeVKDR=zeros(numTypeIndices,1);
typeVAR=zeros(numTypeIndices,1);
typeVKM=zeros(numTypeIndices,1);
typeVCaH=zeros(numTypeIndices,1);
typeV0=zeros(numTypeIndices,1);
typeGLeak=zeros(numTypeIndices,1);
typeGNaF=zeros(numTypeIndices,1);
typeGKDR=zeros(numTypeIndices,1);
typeGAR=zeros(numTypeIndices,1);
typeGKM=zeros(numTypeIndices,1);
typeGCaH=zeros(numTypeIndices,1);
typeGRan=zeros(numTypeIndices,1);
typeAlphaMARFactor=ones(numTypeIndices,1);
typeBetaMARFactor=ones(numTypeIndices,1);
typeAlphaKMFactor=ones(numTypeIndices,1);
typeBetaKMFactor=ones(numTypeIndices,1);
typeAlphaCaHFactor=ones(numTypeIndices,1);
typeBetaCaHFactor=ones(numTypeIndices,1);
typeItonic=zeros(numTypeIndices,1);
typeNoiseIntensity=zeros(numTypeIndices,1);





% 1: RS
typeIndex=1;
typeExc(typeIndex)=1;
typeVRest(typeIndex)=VRest_RS;
typeVNaF(typeIndex)=VNaF_RS;
typeVKDR(typeIndex)=VKDR_RS;
typeVAR(typeIndex)=VAR_RS;
%typeVKM(typeIndex)=VKM_RS;
%typeVCaH(typeIndex)=VCaH_RS;
typeV0(typeIndex)=V0_RS;

typeGLeak(typeIndex)=gLeak_RS;
typeGNaF(typeIndex)=gNaF_RS;
typeGKDR(typeIndex)=gKDR_RS;
typeGAR(typeIndex)=gAR_RS;
%typeGKM(typeIndex)=gKM_RS;
%typeGCaH(typeIndex)=gCaH_RS;
typeGRan(typeIndex)=gRan_RS;

typeAlphaMARFactor(typeIndex)=alphaMARFactor_RS;
typeBetaMARFactor(typeIndex)=betaMARFactor_RS;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_RS;
typeBetaKMFactor(typeIndex)=betaKMFactor_RS;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_RS;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_RS;

typeItonic(typeIndex)=RStonic;
typeNoiseIntensity(typeIndex)=noiseSigma_RS;
typeCapacitance(typeIndex)=0.9;

% 2: FS
typeIndex=2;
typeExc(typeIndex)=0;
typeVRest(typeIndex)=VRest_FS;
typeVNaF(typeIndex)=VNaF_FS;
typeVKDR(typeIndex)=VKDR_FS;
%typeVAR(typeIndex)=VAR_FS;
%typeVKM(typeIndex)=VKM_FS;
%typeVCaH(typeIndex)=VCaH_FS;
%typeV0(typeIndex)=V0_FS;

typeGLeak(typeIndex)=gLeak_FS;
typeGNaF(typeIndex)=gNaF_FS;
typeGKDR(typeIndex)=gKDR_FS;
%typeGAR(typeIndex)=gAR_FS;
%typeGKM(typeIndex)=gKM_FS;
%typeGCaH(typeIndex)=gCaH_FS;
typeGRan(typeIndex)=gRan_FS;

typeAlphaMARFactor(typeIndex)=alphaMARFactor_FS;
typeBetaMARFactor(typeIndex)=betaMARFactor_FS;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_FS;
typeBetaKMFactor(typeIndex)=betaKMFactor_FS;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_FS;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_FS;

typeItonic(typeIndex)=FStonic;
typeNoiseIntensity(typeIndex)=noiseSigma_FS;
typeCapacitance(typeIndex)=0.9;

% 3: LTS (superficial)
typeIndex=3;
typeExc(typeIndex)=0;
typeVRest(typeIndex)=VRest_LTS;
typeVNaF(typeIndex)=VNaF_LTS;
typeVKDR(typeIndex)=VKDR_LTS;
typeVAR(typeIndex)=VAR_LTS;
%typeVKM(typeIndex)=VKM_LTS;
%typeVCaH(typeIndex)=VCaH_LTS;
typeV0(typeIndex)=V0_LTS;
typeGLeak(typeIndex)=gLeak_LTS;
typeGNaF(typeIndex)=gNaF_LTS;
typeGKDR(typeIndex)=gKDR_LTS;
typeGAR(typeIndex)=gAR_LTS;
%typeGKM(typeIndex)=gKM_LTS;
%typeGCaH(typeIndex)=gCaH_LTS;
typeGRan(typeIndex)=gRan_LTS;
typeAlphaMARFactor(typeIndex)=alphaMARFactor_LTS;
typeBetaMARFactor(typeIndex)=betaMARFactor_LTS;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_LTS;
typeBetaKMFactor(typeIndex)=betaKMFactor_LTS;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_LTS;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_LTS;

typeItonic(typeIndex)=LTStonic;
typeNoiseIntensity(typeIndex)=noiseSigma_LTS;
typeCapacitance(typeIndex)=0.9;

% 4: IB apical dendrite
typeIndex=4;
typeExc(typeIndex)=1;
typeVRest(typeIndex)=VRest_IBapical;
typeVNaF(typeIndex)=VNaF_IBapical;
typeVKDR(typeIndex)=VKDR_IBapical;
typeVAR(typeIndex)=VAR_IBapical;
typeVKM(typeIndex)=VKM_IBapical;
typeVCaH(typeIndex)=VCaH_IBapical;
typeV0(typeIndex)=V0_IBapical;
typeGLeak(typeIndex)=gLeak_IBapical;
typeGNaF(typeIndex)=gNaF_IBapical;
typeGKDR(typeIndex)=gKDR_IBapical;
typeGAR(typeIndex)=gAR_IBapical;
typeGKM(typeIndex)=gKM_IBapical;
typeGCaH(typeIndex)=gCaH_IBapical;
typeGRan(typeIndex)=gRan_IBapical;
typeAlphaMARFactor(typeIndex)=alphaMARFactor_IBapical;
typeBetaMARFactor(typeIndex)=betaMARFactor_IBapical;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_IBapical;
typeBetaKMFactor(typeIndex)=betaKMFactor_IBapical;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_IBapical;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_IBapical;

typeItonic(typeIndex)=IBapicalTonic;
typeNoiseIntensity(typeIndex)=noiseSigma_IBapical;
typeCapacitance(typeIndex)=0.9;

% 5: IB basal dendrite
typeIndex=5;
typeExc(typeIndex)=1;
typeVRest(typeIndex)=VRest_IBbasal;
typeVNaF(typeIndex)=VNaF_IBbasal;
typeVKDR(typeIndex)=VKDR_IBbasal;
typeVAR(typeIndex)=VAR_IBbasal;
typeVKM(typeIndex)=VKM_IBbasal;
typeVCaH(typeIndex)=VCaH_IBbasal;
typeV0(typeIndex)=V0_IBbasal;
typeGLeak(typeIndex)=gLeak_IBbasal;
typeGNaF(typeIndex)=gNaF_IBbasal;
typeGKDR(typeIndex)=gKDR_IBbasal;
typeGAR(typeIndex)=gAR_IBbasal;
typeGKM(typeIndex)=gKM_IBbasal;
typeGCaH(typeIndex)=gCaH_IBbasal;
typeGRan(typeIndex)=gRan_IBbasal;
typeAlphaMARFactor(typeIndex)=alphaMARFactor_IBbasal;
typeBetaMARFactor(typeIndex)=betaMARFactor_IBbasal;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_IBbasal;
typeBetaKMFactor(typeIndex)=betaKMFactor_IBbasal;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_IBbasal;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_IBbasal;

typeItonic(typeIndex)=IBbasalTonic;
typeNoiseIntensity(typeIndex)=noiseSigma_IBbasal;
typeCapacitance(typeIndex)=0.9;

% 6: IB soma
typeIndex=6;
typeExc(typeIndex)=1;
typeVRest(typeIndex)=VRest_IBsoma;
typeVNaF(typeIndex)=VNaF_IBsoma;
typeVKDR(typeIndex)=VKDR_IBsoma;
%typeVAR(typeIndex)=VAR_IBsoma;
%typeVKM(typeIndex)=VKM_IBsoma;
%typeVCaH(typeIndex)=VCaH_IBsoma;
%typeV0(typeIndex)=V0_IBsoma;
typeGLeak(typeIndex)=gLeak_IBsoma;
typeGNaF(typeIndex)=gNaF_IBsoma;
typeGKDR(typeIndex)=gKDR_IBsoma;
%typeGAR(typeIndex)=gAR_IBsoma;
%typeGKM(typeIndex)=gKM_IBsoma;
%typeGCaH(typeIndex)=gCaH_IBsoma;
typeGRan(typeIndex)=gRan_IBsoma;
typeAlphaMARFactor(typeIndex)=alphaMARFactor_IBsoma;
typeBetaMARFactor(typeIndex)=betaMARFactor_IBsoma;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_IBsoma;
typeBetaKMFactor(typeIndex)=betaKMFactor_IBsoma;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_IBsoma;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_IBsoma;

typeItonic(typeIndex)=IBsomaTonic;
typeNoiseIntensity(typeIndex)=noiseSigma_IBsoma;
typeCapacitance(typeIndex)=0.9;

% 7: IB axon
typeIndex=7;
typeExc(typeIndex)=1;
typeVRest(typeIndex)=VRest_IBaxon;
typeVNaF(typeIndex)=VNaF_IBaxon;
typeVKDR(typeIndex)=VKDR_IBaxon;
%typeVAR(typeIndex)=VAR_IBaxon;
typeVKM(typeIndex)=VKM_IBaxon;
%typeVCaH(typeIndex)=VCaH_IBaxon;
%typeV0(typeIndex)=V0_IBaxon;
typeGLeak(typeIndex)=gLeak_IBaxon;
typeGNaF(typeIndex)=gNaF_IBaxon;
typeGKDR(typeIndex)=gKDR_IBaxon;
%typeGAR(typeIndex)=gAR_IBaxon;
typeGKM(typeIndex)=gKM_IBaxon;
%typeGCaH(typeIndex)=gCaH_IBaxon;
typeGRan(typeIndex)=gRan_IBaxon;
typeAlphaMARFactor(typeIndex)=alphaMARFactor_IBaxon;
typeBetaMARFactor(typeIndex)=betaMARFactor_IBaxon;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_IBaxon;
typeBetaKMFactor(typeIndex)=betaKMFactor_IBaxon;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_IBaxon;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_IBaxon;

typeItonic(typeIndex)=IBaxonTonic;
typeNoiseIntensity(typeIndex)=noiseSigma_IBaxon;
typeCapacitance(typeIndex)=0.9;

% 8: Deep LTS
typeIndex=8;
typeExc(typeIndex)=0;
typeVRest(typeIndex)=VRest_deepLTS;
typeVNaF(typeIndex)=VNaF_deepLTS;
typeVKDR(typeIndex)=VKDR_deepLTS;
typeVAR(typeIndex)=VAR_deepLTS;
%typeVKM(typeIndex)=VKM_deepLTS;
%typeVCaH(typeIndex)=VCaH_deepLTS;
typeV0(typeIndex)=V0_deepLTS;
typeGLeak(typeIndex)=gLeak_deepLTS;
typeGNaF(typeIndex)=gNaF_deepLTS;
typeGKDR(typeIndex)=gKDR_deepLTS;
typeGAR(typeIndex)=gAR_deepLTS;
%typeGKM(typeIndex)=gKM_deepLTS;
%typeGCaH(typeIndex)=gCaH_deepLTS;
typeGRan(typeIndex)=gRan_deepLTS;
typeAlphaMARFactor(typeIndex)=alphaMARFactor_deepLTS;
typeBetaMARFactor(typeIndex)=betaMARFactor_deepLTS;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_deepLTS;
typeBetaKMFactor(typeIndex)=betaKMFactor_deepLTS;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_deepLTS;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_deepLTS;

typeItonic(typeIndex)=deepLTStonic;
typeNoiseIntensity(typeIndex)=noiseSigma_deepLTS;
typeCapacitance(typeIndex)=0.9;


% 9: Single comparment IB (like axon)
typeIndex=9;
typeExc(typeIndex)=1;
typeVRest(typeIndex)=VRest_IBaxon;
typeVNaF(typeIndex)=VNaF_IBaxon;
typeVKDR(typeIndex)=VKDR_IBaxon;
%typeVAR(typeIndex)=VAR_IBaxon;
typeVKM(typeIndex)=VKM_IBaxon;
%typeVCaH(typeIndex)=VCaH_IBaxon;
%typeV0(typeIndex)=V0_IBaxon;
typeGLeak(typeIndex)=gLeak_IBaxon;
typeGNaF(typeIndex)=gNaF_IBaxon;
typeGKDR(typeIndex)=gKDR_IBaxon;
%typeGAR(typeIndex)=gAR_IBaxon;
typeGKM(typeIndex)=gKM_IBaxon;
%typeGCaH(typeIndex)=gCaH_IBaxon;
typeGRan(typeIndex)=gRan_IBaxon;
typeAlphaMARFactor(typeIndex)=alphaMARFactor_IBaxon;
typeBetaMARFactor(typeIndex)=betaMARFactor_IBaxon;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_IBaxon;
typeBetaKMFactor(typeIndex)=betaKMFactor_IBaxon;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_IBaxon;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_IBaxon;

typeItonic(typeIndex)=-4; % IB axon has -0.4
typeNoiseIntensity(typeIndex)=noiseSigma_IBaxon;
typeCapacitance(typeIndex)=0.9;



% 15: Deep RS
typeIndex=15;
typeExc(typeIndex)=1;
typeVRest(typeIndex)=VRest_RS;
typeVNaF(typeIndex)=VNaF_RS;
typeVKDR(typeIndex)=VKDR_RS;
typeVAR(typeIndex)=VAR_RS;
%typeVKM(typeIndex)=VKM_RS;
%typeVCaH(typeIndex)=VCaH_RS;
typeV0(typeIndex)=V0_RS;

typeGLeak(typeIndex)=gLeak_RS;
typeGNaF(typeIndex)=gNaF_RS;
typeGKDR(typeIndex)=gKDR_RS;
typeGAR(typeIndex)=gAR_RS;
%typeGKM(typeIndex)=gKM_RS;
%typeGCaH(typeIndex)=gCaH_RS;
typeGRan(typeIndex)=gRan_RS;

typeAlphaMARFactor(typeIndex)=alphaMARFactor_RS;
typeBetaMARFactor(typeIndex)=betaMARFactor_RS;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_RS;
typeBetaKMFactor(typeIndex)=betaKMFactor_RS;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_RS;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_RS;

typeItonic(typeIndex)=RStonic;
typeNoiseIntensity(typeIndex)=noiseSigma_RS;
typeCapacitance(typeIndex)=0.9;

% 16: Deep FS
typeIndex=16;
typeExc(typeIndex)=0;
typeVRest(typeIndex)=VRest_FS;
typeVNaF(typeIndex)=VNaF_FS;
typeVKDR(typeIndex)=VKDR_FS;
%typeVAR(typeIndex)=VAR_FS;
%typeVKM(typeIndex)=VKM_FS;
%typeVCaH(typeIndex)=VCaH_FS;
%typeV0(typeIndex)=V0_FS;

typeGLeak(typeIndex)=gLeak_FS;
typeGNaF(typeIndex)=gNaF_FS;
typeGKDR(typeIndex)=gKDR_FS;
%typeGAR(typeIndex)=gAR_FS;
%typeGKM(typeIndex)=gKM_FS;
%typeGCaH(typeIndex)=gCaH_FS;
typeGRan(typeIndex)=gRan_FS;

typeAlphaMARFactor(typeIndex)=alphaMARFactor_FS;
typeBetaMARFactor(typeIndex)=betaMARFactor_FS;
typeAlphaKMFactor(typeIndex)=alphaKMFactor_FS;
typeBetaKMFactor(typeIndex)=betaKMFactor_FS;
typeAlphaCaHFactor(typeIndex)=alphaCaHFactor_FS;
typeBetaCaHFactor(typeIndex)=betaCaHFactor_FS;

typeItonic(typeIndex)=FStonic-28;
typeNoiseIntensity(typeIndex)=noiseSigma_FS;
typeCapacitance(typeIndex)=0.9;