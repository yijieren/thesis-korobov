%% korobov3H
% function to evaluate the weight function for algorithm 1.

function outerterm = korobov3H(x,a,r,v,n)

% Anonymous function for the fractional part
frac = @(x) abs(x-round(x));

outerterm=0;
for k=v:n,
    term=0;
    for m=1:2:2^k,
        factor=1;
        for i=1:r-1
            factor=factor*log(1/(sin(pi*(m*double(a(i))/2^k)).^2));
        end
        factor=factor*log(1/(sin(pi*(m*double(x)/2^v)).^2));
        term=term+factor;
    end
    term = term/2^(k-v);
    outerterm=outerterm+term;
end



