function coefficients = korobov1Generator(s,N)
% Generator calculated with korobov algorithm 1.

% The C array indexation is assumed

% Initialization
a=uint32(ones(s,1));
for v=2:N,
    % varying the bits independently
    min=Inf;
    for num=0:2^s-1
        for i=1:s
            a(i)=bitset(a(i),v,bitget(num,i));
        end
        k=korobov1H(a,v,N);
        if(k<min)
            min=k;
            mina=a;
        end
    end
    a=mina;
end
coefficients=double(a)/2^N;