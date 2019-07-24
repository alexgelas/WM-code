function [Vrev, rise, decay]=setupSynapses(synapseType,typeVrev,typeRise,typeDecay)

% Produces a list of synapses in the network, specifying the strength, the reversal potential and the rise
% and decay constants.

numSynapses=length(synapseType);

%gSyn=zeros(numSynapses,1); % Synaptic strength
Vrev=zeros(numSynapses,1); % Reversal potential
rise=ones(numSynapses,1); % Rise time constant
decay=ones(numSynapses,1); % Decay time constant

for i=1:numSynapses
%    gSyn(i)=typeGSyn(synapseType(i));
    Vrev(i)=typeVrev(synapseType(i));
    rise(i)=typeRise(synapseType(i));
    decay(i)=typeDecay(synapseType(i));
end