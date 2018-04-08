function pop = tournament(pop, varargin)
% @population/tournament
%
% pop = tournament(pop,tsize=2)
%
% Implements tournament selection of size tsize.
%
% See also: btournament, linRanking

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

RANDOM = 1;  % Set to 0 only for testing purposes 

if length(varargin)>=1
   size = floor(abs(varargin{1}));
else
   size = 2;
end

% Decisions are made based on the last component of the fitness
k = length(pop.individual(1).fitness); 

n = length(pop.individual);
if RANDOM
   ind = randperm(n);
else
   ind = 1:n;
end
% Copy first size-1 individuals to the end
pop.individual = [pop.individual pop.individual(ind(1:size-1))];
ind = [ind n+1:n+size-1];

for i=1:n
  best = i;
  for j=i+1:i+size-1
    if pop.params.max == 1
      if pop.individual(ind(j)).fitness(k) > pop.individual(ind(best)).fitness(k)
         best = j;
      end
    else
       if pop.individual(ind(j)).fitness(k) < pop.individual(ind(best)).fitness(k)
          best = j;
       end
    end
  end
  pop.individual(ind(i)) = pop.individual(ind(best));
end
pop.individual = pop.individual(1:n);

end


