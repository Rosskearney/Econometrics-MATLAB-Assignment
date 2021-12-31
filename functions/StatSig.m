%% ------- STATISTICAL SIGNIFICANCE FUNCTION---------------

function [tcrit,tvals,pvals] = StatSig(OLS,OLSb,X)

    [T, ~]=size(X);
    
    X=[ones(T,1) X]; 
    ncoef=size(X,2); 
    dof=T-ncoef; 
    
    alpha=0.05; 
    
    tcrit=-1.*tinv(alpha./2,dof);       %critical t-values
    
    tvals=OLS./OLSb;                    %t-statistics 
    
    pvals=2.*(1-tcdf(abs(tvals),dof));  % p-values

end