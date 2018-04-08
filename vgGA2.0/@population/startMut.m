function pop = startMut(pop)
% @population/startMut
%
% pop = startMut(pop)
%
% Starts or restarts the mutation clock.
%
% See also: nextMut

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

rMin = pop.params.rMin;
N = pop.params.N;

pop.mutclock.DeltaI = zeros(1,pop.params.m);     % individuals to next mutation 
pop.mutclock.mMax = N;                           % max digit for mutation

% Set digit and value of first mutation
pop.mutclock.m = ones(1,pop.params.m);
pop.mutclock.n = zeros(1,pop.params.m);
if isequal(pop.params.type,'integer')
   pop.mutclock.k = zeros(1,pop.params.m);
else
   pop.mutclock.k = rMin;
end

