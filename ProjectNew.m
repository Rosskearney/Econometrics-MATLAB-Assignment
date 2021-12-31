clear;
clc;
cd

addpath(strcat(cd,'/data'));     % adding data and functions folders to pathway   
addpath(strcat(cd,'/functions'));                              

%% Import an excel file 
[data,text]=xlsread('DataNew.xlsx');                          

names=text(2,1:end);   %assign variable names into variables
date=data(1:end,1);    %assign data dates into variables


labx=["BRKB" "GOLD" "SP500" "VOL"];  % Select variables of interest

idvars=find(contains(names,labx));                   
DATASUB=data(:,idvars);

%% Transform the time series into stationary variables
tcode=[4 4 4 4];

%% "getdatatransform.m" Courtesy of Author: Fabio Parla, Dublin, November 2020
DATATR=getdatatransform(DATASUB,tcode); % data transform depending on 'tcode'

%DATATR=DATATR.*100;  % get percentage of delta log transformation 

TEMP=2016+(229/252):(1/252):2021+(225/252); 

%% "plotx1.m" Courtesy of Author: Fabio Parla, Dublin, November 2020
plotx1(DATATR,tcode,labx,TEMP) % plot time series

%% "removenan.m" Courtesy of Author: Fabio Parla, Dublin, November 2020
DATA=removenan(DATATR); % this function remove NaNs (if any)

Y=DATA(:,1);        % set dependent variable
X=DATA(:,2:end);    % set regressors (independent variables)
alpha=0.05;         % set significance level of the test


%% ------------------ A) OLS ESTIMATOR -----------------------

[OLS,OLSb] = OLSestimation(X,Y);


%% ------------------ B) CONFIDENCE INTERVAL -----------------------

[ConfidenceIntervals, ~] = confintB(OLS,OLSb,X);


%% ------------------ C) STATISTICAL SIGNIFICANCE -----------------------

[tcritical,tvalues,pvalues] = StatSig(OLS,OLSb,X);


%% ------------------ D) R SQUARED & ADJUSTED R SQUARED-----------------------

[Rsqrd, AdjRsqrd] = Rsquared(X,Y);


%% ------------------ E) F - STATISTIC ----------------------------

[FStatistic,FPvalue] = F_stat(X,Y);


%% ------------------ F) PLOT THE FITTED MODEL ----------------------------

[FittedMod] = ModFit(DATA,OLS,X,Y);


%% ------------------ G) DIAGNOSTICS TEST FOR RESIDUALS ---------------------------

[ResSum] = residuals(X,Y,TEMP);


%% ------------------ G i) DIAGNOSTICS TEST FOR NORMALITY ----------------------------

[~, NullH, Pval, JarqueB, CritValue] = residuals(X,Y,TEMP);


%% ------------------ G ii) DIAGNOSTICS TEST FOR HETEROSKEDASTICITY ----------------------------

[~,~,~,~,~,BPstat,BPpvalue,BPcritical] = residuals(X,Y,TEMP);


%% ---------------- G iii) DIAGNOSTICS TEST FOR SERIAL CORRELATION ----------------------------

[~,~,~,~,~,~,~,~,DurbWats] = residuals(X,Y,TEMP);


%% ----------------- H) TEST FOR COLLINEARITY ------------------------------------

[Fstatistic, Fpvalue] = Colinearity(X,Y);


%% -------------------- PRINT RESULTS ----------------------------

format short g
xxx = [OLS OLSb ConfidenceIntervals tvalues pvalues];
yyy = [tcritical Rsqrd AdjRsqrd FStatistic FPvalue];

fprintf('  |---Beta---|     |--SE--|  |---------CI----------|    |t-values|   |p-values|\n')
disp(xxx)

fprintf('   |t critical|  |R squared|    |Adj R|      |F stat| |F stat p-values|\n')
disp(yyy)

fprintf('   |0%% quantile||25%% quantile||50%% quantile||75%% quantile||100%% quantile|\n')
disp(ResSum)




