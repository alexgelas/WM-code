inputV=expDecay(inputV,-70,1,dt);

if temporalBottomUp
    if i>tonicBottomUpStart/largeDt% && i<(tonicBottomUpStart+50)/largeDt
        if numColumns==1
            warning('Only one column. I do not change anything at time tonicBottomUpStart')
        else
            for col=2:numColumns
                for jj=1:colNumRS
                    cell1=RS(col,jj);
                    Itonic(cell1)=Itonic(cell1)+(Itonic(RS(1,1))-Itonic(cell1))*largeDt/50;
                    %Itonic(cell1)=Itonic(cell1)-ItonicDiff*largeDt/50;
                end
            end
        end
    end
end

if tonicInputExcIBstep
    if mod(i,tonicInputExcIBstart/largeDt)<1
        for col=1:numColumns
            for jj=1:colNumIB
                cell1=IBbasal(col,jj);
                Itonic(cell1)=Itonic(cell1)-10;
            end
        end
    end
    if mod(i,tonicInputExcIBstop/largeDt)<1
        for col=1:numColumns
            for jj=1:colNumIB
                cell1=IBbasal(col,jj);
                Itonic(cell1)=Itonic(cell1)+10;
            end
        end
    end
end

% Unused
if tonicInputExcIB
    if i>tonicInputExcIBstart/largeDt && i<(tonicInputExcIBstart+50)/largeDt% || i==650/largeDt
        tempRate=1/2.5;
        for col=1:numColumns
            for jj=1:colNumIB
                cell1=IBbasal(col,jj);
                Itonic(cell1)=Itonic(cell1)-largeDt*tempRate;
                %Itonic(cell1)=Itonic(cell1)-ItonicDiff*largeDt/50;
            end
        end
    end
    if i>(tonicInputExcIBstop-50)/largeDt && i<tonicInputExcIBstop/largeDt% || i==650/largeDt
        tempRate=1/2.5;
        for col=1:numColumns
            for jj=1:colNumIB
                cell1=IBbasal(col,jj);
                Itonic(cell1)=Itonic(cell1)+largeDt*tempRate;
                %Itonic(cell1)=Itonic(cell1)-ItonicDiff*largeDt/50;
            end
        end
    end
end

if reduceRStonic
    if i>300/largeDt && i<800/largeDt% || i==650/largeDt
        for col=1:numColumns
            for jj=1:colNumRS
                cell1=RS(col,jj);
                Itonic(cell1)=Itonic(cell1)+largeDt*1/20;
            end
        end
    end
end

if reduceIBtonic
    if i>300/largeDt && i<800/largeDt% || i==650/largeDt
        for col=1:numColumns
            for jj=1:colNumIB
                tempRate=1/20;
                cell1=IBapical(col,jj);
                Itonic(cell1)=Itonic(cell1)+largeDt*tempRate;
                cell1=IBbasal(col,jj);
                Itonic(cell1)=Itonic(cell1)+largeDt*tempRate;
                cell1=IBsoma(col,jj);
                Itonic(cell1)=Itonic(cell1)+largeDt*tempRate*0.5;
                cell1=IBaxon(col,jj);
                Itonic(cell1)=Itonic(cell1)+largeDt*tempRate*0.25;
            end
        end
    end
end

% if i==1/largeDt% || i==650/largeDt
%     inputV(7)=100;
% end

for col=1:numColumns
    %if i==(col*15+5)/largeDt;
    if i==ceil(colStartIB(col)/largeDt);
        inputV(10+col)=100;
    end
end

for col=1:numColumns
    if i==1 %i==(col*15+5)/largeDt;
        inputV(20+col)=100;
    end
end



if mod(i,nextInp6/dt)<1
    inputV(6)=inputV(6)+100;
    nextInp6=nextInp6+(1-gammaJitter)*1000/gammaFreq+2*gammaJitter*1000/gammaFreq*rand(1);
    %nextInp6=nextInp6+1*1000/45+0*1000/45*rand(1);
end

if i>=startGamma2/dt && i<endGamma2/dt 
    inputV(7)=inputV(6);
end

if i==305/largeDt% || i==650/largeDt
    inputV(3)=100;
end

if i-nextInp4/dt>=0 && i-nextInp4/dt<1
    if i*dt>=topDownStart && i*dt<topDownStart+topDownDuration % nextInp4 starts at topDownStart, see file "initialize.m"
    %if i*dt>300 && i*dt<360 % test
        inputV(4)=inputV(4)+100;
        nextInp4=nextInp4+0.9*1000/beta2Freq+0.2*1000/beta2Freq*rand(1);
        %nextInp4=nextInp4+1*1000/beta2Freq+0*1000/beta2Freq*rand(1);
    end
end

%inputV(2) is activated once at (inhibitoryPulse1Start) ms and then decays exponentially
%inputV(5) is activated once at (inhibitoryPulse2Start) ms and then decays exponentially

if i==inhibitoryPulse1Start/largeDt% || i==650/largeDt
    inputV(2)=100;
end

if i==inhibitoryPulse2Start/largeDt% || i==650/largeDt
    inputV(5)=100;
end

noiseFactor=expDecay(noiseFactor,1,50,largeDt);


% Unused (I think)
if mod(i,1000/(gammaFreq*dt))<1
    inputV(8)=inputV(8)+100;
end

if mod(i,1000/(beta1Freq*dt))<1
    inputV(9)=inputV(9)+100;
end