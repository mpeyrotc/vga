function pop = mutation(pop,varargin)

% population/mutation
%
% pop = mutation(pop,last=0)
%
% Applies mutation to all the members of a population. The flag last
% is used to implement a steady state algorithm; mutation is applied to the
% last individual in the population.

%************************************************************
%*                                                          *
%*   vgGA2.0: The Virtual Gene Genetic Algorithm            *
%*                                                          *
%*   Copyright (c) All Rights Reserved 2016-08-30           *
%*   Manuel Valenzuela-Rend�n                               *
%*   manuel.valenzuela.r@gmail.com                          *
%*   http://sites.google.com/site/manuelvalenzuelar/        *
%*                                                          *
%************************************************************

if pop.params.pm <= eps
   return
end

if length(varargin)>=1
   last = varargin{1};
else
   last = 0;
end

if last
   start = length(pop.individual);
else
   start = 1;
end

fLen = length(pop.individual(1).fitness);
%k = length(pop.individual(1).fitness);

for i=start:length(pop.individual)
   r = pop.individual(i).r;
   for j=1:pop.params.m
      % Mutate parameter j of individual i
      while pop.mutclock.DeltaI(j) == 0
         pop.trace.nMuts = pop.trace.nMuts + 1;
         if isequal(pop.params.digits,'traditional')
            % apply traditional mutation (without gamma correction)
            pop.individual(i).r(j) = ...
               mutate( pop.individual(i).r(j),...
               pop.mutclock.k(j),...
               pop.params.delta(j),...
               pop.params.rMin(j) );            
         elseif isequal(pop.params.digits,'generalized') || isequal(pop.params.digits,'continuous')
            % apply mutation with gamma correction
            pop.individual(i).r(j) = ...
               mutateGen( pop.individual(i).r(j),...
               pop.mutclock.k(j),...
               pop.params.delta(j),...
               pop.params.rMax(j),...
               pop.params.rMin(j) );
         else
            % you shouldn't be here
            error('%s is not a valid type of digits',pop.params.digits)
         end
         pop = nextMut(pop,j);
      end
      pop.mutclock.DeltaI(j) = pop.mutclock.DeltaI(j) - 1;
   end
   % set fitness to NaN, if individual is changed
   if ~isequal(r,pop.individual(i).r)
      pop.individual(i).fitness = ones(1,fLen)*NaN;
   end
end


 
