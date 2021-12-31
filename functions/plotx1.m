%--------------------------------------------------------------------------
% plotx1.m
%--------------------------------------------------------------------------
% This function plots the transformed time series from FRED-MD
%
% Input: 
% Y = T x N matrix containing time series
% TCODE = vector of tcode (see Appendix FRED-MD)
% NAMEVAR = vector containing the names of the time series to be plotted
% DATES = vector containing the dates
%
% Output:
% The function plots the figure as programmed
%
% Author: Fabio Parla,
% Dublin, November 2020
%
% Disclaimer: If you find any errors, please email me at
% fabioparla123@gmail.com
%--------------------------------------------------------------------------

function plotx1(Y,TCODE,NAMEVAR,DATES)

n=size(Y,2);  % number of time series to be plotted
labtransform=["no transformation" "Delta (FOD) transformation" "Delta^2 transformation",...
              "Log transformation" "Delta (FOD) log transformation",...
              "Delta^2 Log transformation", "Delta growth rate transformation"];

figure;
for i=1:n  % alternatively cols(DATASELECT)
    subplot(size(Y,2),1,i)
    plot(DATES,Y(:,i),'LineWidth',1.3,'Color','k')
    axis tight
    hold on;
    xlabel("Years")
    title(strcat(NAMEVAR(i), " - ", labtransform(TCODE(i))))
end

end