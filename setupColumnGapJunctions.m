gApicalToSoma=0.4;
gBasalToSoma=0.4;
gAxonToSoma=0.3;

gSomaToApical=0.2;
gSomaToBasal=0.2;
gSomaToAxon=0.3;

ibGapStrength=0.0025;

%ibGapStrength=0.02; % test

rsGapStrength=0.01;

ltsGapStrength=0.2;

for i=1:colNumLTS
    cell1=LTS(col,i);
    for j=1:colNumLTS
        cell2=LTS(col,j);
        [r, s, t]=addGapJunction(r,s,t,cell1,cell2,ltsGapStrength);
    end
end

if synapticBeta
    for i=1:colNumDeepLTS
        cell1=deepLTS(col,i);
        for j=1:colNumDeepLTS
            cell2=deepLTS(col,j);
            [r, s, t]=addGapJunction(r,s,t,cell1,cell2,ltsGapStrength);
        end
    end
end

for i=1:colNumIB
    cell1=IBaxon(col,i);
    for j=1:colNumIB
        cell2=IBaxon(col,j);
        [r, s, t]=addGapJunction(r,s,t,cell1,cell2,ibGapStrength);
    end
end

for i=1:colNumIB
    apical=IBapical(col,i);
    basal=IBbasal(col,i);
    soma=IBsoma(col,i);
    axon=IBaxon(col,i);
    
    [r, s, t]=addGapJunction(r,s,t,apical,soma,gApicalToSoma); % Apical to soma
    [r, s, t]=addGapJunction(r,s,t,basal,soma,gBasalToSoma); % Basal to soma
    [r, s, t]=addGapJunction(r,s,t,axon,soma,gAxonToSoma); % Axon to soma
    [r, s, t]=addGapJunction(r,s,t,soma,apical,gSomaToApical); % Soma to apical
    [r, s, t]=addGapJunction(r,s,t,soma,basal,gSomaToBasal); % Soma to bascal
    [r, s, t]=addGapJunction(r,s,t,soma,axon,gSomaToAxon); % Soma to axon    
end