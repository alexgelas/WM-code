filepath='turnOffBeta-RS-excIB';
saveRast=true;

defaultParams; % call first to set parameters not set below

numCellsBase=20;

turnOffBeta=1;
inhibitoryPulse1Start=500;
inhibitoryPulse1Length=120;
turnOffTarget='RS';
turnOffAmp=2;

IBmoreExcitable=true;
IBmoreExcFactor=2;

numSims=10;
clear('fullVall');
clear('fullSInputAll');

for sim=1:numSims
    sim
    networkSim;
    fullVall(:,:,sim)=fullV;
    fullSInputAll(:,:,sim)=fullSInput;
    rastFig=figure(sim);
    clf
    hold on
    rastergram;
    drawnow;
    fullFilepath=strcat(folder,'/',filepath);
    if saveOutput
        saveRastergram(folder,filepath,rastFig,sim)
        %saveas(rastFig,strcat(fullFilepath,'-rastergram-',int2str(sim)),'fig');
        %saveas(rastFig,strcat(fullFilepath,'-rastergram-',int2str(sim)),'png');
    end
end

if saveOutput
    save(strcat(fullFilepath,'.mat'),'fullVall','fullSInputAll','displayInputBeta','displayInputGamma','displayInputGamma2','inhibitoryPulse1Start','inhibitoryPulse1Length','turnOffTarget','turnOffAmp');
end

% fullFilepath=strcat(folder,'/',filepath);
% if saveRast
%     saveas(rastFig,fullFilepath,'fig');
%     saveas(rastFig,fullFilepath,'png');
% %    save(strcat(fullFilepath,'.mat'),'relativeMeanFreqs','relativeDevFreqs')
% end