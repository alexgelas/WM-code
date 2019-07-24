for i=1:colNumRS
    cell1=RS(col,i);

    index=randperm(colNumRS);
    %numRStoRS=min(5,numRS);
    %numRStoRS=min(40,colNumRS); % Used till June 14th 2018
    numRStoRS=min(80,colNumRS); % From June 14th 2018
    for j=1:numRStoRS
        cell2=RS(col,index(j));
        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,1,0.5/numRStoRS); % changed May 21st 2018
        %if cell1==cell2 % Removed on June 14th 2018
            % do nothing;
        %else
            % [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,1,0.5/numRStoRS); % changed May 21st 2018
        %end
    end

    index=randperm(colNumFS);
    %numRStoFS=min(10,numFS);
    numRStoFS=min(20,colNumFS);
    for j=1:numRStoFS
        cell2=FS(col,index(j));
        %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,2,1/numRStoFS); % RS to FS - Old usual value: 1
        
        % May 21st 2018 - stick to it
        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,2,0.5/numRStoFS); % RS to FS

        %warning('Strong RS to FS') % May 30th 2018, change back
        %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,2,2/numRStoFS); % RS to FS % test May 15th 2018
    end

    index=randperm(colNumLTS);
    %numRStoLTS=min(10,numLTS);
    numRStoLTS=min(20,colNumLTS);
    for j=1:numRStoLTS
        cell2=LTS(col,index(j));
        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,3,4.5/numRStoLTS); % RS to LTS
    end

    if separateLayers==0
        index=randperm(colNumIB);
        numRStoIB=min(3,colNumIB);
        %numRStoIB=min(20,numIB);
        for j=1:numRStoIB
            cell2=IBapical(col,index(j));
            
            %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,10,0.1/numRStoIB); % RS to IB - AMPA
            %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,11,0.025/numRStoIB); % RS to IB - NMDA
            
            [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,10,0.05/numRStoIB); % RS to IB - AMPA
            [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,11,0.0125/numRStoIB); % RS to IB - NMDA
            
            
            %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,10,0.01/numRStoIB); % RS to IB - AMPA
            %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,11,0.0125/numRStoIB); % RS to IB - NMDA
        end
    end
end

for i=1:colNumFS
    cell1=FS(col,i);

    %numFStoRS=min(20,colNumRS);
    numFStoRS=min(80,colNumRS); % test May 15th 2018
    index=randperm(colNumRS);
    for j=1:numFStoRS
        cell2=RS(col,index(j));
        %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,4,1000/numFStoRS); % FS to RS - test May 15th 2018
        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,4,500/numFStoRS); % FS
        %to RS - usual value
    end

    %numFStoFS=min(10,numFS);
    numFStoFS=min(20,colNumFS);
    index=randperm(colNumFS);
    for j=1:numFStoFS
        cell2=FS(col,index(j));
        %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,5,20/numFStoFS); % FS to FS - correct is 20
        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,5,40/numFStoFS); % FS to FS - test
    end

    %numFStoLTS=min(5,numLTS);
    numFStoLTS=min(20,colNumLTS);
    index=randperm(colNumLTS);
    for j=1:numFStoLTS
        cell2=LTS(col,index(j));
        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,6,8/numFStoLTS); % FS to LTS
    end

end


for i=1:colNumLTS
    cell1=LTS(col,i);

    %numLTStoRS=min(20,numRS);
    numLTStoRS=min(80,colNumRS);
    index=randperm(colNumRS);
    for j=1:numLTStoRS
        cell2=RS(col,index(j));
        % Correct is 2.5
        %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,7,2.5/numLTStoRS); % LTS to RS
                
        % Usual value 10
        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,7,10/numLTStoRS); % LTS to RS
        
        %test May 15th 2018
        %[r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,7,50/numLTStoRS); % LTS to RS 
    end

    %[r s t u]=addSynapse(r,s,t,u,cell1,cell1,9,5); % LTS self-synapse -

    % test
    [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell1,9,7); % LTS self-synapse -
    %According to the literature, there are no SOM-SOM synapses

    %numLTStoFS=min(10,numFS);
    numLTStoFS=min(20,colNumFS);
    index=randperm(colNumFS);
    for j=1:numLTStoFS
        cell2=FS(col,index(j));
        [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,8,4/numLTStoFS); % LTS to FS
    end

    if separateLayers==0
        %numLTStoIB=min(5,numIB);
        numLTStoIB=min(20,colNumIB);
        index=randperm(colNumIB);
        for j=1:numLTStoIB
            cell2=IBapical(col,index(j));
            %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,12,4/numLTStoIB); %
            %LTS to IB - correct is 4
            [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,12,8/numLTStoIB); % LTS to IB - test
            %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,12,12/numLTStoIB); % LTS to IB - test
        end
    end

end


for i=1:colNumIB
    cell1=IBaxon(col,i);

    if separateLayers==0
        %numIBtoFS=min(20,numFS);
        numIBtoFS=min(20,colNumFS);
        index=randperm(colNumFS);
        for j=1:numIBtoFS
            cell2=FS(col,index(j));
            [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,13,4/numIBtoFS); % IB to FS - Correct is 4
        end
        
        %numIBtoLTS=min(5,numLTS);
        numIBtoLTS=min(20,colNumLTS);
        index=randperm(colNumLTS);
        for j=1:numIBtoLTS
            cell2=LTS(col,index(j));
            [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,14,0.9/numIBtoLTS); % IB to LTS
            %[r s t u]=addSynapse(r,s,t,u,cell1,cell2,14,1.5/numIBtoLTS); % test
        end
    end
    if synapticBeta==false
        %numIBtoIB=min(5,numIB);
        numIBtoIB=min(20,colNumIB);
        index=randperm(colNumIB);
        for j=1:numIBtoIB
            cell2=IBbasal(col,index(j));
            %if cell1==cell2
            [r, s, t, u]=addSynapse(r,s,t,u,cell1,cell2,19,0.04/numIBtoIB); % IB axon to IB basal
            %else
            %    [r s t u]=addSynapse(r,s,t,u,cell1,cell2,19,0.8/numIBtoIB); % IB axon to IB basal
            %end
        end
    end
end