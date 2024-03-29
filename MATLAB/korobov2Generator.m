
function coefficients = korobov2Generator(s,N)
% Generator calculated with korobov algorithm 2.

% The C array indexation is assumed

% Initialization
a=uint32(ones(s,1));
for v=2:N,
    % varying the bits one after another.
    for i=1:s,
        atemp=a;
        atemp(i)=bitset(atemp(i),v,1);
        k1=korobov2H(a,i,v,N);
        k2=korobov2H(atemp,i,v,N);
        if(korobov2H(a,i,v,N)>korobov2H(atemp,i,v,N))
            a(i)=atemp(i);
        end
    end
end
coefficients=double(a)/2^N;
