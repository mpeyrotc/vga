%% Deception
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
% This script tests Goldberg's conclusions regarding problems formed by
% concatenated and interlaced completely deceptive problems.
% Please notice that we will use tournament selection because some kind of
% scaling is needed in these problems.

%% Parameters

k = 5;  % number of bits per deceptive subproblem
m = 10; % number of deceptive subproblems

concatenated = @(x) sum(deceptive(x,k));      % obj fcn for concatenated
interlaced   = @(x) sum(interDeceptive(x,m)); % obj fcn for interlaced

Nc = k*ones(1,m);  % bits per segment for concatenated problems
Ni = m*ones(1,k);  % bits per segment for interlaced problems
n = 400;           % population size
generations = 60;  % max generations
runs = 30;         % number of runs for the best found plot

ejeY = [m*(2*(k-2)) m*(2*k-1)+2]; % axis limits
clf

%% Concatendated problems, one run

p = population('integer',Nc); % no mutation
p = random(p,n);
p = evaluate(p,concatenated);
best = get(p,'best');
e = 0;
b = best.fitness;
for i=1:generations
   p = tournament(p);
   p = crossover(p);
   % p = mutation(p);
   p = evaluate(p,concatenated);
   best = get(p,'best');
   e(i+1) = get(p,'evals');
   b(i+1) = best.fitness;
   plot(e,b,'.-')
   ylim(ejeY)
   xlabel('Objective function evaluations')
   ylabel('Best found so far')
   title(sprintf('%d concatenated deceptive %d-bit problems',m,k))
   pause(0.01)
end
display(best)

%% Interlaced problems, one run

p = population('integer',Ni); % no mutation
p = random(p,n);
p = evaluate(p,interlaced);
best = get(p,'best');
e = 0;
b = best.fitness;
for i=1:generations
   p = tournament(p);
   p = crossover(p);
   % p = mutation(p);
   p = evaluate(p,interlaced);
   best = get(p,'best');
   e(i+1) = get(p,'evals');
   b(i+1) = best.fitness;
   plot(e,b,'.-')
   ylim(ejeY)
   xlabel('Objective function evaluations')
   ylabel('Best found so far')
   title(sprintf('%d interlaced deceptive %d-bit problems',m,k))
   pause(0.01)
end
display(best)

%% Best found so far plot por concatenated problems
% Multiple runs of a simple GA are used to generate the best found plot

E = [];    
Be = [];
p = population('integer',Nc);
for j=1:runs
   p = init(p);
   p = random(p,n);
   p = evaluate(p,concatenated);
   best = get(p,'best');
   e = get(p,'evals');
   b = best.fitness;
   for i=1:generations
      p = tournament(p);
      p = crossover(p);
      % p = mutation(p);
      p = evaluate(p,concatenated);
      best = get(p,'best');
      e(i+1) = get(p,'evals');
      b(i+1) = best.fitness;
   end
   E = [E e'];
   Be = [Be b'];
   x = max(E,[],2);
   prom = mean(Be,2);
   fig1 = std(Be,[],2);
   plot(x,prom+fig1,x,prom,'.-',x,prom-fig1,e,b,':k')
   ylim(ejeY)
   xlabel('Objective function evaluations')
   ylabel('Best found so far')
   title(sprintf('%d concatenated %d-bit deceptive problems, %d/%d runs',m,k,j,runs))
   legend('\mu + \sigma','\mu','\mu - \sigma',sprintf('run #%d',j),4)
   pause(0.01)
end
plot(x,prom+fig1,x,prom,'.-',x,prom-fig1)
ylim(ejeY)
xlabel('Objective function evaluations')
ylabel('Best found so far')
title(sprintf('%d concatenated %d-bit deceptive problems, %d runs',m,k,j))
legend('\mu + \sigma','\mu','\mu - \sigma',4)

%% Best found so far plot por interlaced problems
% Multiple runs of a simple GA are used to generate the best found plot

E = [];    
Be = [];
p = population('integer',Ni); % no mutation
for j=1:runs
   p = init(p);
   p = random(p,n);
   p = evaluate(p,interlaced);
   best = get(p,'best');
   e = get(p,'evals');
   b = best.fitness;
   for i=1:generations
      p = tournament(p);
      p = crossover(p);
      % p = mutation(p);
      p = evaluate(p,interlaced);
      best = get(p,'best');
      e(i+1) = get(p,'evals');
      b(i+1) = best.fitness;
   end
   E = [E e'];
   Be = [Be b'];
   x = max(E,[],2);
   prom = mean(Be,2);
   fig1 = std(Be,[],2);
   plot(x,prom+fig1,x,prom,'.-',x,prom-fig1,e,b,':k')
   ylim(ejeY)
   xlabel('Objective function evaluations')
   ylabel('Best found so far')
   title(sprintf('%d interlaced %d-bit deceptive problems, %d runs',m,k,j))
   legend('\mu + \sigma','\mu','\mu - \sigma',sprintf('run #%d',j),4)
   pause(0.01)
end
plot(x,prom+fig1,x,prom,'.-',x,prom-fig1)
ylim(ejeY)
xlabel('Objective function evaluations')
ylabel('Mejor encontrado')
   title(sprintf('%d interlaced %d-bit deceptive problems, %d runs',m,k,j))
legend('\mu + \sigma','\mu','\mu - \sigma',4)
