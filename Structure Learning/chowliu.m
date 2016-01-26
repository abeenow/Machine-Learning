function [cost] = chowliu()
data = csvread('zoo.data');
[row,col] = size(data);
c_x = ones(9,col);
cost = zeros(col,col);
c_xy = ones(8,8);
for i = 1:col
	for j=0:8
		c_x(j+1,i) = length(data(data(:,i) == j)) / row;
	end
end
for i = 1:col
	for j = i+1:col
		for ival = 0:8
			for jval = 0:8
				c_xy(ival+1,jval+1) = length(find(data(:,i) == ival & data (:,j)==jval)) / row;
				if(c_xy(ival+1,jval+1) ~= 0 && c_x(ival+1,i) ~=0 && c_x(jval+1,j) ~= 0 )
					cost(i,j) = cost(i,j) + ( c_xy(ival+1,jval+1) * log2( c_xy(ival+1,jval+1) /(c_x(ival+1,i) * c_x(jval+1,j) ) ) );
				end
			end
		end
		cost(j,i) = cost(i,j);
	end
end
[ Tree,Cost ] = UndirectedMaximumSpanningTree ( cost );
names =
{'hair','feathers','eggs','milk','airborne','aquatic','predator','toothed','backbone','b
reathes','venomous','fins','legs','tail','domestic','catsize','type'};
h1 = view(biograph(triu(Tree),names,'ShowArrows','on','ShowWeights','off'));
end
