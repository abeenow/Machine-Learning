%Stochastic gradient descent version of the perceptron algorithm
%Input:  data X (here I assume that there is one data point on each row,
%and that the last column of X is equal to 1 to compute the bias
%Output:  the vector w concactenated with the scalar b
function [w, loss] = perceptron(X, Y)
[r,c] = size(X);

%intial choice of w = 0
w = zeros(c,1);
%step size
step = 1;
%variable for counting iterations
its = 0;

%iterate until convegence
grad = 1;
while sum(grad~=0) > 0
   its = its + 1;
   grad = 0;
   %loop over each of the data points
   for j=1:r       
       
       %check to see if the gradient is non-zero
       if -Y(j)*(w'*X(j,:)') >= 0
            %add the partial gradient to the gradient so far
            grad = grad + -Y(j)*X(j,:)'; 
       end
       
   end
   
   %update the weights and bias
   w = w + step*(-grad);   
   
   %print the iteration number followed by w for solution purposes
   disp(['Iteration: ' num2str(its)]);
   disp(['w: ' num2str(w(1:c-1)')]);
   disp(['b: ' num2str(w(c))]);
end




