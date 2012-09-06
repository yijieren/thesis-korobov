%% korobov1H
% function to evaluate the weight function for algorithm 1.

function term = korobov1H(a,v,n)

% Anonymous function for the fractional part
frac = @(x) abs(x-round(x));

s=length(a);
term=0;
for m=1:2:2^v,
    factor=1;
    for i=1:s,
        factor=factor*(2*n-2*v+1/(frac(m*double(a(i))/2^v)));
    end
    term=term+factor;
end
term = term/2^v;
        
        
        
