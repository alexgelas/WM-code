function newX=expDecay(x,xInf,tau,dt)
newX=x+dt./tau.*(xInf-x);