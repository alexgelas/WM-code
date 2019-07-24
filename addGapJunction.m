function [preGap, postGap, gGap]=addGapJunction(preGap,postGap,gGap,newPreGap,newPostGap,newGgap)

gapIndex=find(preGap==0,1,'first');
if isempty(gapIndex)
    error('Not enough space for new gap junction.')
end
preGap(gapIndex)=newPreGap;
postGap(gapIndex)=newPostGap;
%gapJunctionType(gapIndex)=newGapType;
gGap(gapIndex)=newGgap;