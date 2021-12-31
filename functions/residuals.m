
%% -------------------- G) DIAGNOSTICS TEST FOR RESIDUALS ----------------------------

function [residsummary,h,p,jbstat,critval,BP,BPpval,BPcrit,DW] = residuals(X,Y,TEMP)

[T,N]=size(X);
X=[ones(T,1) X]; 
beta=X\Y;
epsilon=Y-X*beta;   

residsummary=[min(epsilon) quantile(epsilon,[.25,.5,.75]) max(epsilon)]; % summary of residuals

%% Plot for inspection of residuals
TT=TEMP(end-size(epsilon,1)+1:end);
figure(1);
plot(TT,epsilon);
hold on
plot(TT,zeros(size(TT,2),1)','k--');
axis tight
title('Residuals vs. Time');
xlabel('Time'); ylabel('Residuals');


% Fitted vs. residuals
figure(2);
yfitted=X*beta;
scatter(yfitted,epsilon,'filled');
hold on;
plot(sort(yfitted),zeros(size(epsilon,1),1),'b--');
axis tight
title('Residuals vs. Fitted');
xlabel('Fitted'); ylabel('Residuals');

%% -------------------- Gi) DIAGNOSTICS TEST FOR NORMALITY ----------------------------

figure(3);
subplot(1,2,1);
qqplot(epsilon);
title('Normal Q-Q');
ylabel('Residuals');
subplot(1,2,2);
histogram(epsilon);
title('Histogram of Residuals');
xlabel('Residuals'); ylabel('Frequency');

% Jarque-Bera test
% Using jbtest function
% H0: the errors come from a normal distribution 
% H1: the errors are not normally distributed

alpha=0.05; % significance level of the test
[h,p,jbstat,critval]=jbtest(epsilon,alpha);


%% -------------------- G ii) DIAGNOSTICS TEST FOR HETEROSKEDASTICITY ----------------------------

% Breusch-Pagan heteroscedasticity test
% H0: variance of residuals is constant over time
% H1: variance of residuals is NOT constant over time
% statistic > critical = reject H0
RSS=(epsilon'*epsilon);    
sigmaeps=(1./T).*RSS;      % This is the estimator of the residual variance 

% Construct the auxiliary regression
epsnew=(epsilon.^2)./sigmaeps - 1;  
Z=X; 
betatilde=inv(Z'*Z)*Z'*epsnew; % OLS estimator
epsfitted=Z*betatilde; % residuals
BP=sum(epsfitted.^2)./2; % compute the statistics

BPcrit=chi2inv(0.95,N);  % critical value
BPpval=1-chis_prb(BP,N); % pvalue

bpagan(Y,X); % Breusch-Pagan heteroscedasticity test from econometrics Toolbox

%% -------------------- G iii) DIAGNOSTICS TEST FOR SERIAL CORRELATION ----------------------------

% Durbin-Watson test
% H0: residuals are not correlated
% H1: residuals ARE serially correlated
DW=sum(diff(epsilon,1).^2)./sum(epsilon.^2); 

end

