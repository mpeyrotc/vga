%% SimpleGA
%************************************************************
%*                                                          *
%*   vgGA2.0: The Virtual Gene Genetic Algorithm            *
%*                                                          *
%*   Copyright (c) All Rights Reserved 2003-2017            *
%*   Manuel Valenzuela-Rendón                               *
%*   manuel.valenzuela.r@gmail.com                          *
%*   http://sites.google.com/site/manuelvalenzuelar/        *
%*                                                          *
%************************************************************
%
% We will optimize function onemax; this is a function that returns the
% number of ones in the chromosome. It is apparently difficult, but it is
% actually easy for a GA because it has an easily exploitable structure.
% This is a plot of onemax for chromosomes of length N and base B.

N = 3;
B = 5;
t = 0:1:B^N-1;
clear f
for i=1:length(t), f(i)=basemax(t(i),B); end
clf
plot(t,f,t,f,'or')
title(sprintf('function basemax for B=%d N=%d',B,N))
xlabel('x')
ylabel('f(x)')

%% Function basemax
% We will optimize the function basemax using a genetic algorithm. We
% define the function objF to facilitate its use.

B = 2;
clear objF
objF = @(x) basemax(x,B);

%% A simple GA with tournament selection 
% We optimize the function basemax with a genetic algorithm with binary
% chromosomes of N=30 bits, pm=0.1 and pc=0.7. We use a simple GA with
% tournament selection of size 2, and run it for 100 generations. 

N = 30;             % chromosome length
n = 20;             % population size
ms = 1;             % mutations per segment
pc = 0.7;           % crfossover probability
generations = 100;  % number of generations
p = population('integer',N,ms,pc);
p = random(p,n);
p = evaluate(p,objF);
best = get(p,'best');
e = 0;
b = best.fitness;
for i=1:generations
   p = tournament(p);
   p = crossover(p);
   p = mutation(p);
   p = evaluate(p,objF);
   best = get(p,'best');
   e(i+1) = get(p,'evals');
   b(i+1) = best.fitness;
   plot(e,b,'.-')
   axis([0 e(i+1)+100 0 ceil(logB(2^N,B))*1.1])
   xlabel('Objective function evaluations')
   ylabel('Best found so far')
   title(sprintf('Simple GA (n=%d) over basemax (B=%d,N=%d)',n,B,N))
   pause(0.01)
end
display(best)

%% Best found plot
% The simple GA is run multiple times to generate a best found plot.

runs = 100;
generations = 40;
N = 30;             % chromosome length
n = 10;             % population size
ms = 1;             % mutations per segment
pc = 0.7;           % crfossover probability
generations = 100;  % number of generations

E = [];    
Be = [];
p = population('integer',N,ms,pc);
for j=1:runs
   p = init(p);
   p = random(p,n);
   p = evaluate(p,objF);
   best = get(p,'best');
   e = get(p,'evals');
   b = best.fitness;
   for i=1:generations
      p = tournament(p);
      p = crossover(p);
      p = mutation(p);
      p = evaluate(p,objF);
      best = get(p,'best');
      e(i+1) = get(p,'evals');
      b(i+1) = best.fitness;
   end
   E = [E e'];
   Be = [Be b'];
   x = max(E,[],2);
   prom = mean(Be,2);
   fig1 = std(Be,[],2);
   plot(x,prom+fig1,x,prom,'.-',x,prom-fig1,e,b,'-.k')
   axis([0 max(max(E)) 0 ceil(logB(2^N,B))*1.1])
   xlabel('Objective function evaluations')
   ylabel('Best found so far')
   title(sprintf('Best found curve for %d/%d runs',j,runs))
   legend('avg + std dev','avg','avg - std dev','last run','location','SouthEast')
   pause(0.01)
end
plot(x,prom+fig1,x,prom,'.-',x,prom-fig1)
axis([0 max(max(E)) 0 ceil(logB(2^N,B))*1.1])
xlabel('Objective function evaluations')
ylabel('Best found so far')
title(sprintf('Best found curve for %d runs',j))
legend('prom + std dev','prom','prom - std dev','location','SouthEast')

