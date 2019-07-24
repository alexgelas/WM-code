if fourTimesRS
    colNumRS=numCellsBase*4;
else
    colNumRS=numCellsBase;
end

colNumFS=numCellsBase;
colNumLTS=numCellsBase;
colNumIB=numCellsBase;

colNumCells=colNumRS+colNumFS+colNumLTS+4*colNumIB;

numRS=numColumns*colNumRS; % these are needed for the (old) setupInputGabaBSynapses
numFS=numColumns*colNumFS;
numLTS=numColumns*colNumLTS;
numIB=numColumns*colNumIB;

numCells=numColumns*colNumCells;

RS=zeros(numColumns,colNumRS);
FS=zeros(numColumns,colNumFS);
LTS=zeros(numColumns,colNumLTS);
IBapical=zeros(numColumns,colNumIB);
IBbasal=zeros(numColumns,colNumIB);
IBsoma=zeros(numColumns,colNumIB);
IBaxon=zeros(numColumns,colNumIB);

cellType=zeros(numCells,1);

cellIndex=0;
for col=1:numColumns
    for i=1:colNumRS
        cellIndex=cellIndex+1;
        RS(col,i)=cellIndex;
        cellType(cellIndex)=1;
    end
    for i=1:colNumFS
        cellIndex=cellIndex+1;
        FS(col,i)=cellIndex;
        cellType(cellIndex)=2;
    end
    for i=1:colNumLTS
        cellIndex=cellIndex+1;
        LTS(col,i)=cellIndex;
        cellType(cellIndex)=3;
    end
    for i=1:colNumIB
        cellIndex=cellIndex+1;
        IBapical(col,i)=cellIndex;
        cellType(cellIndex)=4;
    end
    for i=1:colNumIB
        cellIndex=cellIndex+1;
        IBbasal(col,i)=cellIndex;
        cellType(cellIndex)=5;
    end
    for i=1:colNumIB
        cellIndex=cellIndex+1;
        IBsoma(col,i)=cellIndex;
        cellType(cellIndex)=6;
    end
    for i=1:colNumIB
        cellIndex=cellIndex+1;
        IBaxon(col,i)=cellIndex;
        cellType(cellIndex)=7;
    end
end