function pop = crossover(pop,varargin)
% @population/crossover
%
% pop = crossover(pop,lastTwo=0)
%
% Applies crossover to members of a population. The flag lastTwo is
% used to implement a steady state algorithm; crossover is applied only
% two the last two individuals in the population.
%
% See also: crossoverUni

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
                    % (only use for testing)

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

    % choose segment for cross site
    if isinf(N)
       % Segments are equally likely
       j = ceil(rand*pop.params.m);
    else
       % Probability of segment is proportional to number of digits
       j = find(cumsum(N/sum(N))>=rand(),1,'first');
    end
    
    % exchange parameters before cross site
    tmp = pop.individual(i1).r(1:j-1);
    pop.individual(i1).r(1:j-1) = pop.individual(i2).r(1:j-1);
    pop.individual(i2).r(1:j-1) = tmp;

    % exit if type is incorrect
    % this check is probably unnecessary
    if not ( isequal(type, 'real') | isequal(type, 'integer') )
       error('cannot perform crossover over type %s', type);
    end    
    
    % crossover segment j
    k = crossPoint(type, digits, dist, pop.params.N(j),...
       pop.params.B(j),pop.params.rMin(j),pop.params.rMax(j),j==pop.params.m);
    [pop.individual(i1).r(j) pop.individual(i2).r(j)] = ...
       crossAtc(pop.individual(i1).r(j),pop.individual(i2).r(j),k,...
       pop.params.rMin(j),pop.params.rMax(j),pop.params.B(j),pop.params.DeltaR(j),4);
    if k==pop.params.DeltaR(j)
       pop.trace.nISC = pop.trace.nISC + 1;
    end
    
    %     fprintf('%f ',[pop.individual(i1).r(j) pop.individual(i2).r(j)])
    %     fprintf('\n')

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
