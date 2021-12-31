%% ---------- Beta & stdbeta for OLS estimator -------------------

function [beta,stdbeta]=OLSestimation(X,Y)

    [T,~]=size(X);
    
    X=[ones(T,1) X];  % includes the intercept and the regressors
    ncoef=size(X,2);  % number of coefficients to be estimated 
    dof=T-ncoef;      % degrees of freedom
    
    beta = X\Y;  
    
    % OLS residuals
    epsilon=Y-X*beta;          % residuals
    RSS=(epsilon'*epsilon);    
    sigmaeps=(1./dof).*RSS;    % Estimator of the residual variance
    
    varbeta=sigmaeps.*inv(X'*X); % Variance 
    stdbeta=sqrt(diag(varbeta)); % Standard errors

end 


