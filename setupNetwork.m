%paramNetwork == 28 % Two columns of many cells, no connections between them.
   
cellNumbering;

ItonicOffset=zeros(numCells,1);

for col=1:numColumns;
    for i=1:colNumRS
        cell1=RS(col,i);
        %ItonicOffset(cell1)=31; % For large network
        
        if colNumRS>1 && numColumns<=2
            %ItonicOffset(cell1)=27; % Usual value 27
            %ItonicOffset(cell1)=25; % June 12th 2018
            %ItonicOffset(cell1)=23; % June 16th 2018
            ItonicOffset(cell1)=24; % June 20th 2018
        elseif colNumRS>1 && numColumns>2
            %ItonicOffset(cell1)=27;
            %ItonicOffset(cell1)=25; % June 12th 2018
            %ItonicOffset(cell1)=23; % June 16th 2018
            ItonicOffset(cell1)=24; % June 20th 2018
        elseif colNumRS==1 && numColumns>2
            warning('case not predicted'); % test
            ItonicOffset(cell1)=4; % ??
        else % colNumRS==1 and numColumns==1
            ItonicOffset(cell1)=10;
            %ItonicOffset(cell1)=20; % test
        end
    end
    
    if temporalBottomUp
        ItonicDiff=40;
        if col>1
            for i=1:colNumRS
                cell1=RS(col,i);
                %ItonicOffset(cell1)=ItonicOffset(cell1)+22;
                ItonicOffset(cell1)=ItonicOffset(cell1)+ItonicDiff; % May 21st 2018
            end
        end
    end
    
    %warning('Changing FS tonic current')
    %ItonicOffset(FS)=ItonicOffset(FS)-5; % May 30th 2018 - Delete this
    
    for i=1:colNumLTS
        cell1=LTS(col,i);
        ItonicOffset(cell1)=15;
        %ItonicOffset(cell1)=45; % May 30th - change back!
    end
    
    if hyperpolLTS
        for i=1:colNumLTS
            cell1=LTS(col,i);
            ItonicOffset(cell1)=1000;
        end
    end
    
    % For large network
    
    %%%%% % For many columns
    
    for i=1:colNumIB
        cell1=IBapical(col,i);
        ItonicOffset(cell1)=2;
        cell1=IBbasal(col,i);
        ItonicOffset(cell1)=2;
        cell1=IBsoma(col,i);
        ItonicOffset(cell1)=1;
        cell1=IBaxon(col,i);
        ItonicOffset(cell1)=0.5;
    end
    
    if FSmoreExcitable
        for i=1:colNumFS
            cell1=FS(col,i);
            ItonicOffset(cell1)=ItonicOffset(cell1)-20;
        end
    elseif FSlessExcitable
        for i=1:colNumFS
            cell1=FS(col,i);
            ItonicOffset(cell1)=ItonicOffset(cell1)+80; % even this is not enough. Higher values produce numerical problems, need to decrease simulation step size?
        end
    end
    
    if RSmoreExcitable
        for i=1:colNumRS
            cell1=RS(col,i);
            ItonicOffset(cell1)=ItonicOffset(cell1)-20;
        end
    elseif RSmuchLessExcitable
        if col==1
            for i=1:colNumRS
                cell1=RS(col,i);
                ItonicOffset(cell1)=ItonicOffset(cell1)+50;
            end
        elseif col==2
            for i=1:colNumRS
                cell1=RS(col,i);
                ItonicOffset(cell1)=ItonicOffset(cell1)+10;
            end
%         elseif col==3
%             for i=1:colNumRS
%                 cell1=RS(col,i);
%                 ItonicOffset(cell1)=ItonicOffset(cell1)+10;
%             end
        end
    elseif RSlessExcitable
        if col==1
            for i=1:colNumRS
                cell1=RS(col,i);
                ItonicOffset(cell1)=ItonicOffset(cell1)+15;
            end
        end
    end
    if lastColLessExc % Nov '18 update
        if col>=(numColumns+1)/2 % Second half of columns
            for i=1:colNumRS
                cell1=RS(col,i);
                ItonicOffset(cell1)=ItonicOffset(cell1)+40;
            end
        end
    end
        
    if IBmoreExcitable
        for i=1:colNumIB
            cell1=IBapical(col,i);
            ItonicOffset(cell1)=ItonicOffset(cell1)-1*IBmoreExcFactor;
            cell1=IBbasal(col,i);
            ItonicOffset(cell1)=ItonicOffset(cell1)-1*IBmoreExcFactor;
            cell1=IBsoma(col,i);
            ItonicOffset(cell1)=ItonicOffset(cell1)-0.5*IBmoreExcFactor;
            cell1=IBaxon(col,i);
            ItonicOffset(cell1)=ItonicOffset(cell1)-0.25*IBmoreExcFactor;
        end
    elseif IBmuchLessExcitable
        if col==1
            for i=1:colNumIB
                cell1=IBapical(col,i);
                ItonicOffset(cell1)=32;
                cell1=IBbasal(col,i);
                ItonicOffset(cell1)=32;
                cell1=IBsoma(col,i);
                ItonicOffset(cell1)=8;
                cell1=IBaxon(col,i);
                ItonicOffset(cell1)=4;
            end
        elseif col==2
            for i=1:colNumIB
                cell1=IBapical(col,i);
                ItonicOffset(cell1)=16;
                cell1=IBbasal(col,i);
                ItonicOffset(cell1)=16;
                cell1=IBsoma(col,i);
                ItonicOffset(cell1)=4;
                cell1=IBaxon(col,i);
                ItonicOffset(cell1)=2;
            end
        end
    elseif IBlessExcitable
        for i=1:colNumIB
            cell1=IBapical(col,i);
            ItonicOffset(cell1)=16;
            cell1=IBbasal(col,i);
            ItonicOffset(cell1)=16;
            cell1=IBsoma(col,i);
            ItonicOffset(cell1)=4;
            cell1=IBaxon(col,i);
            ItonicOffset(cell1)=2;
        end
    end
