function pop = init(pop)
% @population/init
%
%  pop = init(pop)
%
%  Erases all individuals and resets best individual found.

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

% Start best found
if isequal(pop.params.type,'real')
   pop.best.r = pop.params.rMin;
elseif isequal(pop.params.type,'integer')
   pop.best.r = zeros(1,pop.params.m);
end

if pop.params.max == 1
   pop.best.fitness = -Inf;
else
   pop.best.fitness = Inf;
end
pop.best.evals = 0;
pop.evals = 0;

% Start empty population
pop.individual = [];

% Start empty mutation clock
pop.mutclock = [];

% Start empty tracing structure
pop.trace.nMuts = 0;
pop.trace.nCross = 0;
pop.trace.nISC = 0;

% Start mutation clock
pop = startMut(pop);
if pop.params.pm > 0
   for i=1:pop.params.m
      pop = nextMut(pop,i);
  end
end

end