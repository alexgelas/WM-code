% Produces a list of synapse types, specifying the reversal potential and
% rise/decay constants. This is a "database" that is used for creating
% the actual synapses in our network.

% 1: RS to RS
% 2: RS to FS
% 3: RS to LTS
% 4: FS to RS
% 5: FS self-synapse
% 6: FS to LTS
% 7: LTS to RS
% 8: LTS to FS
% 9: LTS self-synapse
% 10: RS to IB - AMPA
% 11: RS to IB - NMDA
% 12: LTS to IB
% 13: IB to FS
% 14: IB to LTS
% 15: IB to deepLTS
% 16: deepLTS to IB
% 17: RS to next column IB - AMPA
% 18: RS to next column IB - NMDA
% 19: IB axon to IB basal
% 20: IB axon to next column IB basal

% 36: Deep RS to Deep FS
% 37: Deep RS to Deep LTS
% 38: Deep FS to Deep RS
% 39: Deep FS self-synapse
% 40: Deep FS to Deep LTS
% 41: Deep LTS to Deep RS
% 42: Deep LTS to Deep FS
% 43: Deep LTS self-synapse
% 44: IB to Deep RS
% 45: IB to Deep FS
% 46: Deep RS to IB
% 47: Deep FS to IB

numSynapseTypes=62; % Change every time new synapse types are created

rsRsRise=0.125;% I divided by 2
rsRsDecay=1;
rsBasketRise=0.125;% I divided by 2
rsBasketDecay=1;
rsLtsRise=1.25;% I divided by 2
rsLtsDecay=1;

rsIbApicalRiseAMPA=0.125; % From Mark's code, divided by 2
rsIbApicalDecayAMPA=1;

% rsIbApicalRiseAMPA=0.5; % Used in the beginning. Doesn't appear anywhere
% rsIbApicalDecayAMPA=6; % Used in the beginning. Doesn't appear anywhere

