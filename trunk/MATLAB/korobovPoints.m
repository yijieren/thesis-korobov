function y = korobovPoints(g,s,N)
y=zeros(2^N,s);
x=repmat(g',2^N,1);
y= repmat([1:2^N]',1,s);
y=mod(x.*y,ones(2^N,s));