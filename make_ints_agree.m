function [a]=make_ints_agree(X,Y,show_plot)
%This code is used for simple linear regression on multiple data sets, wherein each line of best fit is constrained to have the same y-intercept. This is useful for finding percolation thresholds, among other things.
%X is an m x n matrix, where each column represents the m observations of each of the n variates.
%Y is an m x matrix 
%If show_plot==1, the plots the resulting regression lines and data.
[m,n]=size(X); %m is the number of data points per variate, n is the number of variates. For this implementation, the number of observations per variate must be the same
C=[ones(m*n,1) zeros(m*n,n)]; %this will be an m*n x n+1 matrix (we're going to solve Ca=d)
d=zeros(m*n,1); %this is an m x n vector (just reogranizing the output matrix)
for i=1:n
  C(i+1,(i-1)*m+1:m*i)=X(1:m,i);
  d((i-1)*m+1:m*i)=Y(1:m,i);
end
options=optimoptions(@lsqlin,'Algorithm','active-set');
a=lsqlin(C,d,[],[],[],[],[],[],[],options);

if show_plot==1
  hold on;
  for i=1:n
    plot([0 X(i,1:m)],a(1)+a(i+1)*[0 X(i,1:m)])
  end
  for i=1:n
    plot(X(1:m,i),Y(1:m,i),'*')
  end
end
