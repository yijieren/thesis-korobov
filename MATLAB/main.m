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
N=5;
% Max value of N for testing
maxi = 6;
% Plotting
plotting=true;

%% Execution - Compute Generator
% generator g
g = korobov3Generator(s,N);



%% Plot generator 2D/3D
if(s==2 && plotting)
    figure;
    plotCoefficients2D(g,N)
    axis square
end
if(s==3 && plotting)
    figure;
    plotCoefficients3D(g,N)
    axis square
end

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
        plot(mrandom,'mo','MarkerFaceColor','m')
        plot(msobol,'go','MarkerSize',11,'MarkerFaceColor','g')
        plot(mkorobov1,'ro','MarkerFaceColor','r')
        plot(mkorobov2,'ko','MarkerFaceColor','k','MarkerSize',7)
        plot(mkorobov3,'co','MarkerFaceColor','c','MarkerSize',5)
        set(gca,'YScale','log')
        grid on
        if(s==2)
            legend('Random','Sobol','Korobov 1','Korobov 2','Korobov 3')
        end
    end
end
