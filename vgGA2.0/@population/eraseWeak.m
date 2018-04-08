function pop = eraseWeak(pop,varargin)
% @population/eraseWeak
%
% pop = eraseWeak(pop,N=1)
%
% Erases the weakest N individuals in the population.
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
   N = varargin{1};
else
   N = 1;
end

for i=1:N
   n = length(pop.individual);
   k = length(pop.individual(1).fitness);
   fitness = reshape([pop.individual.fitness],k,n)';
   f = fitness(:,k);
   if pop.params.max
      kill = find(f==min(f));
   else
      kill = find(f==max(f));
   end
   keep = (1:n)~=kill(1);
   pop.individual = pop.individual(keep);
end
