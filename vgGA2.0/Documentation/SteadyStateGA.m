%% Steady-state (non-generational) GA
% 
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
% This script implements a steady-state genetic algorithm, and its
% performance is compared with a generational genetic algorithm.



%% generational vs. steady-state GA 

t_size = 5;      % tournament size for generational GA
N = 50;          % chromosome length
n = 80;          % population size
ms = 2;          % expected mutations per segment
pc = 0.7;        % crossover probability
 
generations = 20;
p = population('integer',N,ms,pc);
p = random(p,n); % same random population for both algorithms
p1 = p;          % population for generational GA
p2 = p;          % population for steady-state GA

p1 = evaluate(p1,@onemax);
best1 = get(p1,'best');
%evals1 = get(p1,'evals');
evals1 = best1.evals;
B = [evals1 best1.fitness];

p2 = evaluate(p2,@onemax);
best2 = get(p2,'best');
%evals2 = get(p2,'evals');
evals2 = best2.evals;
C = [evals2 best2.fitness];

clf
cycle = 0;
for i=1:generations
   p1 = tournament(p1,t_size);
   p1 = crossover(p1);
   p1 = mutation(p1);
   p1 = evaluate(p1,@onemax);
   best1 = get(p1,'best');
   evals1 = best1.evals;
   B = [B;evals1 best1.fitness];
   evals1 = get(p1,'evals');
   B = [B;evals1 best1.fitness];
   plot(B(:,1),B(:,2),'.-b',C(:,1),C(:,2),'.-r')
   grid on
   axis([0 max(evals1,evals2) floor(N/2) N+1])
   legend(sprintf('generational GA (tournament size=%d)',t_size),'steady-state GA (roulette wheel)','location','SouthEast')
   xlabel('Objective function evaluations')
   ylabel('Best-found-so-far')
   title(sprintf('generational GA (t=%d) vs. steady-state GA (cycle=%d)',i,cycle))
   pause(0.01)
   % run steady-state GA until it reaches same number of evaluations
   while 1
      cycle = cycle + 1;
      p2 = roulette(p2,'',1);
      p2 = crossover(p2,1);
      p2 = mutation(p2,1);
      p2 = evaluateLast(p2,@onemax);
      p2 = eraseWeak(p2);
      best2 = get(p2,'best');
      evals2 = get(p2,'evals');
       if best2.fitness > C(end,2)
          C = [C;evals2 best2.fitness];
       end
      if evals2 >= evals1
         evals2 = best2.evals;
         C = [C;evals2 best2.fitness];
         break
      end
   end
   plot(B(:,1),B(:,2),'.-b',C(:,1),C(:,2),'.-r')
   grid on
   axis([0 max(evals1,evals2) floor(N/2) N+1])
   legend(sprintf('generational GA (tournament size=%d)',t_size),'steady-state GA (roulette wheel)','location','SouthEast')
   xlabel('Objective function evaluations')
   ylabel('Best-found-so-far')
   title(sprintf('generational GA (t=%d) vs. steady-state GA (cycle=%d)',i,cycle))
   pause(0.01)
   if best1.fitness==N && best2.fitness==N
      % break if optimal have been found by both algorithms
      break
   end
end

