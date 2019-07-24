function J=calcJ(V,synToPost,gSyn,s,Vrev,postSyn,gapToPost,gGap,preGap,postGap,inputToPost,gInput,sInput,inputVrev,inputTarget,noiseIntensity,sPoisson,noiseFactor,sPoissonToPost,VrevPoisson,gPoisson,postPoisson,Itonic,dt)

Isyn=synToPost*(gSyn.*s.*(V(postSyn)-Vrev));
Igap=gapToPost*(gGap.*(V(postGap)-V(preGap)));
Iinput=inputToPost*(gInput.*sInput.*(V(inputTarget)-inputVrev));
numCells=length(noiseIntensity);
Inoise=0.01*noiseIntensity.*randn(numCells,1)*dt^(1/2);
Ipoisson=noiseFactor*sPoissonToPost*(gPoisson.*sPoisson.*(V(postPoisson)-VrevPoisson));

J=Iinput+Isyn+Igap+Inoise+Itonic+Ipoisson;