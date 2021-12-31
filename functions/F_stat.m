%% ---------------- STATISTICAL SIGNIFICANCE FUNTION (F-STAT)-----------

function [Fstat,Fpval] = F_stat(X,Y)
    
    [T, ~]=size(X);
    
    X=[ones(T,1) X];  
    ncoef=size(X,2);
    dof=T-ncoef;
    
    beta = X\Y;
    epsilon=Y-X*beta;
    RSS = sum(epsilon.^2);
    
    XTILDE=ones(T,1);
    betatilde = XTILDE\Y;
    epstilde=Y-XTILDE*betatilde;
    RSSRESTR=epstilde'*epstilde;  % Residual Sum of Squares of the restricted model
    
    RSSUNRESTR=RSS; 
    
    Fstat=((RSSRESTR-RSSUNRESTR)./(ncoef-1))./(RSSUNRESTR./(dof)); % F-statistic
    Fpval=1-fcdf(Fstat,ncoef-1,dof);                               % F-stat p-value

end