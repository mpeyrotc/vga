%% Scaling
%************************************************************
%*                                                          *
%*   vgGA2.0: The Virtual Gene Genetic Algorithm            *
%*                                                          *
%*   Copyright (c) All Rights Reserved 2003-2016            *
%*   Manuel Valenzuela-Rendón                               *
%*   manuel.valenzuela.r@gmail.com                          *
%*   http://sites.google.com/site/manuelvalenzuelar/        *
%*                                                          *
%************************************************************
%
% This scripts shows the need for scaling when using proportional selection
% in a simple GA.

%% debf2
% We first use Deb's function 2. The following produces de plot of this
% function. The optimal is at x=0.1.
clf
t = 0:0.001:1;
plot(t,debf2(t))
axis([0 1 -0.1 1.1])
xlabel('x')
ylabel('f(x)')
title('debf2')

%% A simple GA over debf2
% We optimize function debf2 using a genetic algorithm with a real segment
% of 30 bits, pm=0.01, and pc=0.9. Our genetic algorithm uses SUS selection
% and it is run for 100 generations. The population converges to the
% optimal. 
clf
centers = 0.1:0.05:0.9;
N = 100;  % population size
p = population('real',[0 1],30,0.3,0.9); % ms is set so that pm=0.01
p = random(p,N);
generations = 100;
p = evaluate(p,@debf2);
for i=1:generations
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,@debf2);
   subplot(3,1,[1 2])
   plot(t,debf2(t))
   xlabel('x')
   ylabel('f(x)')
   axis([0 1 -0.1 1.1])
   title('SUS without scaling')
   hold on
   plot(p);
   str = sprintf('t = %d/%d',i,generations);
   text(0.7,0.8,str)
   hold off
   subplot(3,1,3)
   r = get(p,'r');
   hist(r,centers);
   axis([0 1 0 N])
   grid on
   xlabel('x')
   ylabel('m') % number of individuals per niche
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r','EdgeColor','w')
   pause(0.1)
end

%% debf2T=debf2+20
% We now optimize function debf2 20 units in the y-axis; let us call this 
% deb2T. The optimal of deb2T is x=0.1.
clf
debf2T = @(x) debf2(x) + 20;
t = 0:0.0005:1;
plot(t,debf2T(t))
axis([0 1 19.9 21.1])
xlabel('x')
ylabel('f(x)')
title('debf2+20')

%% A simple GA over debf2T
% We optimize function debf2T with a genetic algorithm with a real segment
% of 30 bits, pm=0.1, and pc=0.9.Our genetic algorithm uses SUS selection
% and runs for 100 generations. The population does not converge to 
% the optimal. 
clf
centers = 0.1:0.05:0.9;
N = 100;  % population size
p = population('real',[0 1],30,0.3,0.9); % ms is set so that pm=0.01
p = random(p,N);
generations = 100;
p = evaluate(p,debf2T);
for i=1:generations
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,debf2T);
   subplot(3,1,[1 2])
   plot(t,debf2T(t))
   xlabel('x')
   ylabel('f(x)')
   axis([0 1 19.9 21.1])
   title('SUS without scaling')
   hold on
   plot(p);
   str = sprintf('t = %d/%d',i,generations);
   text(0.7,20.8,str)
   hold off
   subplot(3,1,3)
   r = get(p,'r');
   hist(r,centers);
   axis([0 1 0 N])
   grid on
   xlabel('x')
   ylabel('m') % number of individuals per niche
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r','EdgeColor','w')
   pause(0.1)
end

%% A GA with proportional selection and scaling
% By adding linear scaling to our genetic algorithm, the population now 
% converges to the optimal.
clf
centers = 0.1:0.05:0.9;
N = 100;  % population size
p = population('real',[0 1],30,0.3,0.9); % ms is set so that pm=0.01
p = random(p,100);
generations = 50;
p = evaluate(p,debf2T);
for i=1:generations
   p = scale(p);      % linear scaling
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,debf2T);
   subplot(3,1,[1 2])
   plot(t,debf2T(t))
   xlabel('x')
   ylabel('f(x)')
   axis([0 1 19.9 21.1])
   title('SUS with scaling')
   hold on
   plot(p); 
   str = sprintf('t = %d/%d',i,generations);
   text(0.7,20.8,str)
   hold off
   subplot(3,1,3)
   r = get(p,'r');
   hist(r,centers);
   axis([0 1 0 N])
   grid on
   xlabel('x')
   ylabel('m') % number of individuals per niche
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r','EdgeColor','w')
   pause(0.1)
end

%% A GA with tournament selection 
% Instead of proportional selection and scaling, we can produce similar
% results using tournament selection.
clf
centers = 0.1:0.05:0.9;
N = 100;  % population size
p = population('real',[0 1],30,0.3,0.9); % ms is set so that pm=0.01
p = random(p,100);
generations = 50;
p = evaluate(p,debf2T);
for i=1:generations
   p = tournament(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,debf2T);
   xlabel('x')
   ylabel('f(x)')
   subplot(3,1,[1 2])
   plot(t,debf2T(t))
   axis([0 1 19.9 21.1])
   title('tournament selection')
   hold on
   plot(p); 
   str = sprintf('t = %d/%d',i,generations);
   text(0.7,20.8,str)
   hold off
   subplot(3,1,3)
   r = get(p,'r');
   hist(r,centers);
   axis([0 1 0 N])
   grid on
   xlabel('x')
   ylabel('m') % number of individuals per niche
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r','EdgeColor','w')
   pause(0.1)
end
