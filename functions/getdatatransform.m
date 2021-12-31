%--------------------------------------------------------------------------
% getdatatransform.m
%--------------------------------------------------------------------------
% This function compute transformations for series as suggested by 
% the Appendix of the FRED-MD database
%
% Input: 
% Y = T x N matrix containing time series
% TCODE = vector of tcode (see Appendix FRED-MD)
%
% Output:
% X = T x N matrix of transformed time series
%
% Author: Fabio Parla,
% Dublin, November 2020
%
% Disclaimer: If you find any errors, please email me at
% fabioparla123@gmail.com
%--------------------------------------------------------------------------

function X=getdatatransform(Y,TCODE)

% Check if the number of columns in Y is equal to the number of elements
% in TCODE. This function has been prepared to work only in case of number
% of columns in Y equal to the number of elements in TCODE.
% If the numbers are the different, the function prints an error message

[T,N]=size(Y);

if N~=size(TCODE,2)
   error('Error! The lenght of tcode must be equal to the number of time series.')
end

% Apply transformation to the time series
X=NaN(T,N);   % Create matrix of NaN where we store the transformed time
              % series
for j=1:N
     
    x=Y(:,j); % select the time series
    
    if TCODE(j)==1 % no transformation
       X(:,j)=x; 
    elseif TCODE(j)==2 % FOD transformation
       X(2:end,j)=diff(x,1);
    elseif TCODE(j)==3 % Second order diff. transformation
       X(3:end,j)=diff(x,2); 
    elseif TCODE(j)==4 % Log transformation
       X(:,j)=log(x); 
    elseif TCODE(j)==5 % Delta (FOD) log transformation
       X(2:end,j)=diff(log(x),1);
    elseif TCODE(j)==6 % Delta^2 (SOD) log transformation
       X(3:end,j)=diff(log(x),2); 
    elseif TCODE(j)==7 % Delta (FOD) of the growth rate transformation
       X(3:end,j)=diff((x(2:end,:)./x(1:end-1))-1,1); 
    end
    
end

end