rsIbApicalRiseNMDA=12.5; % Appears only in 2011 PNAS paper S1 (and Mark's code). Divided by 2
rsIbApicalDecayNMDA=125; % Appears only in 2011 PNAS paper S1. But there it is 125. The 150 value is from Mark's MATLAB code.

rsNextIbApicalRiseAMPA=rsIbApicalRiseAMPA;
rsNextIbApicalDecayAMPA=rsIbApicalDecayAMPA;

rsNextIbApicalRiseNMDA=rsIbApicalRiseNMDA;
rsNextIbApicalDecayNMDA=rsIbApicalDecayNMDA;

basketRsRise=0.25;
basketRsDecay=5;    % This is the value in S1.
%basketRsDecay=6;    % This is from Mark's matlab code.
basketBasketRise=0.25;
basketBasketDecay=5;
basketLtsRise=0.25;
basketLtsDecay=6;
%basketLtsDecay=4; % test

ltsRsRise=0.25;
ltsRsDecay=20;
ltsLtsRise=0.25;
ltsLtsDecay=20;
%ltsLtsDecay=12; % test
ltsIbApicalRise=0.25;
ltsIbApicalDecay=20; % Value in S1
%ltsIbApicalDecay=22; % From Mark's MATLAB code
%ltsIbApicalDecay=28; % test
%ltsIbApicalDecay=22; % test
%ltsIbApicalDecay=2; % test

ibAxonBasketRise=0.125;
ibAxonBasketDecay=1;
ibAxonLtsRise=1.25;
ibAxonLtsDecay=50;
ibAxonIbBasalRise=0.25;
ibAxonIbBasalDecay=100;

ibAxonDeepLtsRise=0.125;
ibAxonDeepLtsDecay=1;

deepLTSibBasalRise=0.25;
deepLTSibBasalDecay=20;
%deepLTSibBasalDecay=13.5; % test

typeVrev=zeros(numSynapseTypes,1);
typeRise=zeros(numSynapseTypes,1);
typeDecay=zeros(numSynapseTypes,1);





% 1: RS to RS
synType=1; % is only used temporarily

typeVrev(synType)=0;
typeRise(synType)=rsRsRise;
typeDecay(synType)=rsRsDecay;

% 2: RS to FS
synType=2;
typeVrev(synType)=0;
typeRise(synType)=rsBasketRise;
typeDecay(synType)=rsBasketDecay;

% 3: RS to LTS
synType=3;
typeVrev(synType)=0;
typeRise(synType)=rsLtsRise;
typeDecay(synType)=rsLtsDecay;

% 4: FS to RS
synType=4;
typeVrev(synType)=-80;
typeRise(synType)=basketRsRise;
typeDecay(synType)=basketRsDecay;

% 5: FS self-synapse
synType=5;
typeVrev(synType)=-75;
typeRise(synType)=basketBasketRise;
typeDecay(synType)=basketBasketDecay;

% 6: FS to LTS
synType=6;
typeVrev(synType)=-80;
typeRise(synType)=basketLtsRise;
typeDecay(synType)=basketLtsDecay;

% 7: LTS to RS
synType=7;
typeVrev(synType)=-80;
typeRise(synType)=ltsRsRise;
typeDecay(synType)=ltsRsDecay;

% 8: LTS to FS
synType=8;
typeVrev(synType)=-80;
typeRise(synType)=ltsRsRise; % use same rise and decay constants
typeDecay(synType)=ltsRsDecay;

% 9: LTS self-synapse
synType=9;
typeVrev(synType)=-80;
typeRise(synType)=ltsLtsRise;
typeDecay(synType)=ltsLtsDecay;


% 10: RS to IB - AMPA
synType=10;
typeVrev(synType)=0;
typeRise(synType)=rsIbApicalRiseAMPA;
typeDecay(synType)=rsIbApicalDecayAMPA;

% 11: RS to IB - NMDA
synType=11;
typeVrev(synType)=0;
typeRise(synType)=rsIbApicalRiseNMDA;
typeDecay(synType)=rsIbApicalDecayNMDA;

% 12: LTS to IB
synType=12;
typeVrev(synType)=-80;
typeRise(synType)=ltsIbApicalRise;
typeDecay(synType)=ltsIbApicalDecay;

% 13: IB to FS
synType=13;
typeVrev(synType)=0;
typeRise(synType)=ibAxonBasketRise;
typeDecay(synType)=ibAxonBasketDecay;

% 14: IB to LTS
synType=14;
typeVrev(synType)=0;
typeRise(synType)=ibAxonLtsRise;
typeDecay(synType)=ibAxonLtsDecay;

% 15: IB to deepLTS
synType=15;
typeVrev(synType)=0;
typeRise(synType)=ibAxonDeepLtsRise;
typeDecay(synType)=ibAxonDeepLtsDecay;

% 16: deepLTS to IB
synType=16;
typeVrev(synType)=-80;
typeRise(synType)=deepLTSibBasalRise;
typeDecay(synType)=deepLTSibBasalDecay;

% 17: RS to next column IB = AMPA

synType=17;
typeVrev(synType)=0;
typeRise(synType)=rsNextIbApicalRiseAMPA;
typeDecay(synType)=rsNextIbApicalDecayAMPA;

% 18: RS to next column IB - NMDA
synType=18;
typeVrev(synType)=0;
typeRise(synType)=rsNextIbApicalRiseNMDA;
typeDecay(synType)=rsNextIbApicalDecayNMDA;

% 19: IB axon to IB basal
synType=19;
typeVrev(synType)=0;
typeRise(synType)=ibAxonIbBasalRise;
typeDecay(synType)=ibAxonIbBasalDecay;

% 20: IB axon to next column IB basal
synType=20;
typeVrev(synType)=0;
typeRise(synType)=ibAxonIbBasalRise; % using same as for same column
typeDecay(synType)=ibAxonIbBasalDecay; % using same as for same column
%typeDecay(synType)=ibAxonIbBasalDecay;

% 36: Deep RS to Deep FS
synType=36;
typeVrev(synType)=0;
typeRise(synType)=rsBasketRise;
typeDecay(synType)=rsBasketDecay;

% 37: Deep RS to Deep LTS
synType=37;
typeVrev(synType)=0;
typeRise(synType)=rsLtsRise;
typeDecay(synType)=rsLtsDecay;

% 38: Deep FS to Deep RS
synType=38;
typeVrev(synType)=-80;
typeRise(synType)=basketRsRise;
typeDecay(synType)=basketRsDecay;

% 39: Deep FS self-synapse
synType=39;
typeVrev(synType)=-75;
typeRise(synType)=basketBasketRise;
typeDecay(synType)=basketBasketDecay;

% 40: Deep FS to Deep LTS
synType=40;
typeVrev(synType)=-80;
typeRise(synType)=basketLtsRise;
typeDecay(synType)=basketLtsDecay;

% 41: Deep LTS to Deep RS
synType=41;
typeVrev(synType)=-80;
typeRise(synType)=ltsRsRise;
typeDecay(synType)=ltsRsDecay;

% 42: Deep LTS to FS
synType=42;
typeVrev(synType)=-80;
typeRise(synType)=ltsRsRise; % use same rise and decay constants
typeDecay(synType)=ltsRsDecay;

% 43: Deep LTS self-synapse
synType=43;
typeVrev(synType)=-80;
typeRise(synType)=ltsLtsRise;
typeDecay(synType)=ltsLtsDecay;

% 44: IB to Deep RS
synType=44;
typeVrev(synType)=0;
typeRise(synType)=ibAxonBasketRise; % Same as for FS
typeDecay(synType)=ibAxonBasketDecay;

% 45: IB to Deep FS
synType=45;
typeVrev(synType)=0;
typeRise(synType)=ibAxonBasketRise;
typeDecay(synType)=ibAxonBasketDecay;

% 46: Deep RS to IB
synType=46;
typeVrev(synType)=0;
typeRise(synType)=rsIbApicalRiseAMPA;
typeDecay(synType)=rsIbApicalDecayAMPA;

% 47: Deep FS to IB
synType=47;
typeVrev(synType)=-80;
typeRise(synType)=basketRsRise;
typeDecay(synType)=basketRsDecay;


% 51: Input - Excitatory rhythmic
synType=51;
typeVrev(synType)=0;
typeRise(synType)=0.1;
typeDecay(synType)=0.5;

% 52: Single pulse of inhibition, for turning off network
synType=52;
%typeInputSource(inputSynType)=3;
%typeGInput(inputSynType)=10;%0.5;
%typeGInput(inputSynType)=5; % test
typeVrev(synType)=-80;
typeRise(synType)=0.1;
typeDecay(synType)=inhibitoryPulse1Length; % beta1(?) time constant

% 53: Single, long pulse of excitation
synType=53;
%typeInputSource(inputSynType)=3;
%typeGInput(inputSynType)=0.3;
typeVrev(synType)=0;
typeRise(synType)=0.1;
typeDecay(synType)=10000;

% 54: Single, long pulse of inhibition
synType=54;
%typeInputSource(inputSynType)=3;
%typeGInput(inputSynType)=10;%0.5;
typeVrev(synType)=-80;
typeRise(synType)=0.1;
typeDecay(synType)=1000;

% 55: Single pulse of excitation
synType=55;
%typeInputSource(inputSynType)=7;
%typeGInput(inputSynType)=20;
typeVrev(synType)=0;
typeRise(synType)=0.1;
typeDecay(synType)=150;

% 56: Single, short pulse of inhibition, concurrently with top-down (beta2) input
synType=56;
typeVrev(synType)=-80;
typeRise(synType)=0.1;
typeDecay(synType)=30;

% 57: Single pulse of inhibition, for temporarily turning off SI
synType=57;
%typeInputSource(inputSynType)=3;
%typeGInput(inputSynType)=10;%0.5;
%typeGInput(inputSynType)=5; % test
typeVrev(synType)=-80;
typeRise(synType)=0.1;
%typeDecay(synType)=150;
typeDecay(synType)=inhibitoryPulse2Length;

% % 58: Single pulse of excitation
% synType=58;
% %typeInputSource(inputSynType)=7;
% %typeGInput(inputSynType)=20;
% typeVrev(synType)=-80;
% typeRise(synType)=0.1;
% typeDecay(synType)=30;