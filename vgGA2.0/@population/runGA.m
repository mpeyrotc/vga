function [pop,data] = runGA(pop,methods,obj_function,generations,varargin)
% @population/runGA
%
% [pop,data] = runGA(pop,methods,objective_function,generations)
%
% This method can be used to implement a generational genetic algorithm.
% The population is initially evaluated using the objective_function.
% Then, the provided methods (plus evaluate) are applied to the population,
% for the given number of generations. 
%
% For example, the following commands create a population with two segments
% of 4 bits, fills the population with 20 random individuals, and runs the
% cycle of tournament, crossover, mutation, and selection for 20
% generations. A plot of the best-found-so-far is created.
%    p = population('integer',[5 5 5],1,0.9);
%    p = random(p,20);
%    methods = {@tournament,@crossover,@mutation};
%    [p,data] = runGA(p,methods,@x2y2,20);
%    plot(data(:,1),data(:,2),'o-')
%    xlabel('function evaluations')
%    ylabel('best-found-so-far')
%
% See also: plotGA
  
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

if isempty(pop.individual)
  data = [];
  warning('population is empty')
  return
end

if pop.evals == 0
   pop = evaluate(pop, obj_function);
end

data = [pop.evals, pop.best.fitness(1), pop.best.r];

if isempty(varargin)
   if isequal(pop.params.type,'integer')
      FMT = '%d';
   else
      FMT = '%f';
   end
else
   FMT = varargin{1};
end

fprintf('\n gen  evals  best\n')

pop = evaluate(pop,obj_function);
for gen=1:generations
   for j=1:length(methods)
      pop = methods{j}(pop);
   end   
   pop = evaluate(pop, obj_function);
   fprintf('%4d %6d  f(',gen,pop.evals)
   if pop.params.m>1
      fprintf(strcat(FMT,',  '),pop.best.r(1:end-1))
   end
   fprintf(strcat(FMT,'  '),pop.best.r(end))
   
   fprintf(') = %f\n',pop.best.fitness(1))
   data = [data; pop.evals, pop.best.fitness(1), pop.best.r];
end

end
