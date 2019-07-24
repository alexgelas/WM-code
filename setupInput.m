tempNumInputSynapses=1000;

r=zeros(tempNumInputSynapses,1); s=zeros(tempNumInputSynapses,1); t=zeros(tempNumInputSynapses,1); u=zeros(tempNumInputSynapses,1);

displayInputGamma=0;
displayInputGamma2=0;
displayInputBeta=0;
displayInputTonicSI=0;
displayInputTonicIB=0;

if gammaInput
%    displayInput=i;
    for col=1:numColumns
        for jj=1:colNumRS/4+0.99
            cell1=RS(col,jj);
            [r, s, t, u]=addInputSynapse(r,s,t,u,6,cell1,51,30); % Weak gamma to RS
        end
        for jj=1:colNumFS
            cell1=FS(col,jj);
            [r, s, t, u]=addInputSynapse(r,s,t,u,6,cell1,51,0.1); % Weak gamma to RS
        end
    end
    displayInputGamma=find(r>0,1,'last');
end

if gammaInput2
    for col=1:min(numColumns,maxColsGammaInput2)
        for jj=1:colNumRS/4+0.99
        %for i=1:colNumRS
            cell1=RS(col,jj);
            [r, s, t, u]=addInputSynapse(r,s,t,u,7,cell1,51,30); % Weak gamma to RS
        end
        for jj=1:colNumFS
            cell1=FS(col,jj);
            [r, s, t, u]=addInputSynapse(r,s,t,u,7,cell1,51,0.1); % Weak gamma to RS
        end
    end
    displayInputGamma2=find(r>0,1,'last');
end

if turnOffBeta
    for col=1:numColumns
        if strcmp(turnOffTarget,'IB')
            for jj=1:colNumIB
                cell1=IBapical(col,jj);
                [r, s, t, u]=addInputSynapse(r,s,t,u,2,cell1,52,turnOffAmp); % Single pulse of inhibition
            end
        elseif strcmp(turnOffTarget,'RS')
            for jj=1:colNumRS
                cell1=RS(col,jj);
                [r, s, t, u]=addInputSynapse(r,s,t,u,2,cell1,52,turnOffAmp); % Single pulse of inhibition
            end
        else
            warning('Invalid turn off target')
        end
    end
    displayInputTonicIB=find(r>0,1,'last');
end

for col=1:numColumns
    inhibTemp=rand();
    for jj=1:colNumRS%/4+0.99
        cell1=RS(col,jj);
        %[r s t u]=addInputSynapse(r,s,t,u,7,cell1,55,30); % Initial excitatory pulse
        %[r, s, t, u]=addInputSynapse(r,s,t,u,10+col,cell1,55,0.2); % Initial excitatory pulse
        %if ~temporalBottomUp
        [r, s, t, u]=addInputSynapse(r,s,t,u,20+col,cell1,56,1/5*exp(6*inhibTemp)); % Initial inhibitory pulse

%         if numColumns>2
%             [r, s, t, u]=addInputSynapse(r,s,t,u,20+col,cell1,56,1/10*exp(6*inhibTemp)); % Initial inhibitory pulse
%         else
%             [r, s, t, u]=addInputSynapse(r,s,t,u,20+col,cell1,56,1/20*exp(3*inhibTemp)); % Initial inhibitory pulse
%         end
            
        %end
    end
    for jj=1:colNumIB
        if ~lastColLessExc || col<(numColumns+1)/2 % November '18
            cell1=IBsoma(col,jj);
            [r, s, t, u]=addInputSynapse(r,s,t,u,10+col,cell1,55,0.15); % Initial excitatory pulse
        end
    end
%     inhibTemp=rand();
%     for i=1:colNumIB
%         cell1=IBsoma(col,i);
%         if numColumns>2
%             [r, s, t, u]=addInputSynapse(r,s,t,u,20+col,cell1,56,1/20*exp(inhibTemp/2)); % Initial excitatory pulse
%         end
%     end
end

if beta2input
    for col=1:min(numColumns,numMaxColsInput)
        if ~mixedTopDown || col<(numColumns+1)/4 || (col>(numColumns+1)/2 && col<3*(numColumns+1)/4)
            %             for i=1:colNumRS/4+0.99;
            %                 cell1=RS(col,i);
            %                 %[r s]=addInputSynapse(r,s,cell1,10);
            %                 [r s t u]=addInputSynapse2(r,s,t,u,4,cell1,51,3);
            %             end
            for jj=1:colNumIB
                cell1=IBbasal(col,jj);
                [r, s, t, u]=addInputSynapse(r,s,t,u,4,cell1,51,3);
            end
            displayInputBeta=find(r>0,1,'last');
            
            % The following are unused
            if topDownTurnOffFS
                for jj=1:colNumFS;
                    cell1=FS(col,jj);
                    [r, s, t, u]=addInputSynapse(r,s,t,u,3,cell1,56,160);
                end
            end
        end
    end
end

% if tonicInputExcIB
%     for col=1:numColumns
%         for jj=1:colNumIB
%             cell1=IBbasal(col,jj);
%             [r, s, t, u]=addInputSynapse(r,s,t,u,5,cell1,55,1);
%         end
%     end
%     displayInputTonicExcIB=find(r>0,1,'last');
% end

if turnOffSI
    for col=1:numColumns
        for jj=1:colNumLTS
            cell1=LTS(col,jj);
            % gMax was 10 till May 10th 2018
            %[r, s, t, u]=addInputSynapse(r,s,t,u,5,cell1,57,10);
            [r, s, t, u]=addInputSynapse(r,s,t,u,5,cell1,57,7);
        end
    end
    displayInputTonicSI=find(r>0,1,'last');
end

numInputSynapses=find(r>0,1,'last');

if isempty(numInputSynapses)
    [r, s, t, u]=addInputSynapse(r,s,t,u,1,1,55,0); % dummy, does nothing
    numInputSynapses=1;
end

inputSource=r(1:numInputSynapses);
inputTarget=s(1:numInputSynapses);
inputSynapseType=t(1:numInputSynapses);
gInput=u(1:numInputSynapses);