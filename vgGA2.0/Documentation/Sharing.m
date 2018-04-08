%% Sharing
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
% This is a brief demonstration of sharing.

%% Sharing function
% This is a plot of the sharing function Sh(d) for different values of alpha.
clf
d = -0.1:0.02:1.2;
plot(d,Sh(d,1,0.5),d,Sh(d,1,0.7),d,Sh(d,1,1),d,Sh(d,1,1.5),d,Sh(d,1,2));
axis([-0.1 1.1 -0.1 1.2])
xlabel('d')
ylabel('Sh(d)')
title('Sharing function')
legend('alpha=0.5','alpha=0.7','alpha=1','alpha=1.5','alpha=2','Location','Best')

%% debf1: Deb's function f1
% This function has several maxima uniformly spaced.
clf
t = 0:0.001:1;
plot(t,debf1(t))
axis([0 1 -0.1 1.1])
title('debf1')
xlabel('x')
ylabel('f(x)')


%% A simple GA over debf1
% We optimize function debf1 with a genetic algorithm for reals with a
% single 30 bit segment, pm=0.0 and pc=0.9. We use a simple GA with SUS
% selection, and we let it run for 200 generations. The population
% randomly converges to one of the optima.

n = 100;  % population size
N = 30;   % chromosome length
ms = 0;
pc = 0.9;
p = population('real',[0 1],N,ms,pc);
p = random(p,n);
generations = 200;
p = evaluate(p,@debf1);
centers = 0.1:0.05:0.9;
for i=1:generations
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,@debf1);
   subplot(3,1,[1 2])
   plot(t,debf1(t))
   axis([0 1 -0.1 1.1])
   title('Simple GA over debf1')
   xlabel('x')
   ylabel('f(x)')
   hold on
   plot(p);
   str = sprintf('t = %d/%d',i,generations);
   text(0.77,0.85,str)
   hold off
   r = get(p,'r');
   subplot(3,1,3)
   hist(r,centers);
   axis([0 1 0 n])
   grid on
   xlabel('x')
   ylabel('m')
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r','EdgeColor','w')
   pause(0.03)
end

%% GA with phenotypical sharing over debf1
% Now we add phenotypical sharing. We set sigma=1.

n = 200;  % population size
N = 30;   % chromosome length
n = 200;
ms = 0;
pc = 0.9;
alpha = 1;
sigma = 0.1;
p = population('real',[0 1],N,ms,pc);
p = random(p,n);
generations = 200;
centers = 0.0:0.05:1.0;
p = evaluate(p,@debf1);
for i=1:generations
   p = share(p,sigma,'phenotypic',alpha);
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,@debf1);
   subplot(3,1,[1 2])
   plot(t,debf1(t))
   axis([0 1 -0.1 1.1])
   title(sprintf('GA with sharing on debf1 \\sigma=%6.4f \\alpha=%6.4f',sigma,alpha))
   xlabel('x')
   ylabel('f(x)')
   hold on
   plot(p);
   str = sprintf('t = %d/%d',i,generations);
   text(0.77,0.85,str)
   hold off
   r = get(p,'r');
   subplot(3,1,3)
   hist(r,centers);
   axis([0 1 0 n/4])
   grid on
   xlabel('x')
   ylabel('m')
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r','EdgeColor','w')
   pause(0.03)
end

%% debf2: Deb's function f2
% This function has several optima uniformly spaced.
t = 0:0.001:1;
clf
plot(t,debf2(t))
axis([0 1 -0.1 1.1])
title('debf2')
xlabel('x')
ylabel('f(x)')

%% A simple GA over debf2
% We optimize function debf2 with a genetic algorithm for reals with a
% single 30 bit segment, pm=0.0 and pc=0.9. We use a simple GA with SUS
% selection, and we let it run for 200 generations. The population
% randomly converges to the optima.

