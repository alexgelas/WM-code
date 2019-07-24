if mathNet
    numPoisson=0;
else
    numPoisson=numCells;
end
postPoisson=1:numPoisson;
gPoisson=0*ones(numPoisson,1);

if ~mathNet
    for col=1:numColumns
        for i=1:colNumRS
            cell=RS(col,i);
            gPoisson(cell)=0.03; % May 20th 2018
            %if lastColLessExc && ~beta2input % Nov '18 update
            if lastColLessExc % Nov '18 update    
                if col>=(numColumns+1)/2 % Second half of columns
                    gPoisson(cell)=0.17; % Nov '18
                end
            end
        end
        for i=1:colNumIB
            if morePoisson
                cell=IBapical(col,i);
                gPoisson(cell)=0.005;
                cell=IBbasal(col,i);
                gPoisson(cell)=0.005;
            end
            %gPoisson(cell)=0.01;
            %gPoisson(cell)=0.0005;
            
            %gPoisson(cell)=0.01;
            %gPoisson(cell)=0.0005;
        end
    end
end
VrevPoisson=0*ones(numPoisson,1);
decayPoisson=4*ones(numPoisson,1);
%lambdaPoisson=1*ones(numPoisson,1); % usual value: 1
lambdaPoisson=0.1*ones(numPoisson,1); % test May 21st 2018