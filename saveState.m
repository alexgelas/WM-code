if max(V)==inf
    error('infinite V')
end
if mod(i,saveStep)==0
    ii=i/saveStep;
    
    fullV(:,ii)=V;
    %         fullI(:,ii)=I;
    %         fullH(:,ii)=h;
    %         fullM(:,ii)=m;
    if mathNet
        fullMAR(:,ii)=mAR;
        fullMKM(:,ii)=mKM;
    end
    %         fullMCaH(:,ii)=mCaH;
    %
    %         fullJ(:,ii)=J;
    %         fullSynapses(:,ii)=s;
    %         fullIgap(:,ii)=Igap;
    %         fullIsyn(:,ii)=Isyn;
    fullInputV(:,ii)=inputV;
    fullSInput(:,ii)=sInput;
    %         %fullIinput(:,ii)=Iinput;
end