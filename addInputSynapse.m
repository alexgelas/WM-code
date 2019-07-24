function [inputSource, inputTarget, inputSynapseType, inputGmax]=addInputSynapse(inputSource,inputTarget,inputSynapseType,inputGmax,newSource,newTarget,newType,newGmax)

inputSynapseIndex=find(inputTarget==0,1,'first');
inputSource(inputSynapseIndex)=newSource;
inputTarget(inputSynapseIndex)=newTarget;
inputSynapseType(inputSynapseIndex)=newType;
inputGmax(inputSynapseIndex)=newGmax;