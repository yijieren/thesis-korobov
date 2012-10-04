%% MAIN PROGRAM
%
% Roel Matthysen

close all
clear all
clc
%% Parameters

% Dimensions
s=2;
% Number of Points = 2^N
N=3;
% Max value of N for testing
maxi = 10;
% Plotting
plotting=true;

%% Execution - Compute Generator
% generator g
g = korobov2Generator(s,N);



%% Plot generator 2D/3D
if(s==2 && plotting)
    cc = hsv(N+1);
    figure;
    hold on
    plotCoefficients2D(g,N,1,cc(1,:));
    for i=N-1:-1:0
        plotCoefficients2D(mod(g*2^N,2^i)/2^i,i,0,cc(N-i+1,:));
    end
    
    axis square
end
if(s==3 && plotting)
    figure;
    plotCoefficients3D(g,N)
    axis square
end
%saveEps('../LaTeX/Verslag1/img/2dimensions4points.eps',8,8)

%% Execution - Compute Bernouilli integral using multiple point sets
% some plotting
if(plotting)
    figure;
    [X,Y]=meshgrid(0:0.02:1,0:0.02:1);
    Z=zeros(size(X));
    for i=1:length(X(:))
        Z(i)=testBernouilli2([X(i) Y(i)]);
    end
    Z=reshape(Z,size(X));
    surf(X,Y,Z)
    
end
figure
for s=2:10
    subplot(3,3,(s-1))
    title(['dimensions :  ' num2str(s)])
    %% Using a random point set
    for i=1:maxi,
        p=2^i;
        r=rand(p,s);
        y=testBernouilli2(r);
        mrandom(i) = (mean(y)-1).^2;
    end
    
    %% Using a sobol set
    sob = sobolset(s);
    %sob = scramble(sob,'MatousekAffineOwen')
    for i=1:maxi,
        p=2^i;
        y=testBernouilli2(net(sob,p));
        msobol(i) = (mean(y)-1).^2;
    end
    
    %% Using the Korobov 1 Lattice
    for i=1:maxi,
        g = korobov1Generator(s,i);
        y=testBernouilli2(korobovPoints(g,s,i));
        mkorobov1(i) = (mean(y)-1).^2;
    end
    
    %% Using the Korobov 2 Lattice
    for i=1:maxi,
        g = korobov2Generator(s,i);
        y=testBernouilli2(korobovPoints(g,s,i));
        mkorobov2(i) = (mean(y)-1).^2;
    end
    
    %% Using the Korobov 2 Lattice
    for i=1:maxi,
        g = korobov3Generator(s,i);
        y=testBernouilli2(korobovPoints(g,s,i));
        mkorobov3(i) = (mean(y)-1).^2;
    end
    
    %% Plotting the results
    if(plotting)
        hold all
        %plot(mrandom,'mo','MarkerFaceColor','m')
        plot(msobol,'go','MarkerSize',9,'MarkerFaceColor','g')
        plot(mkorobov1,'ro','MarkerFaceColor','r','MarkerSize',7)
        plot(mkorobov2,'ko','MarkerFaceColor','k','MarkerSize',5)
        plot(mkorobov3,'co','MarkerFaceColor','c','MarkerSize',3)
        xlabel('#points = 2^n')
        set(gca,'YScale','log')
        grid on
        axis([0 maxi 10^(-10) 10])
        if(s==2)
            legend('Sobol','Korobov 1','Korobov 2','Korobov 3')
        end
    end
end
% Extra plot to check temporary results
s=6;
%% Using the Korobov 1 Lattice
for i=1:maxi,
    g = korobov1Generator(s,i);
    y=testBernouilli2(korobovPoints(g,s,i));
    mkorobov1(i) = (mean(y)-1).^2;
end
k=korobovPoints(g,s,maxi)
for i=1:maxi,
    mkorobov1b(i)=(mean(testBernouilli2(mod(k*2^maxi,2^i)/2^i))-1).^2;
end
%% Using the Korobov 2 Lattice
for i=1:maxi,
    g = korobov2Generator(s,i);
    y=testBernouilli2(korobovPoints(g,s,i));
    mkorobov2(i) = (mean(y)-1).^2;
end
k=korobovPoints(g,s,maxi)
for i=1:maxi,
    mkorobov2b(i)=(mean(testBernouilli2(mod(k*2^maxi,2^i)/2^i))-1).^2;
end

%% Using the Korobov 2 Lattice
for i=1:maxi,
    g = korobov3Generator(s,i);
    y=testBernouilli2(korobovPoints(g,s,i));
    mkorobov3(i) = (mean(y)-1).^2;
end
k=korobovPoints(g,s,maxi)
for i=1:maxi,
    mkorobov3b(i)=(mean(testBernouilli2(mod(k*2^maxi,2^i)/2^i))-1).^2;
end

%% Plotting the results
figure;
subplot(211)
if(plotting)
    title('korobovpoints(2^n)')
    hold all
    %plot(mrandom,'mo','MarkerFaceColor','m')
    plot(mkorobov1,'ro','MarkerFaceColor','r','MarkerSize',7)
    plot(mkorobov2,'ko','MarkerFaceColor','k','MarkerSize',5)
    plot(mkorobov3,'co','MarkerFaceColor','c','MarkerSize',3)
    xlabel('#points = 2^n')
    set(gca,'YScale','log')
    grid on
    axis([0 maxi 10^(-12) 10])
    if(s==2)
        legend('Sobol','Korobov 1','Korobov 2','Korobov 3')
    end
end

%% Plotting the results
subplot(212)
if(plotting)
    title('korobovpoints(2^{maxn})   mod 2^n')
    hold all
    %plot(mrandom,'mo','MarkerFaceColor','m')
    plot(mkorobov1b,'ro','MarkerFaceColor','r','MarkerSize',7)
    plot(mkorobov2b,'ko','MarkerFaceColor','k','MarkerSize',5)
    plot(mkorobov3b,'co','MarkerFaceColor','c','MarkerSize',3)
    xlabel('#points = 2^n')
    set(gca,'YScale','log')
    grid on
    axis([0 maxi 10^(-12) 10])
    if(s==2)
        legend('Sobol','Korobov 1','Korobov 2','Korobov 3')
    end
end
%saveEps('../LaTeX/Verslag1/img/korobov3algorithms.eps',21,21);
