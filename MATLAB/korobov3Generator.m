
function coefficients = korobov3Generator(s,n)
% Generator calculated with korobov algorithm 2.

% The C array indexation is assumed

% Initialization
a=uint32(ones(s,1));
for i=2:s,
    % varying the bits one after another per dimension.
    for v=2:n,
        atemp=bitset(a(i),v,1);
        if(korobov3H(a(i),a,i,v,n)>korobov3H(atemp,a,i,v,n))
            a(i)=atemp;
        end
    end
end
coefficients=double(a)/2^n;
