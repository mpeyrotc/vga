function pop = evaluateLast(pop,objective_function,varargin)

% @population/evaluateLast
%
% pop = evaluateLast(pop,objective_function,N=1,setBestFlag=1)
%
% Evaluate the last N individuals in the population.
%
% See also: evaluate, eraseWeak

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

if length(varargin)>=1
   N = varargin{1};
else
   N = 1;
end

if length(varargin)>=2
   setBestFlag = varargin{2};
else
   setBestFlag = 1;
end
n = length(pop.individual);

for i=n-N+1:n
   if isnan(pop.individual(i).fitness)
      pop.individual(i).fitness = ...
         objective_function(pop.individual(i).r);
      pop.evals = pop.evals + 1;
   end
   if setBestFlag
      if pop.params.max == 1
         if pop.individual(i).fitness(1) > pop.best.fitness(1)
            pop.best.fitness(1) = pop.individual(i).fitness(1);
            pop.best.r = pop.individual(i).r;
            pop.best.evals = pop.evals;
         end
      else
         if pop.individual(i).fitness(1) < pop.best.fitness(1)
            pop.best.fitness(1) = pop.individual(i).fitness(1);
            pop.best.r = pop.individual(i).r;
            pop.best.evals = pop.evals;
         end
      end
   end
end
