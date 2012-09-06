function plotCoefficients2D(coefficients,N)

c = [0; 0];
k=1;
list=hsv(2^N);

hold on;
for i=1:2^N,
    n = c+coefficients;
    if(n(1)>=1 && n(2)>=1)
    elseif(n(1)>=1 || n(2) >= 1)
        xintercept=c(1)+(n(1)-c(1))/(n(2)-c(2))*(1-c(2));
        yintercept=c(2)+(n(2)-c(2))/(n(1)-c(1))*(1-c(1));
        if(xintercept < yintercept)
            plot([c(1) xintercept],[c(2) 1],'col',list(i,:),'Linewidth',1)
            plot([xintercept mod(n(1),1)],[0 mod(n(2),1)],'col',list(i,:),'Linewidth',1)
        else
            plot([c(1) 1],[c(2) yintercept],'col',list(i,:),'Linewidth',1)
            plot([0 mod(n(1),1)],[yintercept mod(n(2),1)],'col',list(i,:),'Linewidth',1)
        end
            
    else
        plot([c(1) n(1)],[c(2) n(2)],'b','Linewidth',1)
    end
    n = mod(c+coefficients,[1;1]);
    plot(n(1),n(2),'bo','Linewidth',2,'MarkerFaceColor','red');
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
axis([0 1 0 1])