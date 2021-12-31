%% ---------------- PLOT THE FITTED LINE -------------------

function [MOD1] = ModFit(DATA,OLS,X,Y)

[T,~]=size(X);
X=[ones(T,1) X];  
beta = X\Y;
epsilon=Y-X*beta;

MOD = OLS(1) + OLS(2).*DATA(:,2)+OLS(3).*DATA(:,3)+OLS(4).*DATA(:,4)+epsilon; % regression line
MOD1 = OLS(1) + OLS(2).*DATA(:,2)+OLS(3).*DATA(:,3)+OLS(4).*DATA(:,4); % regression equation

plot(Y,MOD)
hold on
scatter(Y,MOD1)
title("Fitted log BRKB Price")
xlabel('Actual log BRKB Prices')
ylabel('Model log BRKB Prices')

end

