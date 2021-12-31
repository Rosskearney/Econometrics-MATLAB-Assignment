%--------------------------------------------------------------------------
% removenan.m
%--------------------------------------------------------------------------
% This function remove NaNs from a matrix of observations
%
% Input: 
% X = T x N matrix containing time series
%
% Output:
% out = T x (N-NaNS) matrix containing time series
%
% Author: Fabio Parla,
% Dublin, November 2020
%
% Disclaimer: If you find any errors, please email me at
% fabioparla123@gmail.com
%--------------------------------------------------------------------------
function out=removenan(X)

id=sum(isnan(X),2)==0;
out=X(id,:);

end