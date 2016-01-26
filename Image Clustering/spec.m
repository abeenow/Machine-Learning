function [idx,V] = spec(X,sigma,K)
[row,~] = size(X);
A = zeros(row,row);
D = A;
for i = 1:row
    d_i = 0;
    for j = 1:row
        diff = (X(i,:) - X(j,:)) * (X(i,:) - X(j,:))';
        A(i,j) = exp(-(diff/(2*sigma*sigma)));
        d_i = d_i + A(i,j);
    end
    D(i,i) = d_i;
end
L = D - A;
[Vec,Val] = eig(L);
[~,ind] = sort(diag(Val),'ascend');
tmp = Vec(:,ind);
V = tmp(:,1:K);
idx = kmeans(V,K);