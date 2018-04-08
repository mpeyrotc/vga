function pop = evaluate(pop,objective_function,varargin)
% @population/evaluate
%
% pop = evaluate(pop,objective_function,iStart=1,setBestFlag=1)
% 
% Evaluates population with objective_function starting from individual
% iStart. If setBestFlag=0 best individual is not updated.
%
% See also: evaluateLast

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
   start = varargin{1};
else
   start = 1;
end

if length(varargin)>=2
   setBestFlag = varargin{2};
else
   setBestFlag = 1;
end
n = length(pop.individual);
for i=start:n
   if isnan(pop.individual(i).fitness)
      pop.individual(i).fitness = objective_function(pop.individual(i).r);
      pop.evals = pop.evals + 1;
   else
      pop.individual(i).fitness = ...
         pop.individual(i).fitness(1);  % keep only first component of fitness
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