end

tempNumSynapses=numColumns*20000; % an upper bound


r=zeros(tempNumSynapses,1); s=zeros(tempNumSynapses,1); t=zeros(tempNumSynapses,1); u=zeros(tempNumSynapses,1);

for col=1:numColumns;
    setupColumnConnections;
end

% Intercolumnar RS-RS
numRStoNextColRS=min(20,colNumRS);

if connectColumns
    numColumnsConnected=min(100,numColumns);
    
    for col1=1:numColumnsConnected
        for i=1:colNumRS
            cell1=RS(col1,i);
            for col2=1:numColumnsConnected
                if col1~=col2
                    index=randperm(colNumRS);
                    for j=1:numRStoNextColRS;
                        cell2=RS(col2,index(j));
                        %[r, s, t,u]=addSynapse(r,s,t,u,cell1,cell2,1,1/(numRStoNextColRS*numColumnsConnected-1)); % RS to RS of next column
                        % Changed May 18th 2018 - Previous value was 1/...
                        %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,1,1.2/(numRStoNextColRS*numColumnsConnected-1)); % test March '18
                        % May 22nd 2018
                        %[r, s, t,u]=addSynapse(r,s,t,u,cell1,cell2,1,1/(numRStoNextColRS*(numColumnsConnected-1))); % RS to RS of next column                        
                        % June 16th 2018
                        %[r, s, t,u]=addSynapse(r,s,t,u,cell1,cell2,1,1/(numRStoNextColRS*(numColumnsConnected-1))); % RS to RS of next column
                        % June 28th 2018
                        %[r, s, t,u]=addSynapse(r,s,t,u,cell1,cell2,1,0.3/(numRStoNextColRS*(numColumnsConnected-1))); % RS to RS of next column
                        % June 29th 2018
                        [r, s, t,u]=addSynapse(r,s,t,u,cell1,cell2,1,0.3/(numRStoNextColRS*(numColumnsConnected-1))); % RS to RS of next column
                    end
                end
            end
        end
    end
    
    % Intercolumnar IB-IB
    numIBtoNextColIB=min(20,colNumIB);
    
    for col1=1:numColumnsConnected
        for i=1:colNumIB
            cell1=IBaxon(col1,i);
            for col2=1:numColumnsConnected
                if col1~=col2% && true
                    index=randperm(colNumIB);
                    for j=1:numIBtoNextColIB;
                        cell2=IBbasal(col2,index(j));
                        %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,20,0.25/(numIBtoNextColIB*numColumns-1));
                        % May 22nd 2018:
                        %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,20,0.1/(numIBtoNextColIB*(numColumnsConnected-1)));
                        % June 28th 2018:
                        %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,20,0.3/(numIBtoNextColIB*(numColumnsConnected-1)));
                        % June 29th 2018:
                        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,20,0.3/(numIBtoNextColIB*(numColumnsConnected-1)));
                    end
                end
            end
        end
    end
end

if temporalBottomUp
    numIBtoNextColIB=min(5,colNumIB);

    if numColumns==1
        warning('No columns to connect')
    else
        for col=1:numColumns-1
            for i=1:colNumIB
                cell1=IBaxon(col,i);
                index=randperm(colNumIB);
                for j=1:numIBtoNextColIB;
                    cell2=IBbasal(col+1,index(j));
                    %[r, s, t,
                    %u]=addSynapse(r,s,t,u,cell1,cell2,20,0.5/numIBtoNextColIB);
                    % Until June 14th 2018
                    %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,20,0.3/numIBtoNextColIB); % From June 14th 2018
                    %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,20,0.2/numIBtoNextColIB); % From June 22nd 2018
                    [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,20,0.3/numIBtoNextColIB); % From June 24th 2018
                end
            end
        end
    end
end

numSynapses=find(r>0,1,'last');
preSyn=r(1:numSynapses);
postSyn=s(1:numSynapses);
synapseType=t(1:numSynapses);
gSyn=u(1:numSynapses);

tempNumGapJunctions=10000;

r=zeros(tempNumGapJunctions,1); s=zeros(tempNumGapJunctions,1); t=zeros(tempNumGapJunctions,1);

for col=1:numColumns;
    setupColumnGapJunctions;
end

numGapJunctions=find(r>0,1,'last');
preGap=r(1:numGapJunctions);
postGap=s(1:numGapJunctions);
gGap=t(1:numGapJunctions);
%gapJunctionType=t(1:numGapJunctions);