n = 100;  % population size
N = 30;   % chromosome length
ms = 0;
pc = 0.9;
p = population('real',[0 1],N,ms,pc);
p = random(p,n);
generations = 120;
p = evaluate(p,@debf2);
centers = 0.0:0.05:1.0;
for i=1:generations
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,@debf2);
   subplot(3,1,[1 2])
   plot(t,debf2(t))
   axis([0 1 -0.1 1.1])
   title('GA without sharing on debf2')
   xlabel('x')
   ylabel('f(x)')
   hold on
   plot(p);
   str = sprintf('t = %d/%d',i,generations);
   text(0.77,0.85,str)
   hold off
   r = get(p,'r');
   subplot(3,1,3)
   hist(r,centers);
   axis([0 1 0 n])
   grid on
   xlabel('x')
   ylabel('m')
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r','EdgeColor','w')
   pause(0.03)
end

%% GA with phenotypical sharing over debf2
% Now we add phenotypical sharing. We set sigma=1.

n = 200;  % population size
N = 30;   % chromosome length
ms = 0;
pc = 0.9;
alpha = 1;
sigma = 0.1;
p = population('real',[0 1],N,ms,pc);
p = random(p,n);
generations = 200;
p = evaluate(p,@debf2);
centers = 0.0:0.05:1.0;
for i=1:generations
   p = share(p,0.1,'phenotypic');
   p = sus(p); 
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,@debf2);
   subplot(3,1,[1 2])
   plot(t,debf2(t))
   axis([0 1 -0.1 1.1])
   title(sprintf('GA with sharing on debf2 \\sigma=%6.4f \\alpha=%6.4f',sigma,alpha))
   xlabel('x')
   ylabel('f(x)')
   hold on
   plot(p);
   str = sprintf('t = %d/%d',i,generations);
   text(0.77,0.85,str)
   hold off
   r = get(p,'r');
   subplot(3,1,3)
   hist(r,centers);
   axis([0 1 0 n/2])
   grid on
   xlabel('x')
   ylabel('m')
   h = findobj(gca,'Type','patch');
   set(h,'FaceColor','r','EdgeColor','w')
   pause(0.03)
   pause(0.03)
end



%% A side-by-side comparison, with and without sharing
% Finally, a side-by-side comparison.

fcn = @debf2;
n = 200;  % population size
N = 30;   % chromosome length
ms = 0;
pc = 0.9;
alpha = 1;
sigma = 0.1;
generations = 200;
p1 = population('real',[0 1],N,ms,pc);
p2 = population('real',[0 1],N,ms,pc);
p1 = random(p1,n);
p2 = random(p2,n);
p1 = evaluate(p1,fcn);
p2 = evaluate(p2,fcn);
centers = 0.1:0.2:0.9;
for i=1:generations
   p1 = sus(p1); 
   p1 = crossover(p1);
   p1 = mutation(p1);
   p1 = evaluate(p1,fcn);
   p2 = share(p2,0.1,'phenotypic');
   p2 = sus(p2); 
   p2 = crossover(p2);
   p2 = mutation(p2);
   p2 = evaluate(p2,fcn);
   r1 = get(p1,'r');
   r2 = get(p2,'r');
   m1 = hist(r1,centers);
   m2 = hist(r2,centers);
   subplot(2,1,1)
   plot(t,fcn(t))
   axis([0 1 -0.1 1.1])
   title('Without sharing')
   xlabel('x')
   ylabel('f(x)')
   hold on
   plot(p1);
   str = sprintf('t = %d/%d',i,generations);
   text(0.77,0.85,str)
   for j=1:length(centers)
      text(centers(j)-0.006,0.1,sprintf('%2d',m1(j)))
   end
   hold off
   subplot(2,1,2)
   plot(t,fcn(t))
   axis([0 1 -0.1 1.1])
   title(sprintf('With sharing \\sigma=%6.4f \\alpha=%6.4f',sigma,alpha))
   xlabel('x')
   ylabel('f(x)')
   hold on
   plot(p2);
   str = sprintf('t = %d/%d',i,generations);
   text(0.77,0.85,str)
   for j=1:length(centers)
      text(centers(j)-0.006,0.1,sprintf('%2d',m2(j)))
   end
   hold off
   pause(0.03)
end