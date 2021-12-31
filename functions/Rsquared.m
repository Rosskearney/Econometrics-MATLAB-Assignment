%% ------- R SQUARED & ADJUSTED R SQUARED ---------------


function [R2, R2BAR] = Rsquared(X,Y)

    [T, ~]=size(X);
    
    X=[ones(T,1) X];  
    ncoef=size(X,2); 
    dof=T-ncoef;
    
    beta = X\Y;
    epsilon=Y-X*beta;
    RSS = sum(epsilon.^2);
    
    YDEMEANED=Y-mean(Y);
    TSS=YDEMEANED'*YDEMEANED;
    
    R2=1-(RSS./TSS);            % R-squared
   
    RSSBAR=RSS./dof;
    TSSBAR=TSS./(T-1);
    
    R2BAR=1-(RSSBAR./TSSBAR);   % Adjusted R-squared

end
