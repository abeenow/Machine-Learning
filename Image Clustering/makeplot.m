function makeplot(X,idx)
scatter(X(idx==1,1),X(idx==1,2),3)
hold on
scatter(X(idx==2,1),X(idx==2,2),4)