function y = testBernouilli2(x)

% Anonymous function: Bernouilli polynomial n=2
B2 = @(x) x.^2-x+1/6;

s=size(x,2);
y=ones(size(x(:,1)));
for i=1:s,
    y=y.*(1+B2(x(:,i)));
end
