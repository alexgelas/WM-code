function [preSyn, postSyn, synapseType, gMax]=addSynapse(preSyn,postSyn,synapseType,gMax,newPre,newPost,newType,newGmax)

synapseIndex=find(preSyn==0,1,'first');
if isempty(synapseIndex)
    error('not enough space to add synapses');
end
preSyn(synapseIndex)=newPre;
postSyn(synapseIndex)=newPost;
synapseType(synapseIndex)=newType;
gMax(synapseIndex)=newGmax;
%if newGmax==0
    %gMax(synapseIndex)=???
%else
    %gMax(synapseIndex)=newGmax;
%end