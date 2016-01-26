%Dual SVM using Gaussian Kernel
%Input:  data X 
%slack penalty constant C
%standard deviation sigma
%Output:  the vector lambda concactenated with the scalar b
function [lambda,b] = dualSVM_train1(X,C,sigma)
[r,c] = size(X);
x = X(:,1:end-1);
y = X(:,c);y(y==0) = -1;

%Gaussian kernel
kernel=zeros(r,r);
H=zeros(r,r);
for i=1:r
    for j=1:r
        kernel(i,j) = exp(-norm(x(i,:)-x(j,:))^2/(2*sigma^2));
        H(i,j) = y(i)*y(j)*kernel(i,j);
    end
end

f=-ones(r,1);
Aeq = y';
beq = 0;
lb = zeros(r,1);
ub = C*ones(r,1);
opts = optimset('Algorithm','interior-point-convex');
[lambda]= quadprog(H,f,[],[],Aeq,beq,lb,ub,[],opts); 

wTx=zeros(1,r);
cnt=0;
sum_b=0;
for i=1:r
    if lambda(i)<C && lambda(i)>0
        cnt=cnt+1;
        for j=1:r   
            kernel(j,i) = exp(-norm(x(j,:)-x(i,:))^2/(2*sigma^2));
            wTx(i) = wTx(i) + lambda(j)*y(j)*kernel(j,i);
        end
        sum_b=sum_b+y(i)-wTx(i);
    end    
end
b = sum_b/cnt; 