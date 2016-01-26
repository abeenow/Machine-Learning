%Stochastic gradient descent version of the perceptron algorithm
%Input:  data X (here I assume that there is one data point on each row,
%and that the last column of X is equal to 1 to compute the bias
%Output:  the vector w concactenated with the scalar b
function w = stocperceptron(X, Y)
[r,c] = size(X);

%intial choice of w = 0
w = zeros(c,1);
%step size
step = 1;
%variable for counting iterations
its = 0;

%perform a big number of loops through the data (this is overkill)
for i=1:10000
   %loop over all the data points
    for j=1:r
       %at each iteration we update the single component of the gradient
       %corresponding to the jth data point
       its = its +1;
       
       %check to see if the gradient is non-zero
       if -Y(j)*(w'*X(j,:)') >= 0          
            %for a nonzero gradient, update w
            w = w + Y(j)*X(j,:)';            
            %print the iteration number followed by w for solution purposes
            disp(['Iteration: ' num2str(its)]);
            disp(['w: ' num2str(w(1:c-1)')]);
            disp(['b: ' num2str(w(c))]);
       end
       
   end
  
end




