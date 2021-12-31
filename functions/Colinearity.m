
%% -------------------- H) TEST FOR COLLINEARITY ----------------------------

function [Fstat, Fpval] = Colinearity(X,Y)

    [T,~]=size(X);
    X=[ones(T,1) X]; 
    ncoef=size(X,2); 
    dof=T-ncoef;     
    
    beta=X\Y; 
    epsilon=Y-X*beta;  
    
    yfitted=X*beta;         % fitted/predicted y values
    RSS=(epsilon'*epsilon); 
    
    XAUGMENTED=[X yfitted.^2 yfitted.^3]; % augmented dependent variable and regressors
    [TSTAR,NSTAR]=size(XAUGMENTED);
    
    BETAAUGMENTED=inv(XAUGMENTED'*XAUGMENTED)*XAUGMENTED'*Y; % ols estimator of new betas
    epsaugmented=Y-XAUGMENTED*BETAAUGMENTED; % residuals
    
    RSSUNRESTR=epsaugmented'*epsaugmented;  % Residual Sum of Squares of the unrestricted model
    RSSRESTR=RSS; % Residual Sum of Squares of the restricted model 
    
    % F-statistic Ramsey RESET test
    jrestriction=cols(XAUGMENTED)-cols(X);  
    dofstar=TSTAR-NSTAR;
    
    Fstat=((RSSRESTR-RSSUNRESTR)./(jrestriction))./(RSSUNRESTR./(dofstar)); % f-statistic
    Fpval=1-fcdf(Fstat,jrestriction,dofstar);  % p-value of f-stat

end