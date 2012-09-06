function plotCoefficients3D(coefficients,N)

c = [0; 0; 0];

hold on;
for i=1:2^N,
    n = mod(c+coefficients,[1;1;1]);
    plot3(n(1),n(2),n(3),'bo');
    c = n;
%     if(norm(c-[0 ; 0]) < 100 * eps)
%         recurrence = 1;
%     end
%     if(norm(c-[0 ; 1]) < 100 * eps)
%         recurrence = 1;
%     end
%     if(norm(c-[1 ; 0]) < 100 * eps)
%         recurrence = 1;
%     end
%     if(norm(c-[1 ; 1]) < 100 * eps)
%         recurrence = 1;
%     end
end
grid on
axis([0 1 0 1 0 1])