function pop = crossoverUni(pop,P0,varargin)
% @population/crossoverUni
%
% pop = crossoverUni(pop,P0,lastTwo=0)
%
% Applies uniform crossover to members of a population. The flag lastTwo is
% used to implement a steady state algorithm; if set to 1, crossover is 
% applied only to the last two individuals in the population.

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

CROSSOVER_TEST = 0; % cross individuals in consecutive positions
                    % only use this for testing

% Use lastTwo=1 for steady-state algorithm
if length(varargin)>=1
   lastTwo = varargin{1};
else
   lastTwo = 0;
end
   
if mod(length(pop.individual),2) ~= 0 
   error('Population size must be even for crossover')
end

fLen = length(pop.individual(1).fitness);

type = pop.params.type;
dist = pop.params.dist;

if lastTwo || CROSSOVER_TEST 
   index = 1:length(pop.individual); 
else
   index = randperm(length(pop.individual));
end

if lastTwo
   start = length(pop.individual)-1;
else
   start = 1;
end

N = pop.params.N;

for i=start:2:length(pop.individual)

  % digits might change due to non-overflow crossover correction
  digits = pop.params.digits;

  if rand <= pop.params.pc % perform crossover
    % identify individuals to be crossed over
    pop.trace.nCross = pop.trace.nCross + 1;
    i1 = index(i);
    i2 = index(i+1);

    % Crossover individuals i1 and i2
    r1 = pop.individual(i1).r;
    r2 = pop.individual(i2).r;

    % exit if type is incorrect
    % this check is probably unnecessary
    if ~isequal(digits,'traditional')
       error('Cannot perform uniform crossover for %s digits',digits)
    end
    if ~isequal(type,'integer')
       error('Cannot perform uniform crossover for type',type)
    end
    
    % crossover all segments
    for j=1:pop.params.m
       template = rand(1,N(j))>P0;
       [pop.individual(i1).r(j) pop.individual(i2).r(j)] = ...
          crossAtUniform(r1(j),r2(j),template,pop.params.B(j));       
    end
          
    % erase fitness of each offspring if it is different to both parents
    % (this should save some function evaluations when the population tends
    % to converge).
    f1 = pop.individual(i1).fitness;
    f2 = pop.individual(i2).fitness;
    if isequal(pop.individual(i1).r,r2)
       % offspring 1 is equal to parent 2
       pop.individual(i1).fitness = f2;
    elseif ~isequal(pop.individual(i1).r,r1)
       % offspring 1 is not equal to parent 1
       pop.individual(i1).fitness = ones(1,fLen)*NaN;
    end
    if isequal(pop.individual(i2).r,r1)
       % offspring 2 is equal to parent 1
       pop.individual(i2).fitness = f1;
    elseif ~isequal(pop.individual(i2).r,r2)
       % offspring 2 is not equal to parent 2
       pop.individual(i2).fitness = ones(1,fLen)*NaN;
    end
    
  end % if crossover

end % for

if lastTwo
   % keep only first offspring 
   pop.individual = pop.individual(1:length(pop.individual)-1);
end

end
