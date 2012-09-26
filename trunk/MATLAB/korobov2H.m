%% korobovH
% function to evaluate the weight function for algorithm 1.

function term = korobov2H(a,r,v,n)

% Anonymous function for the fractional part
frac = @(x) abs(x-round(x));

s=length(a);
term=0;
for m=1:2:2^v,
    factor=1;
    for i=1:r,
        factor=factor*(2*n-2*v+1/(frac(m*double(a(i))/2^v)));
    end
    for i=r+1:s,
        factor=factor*(2*n-2*v+2+1/(frac(m*double(a(i))/2^(v-1))));
    end
    term=term+factor/2^v;
end
        
        
        
