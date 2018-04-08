function pop = btournament(pop, compare_function)
% @population/btournament
%
% pop = btournament(pop, compare_function)
%
% Implements binary tournament selection with a user provided
% function that compares two individuals and returns true if
% the first individual is beter or equal than the second individual.
%
% See also: tournament

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

RANDOM = 1;          % Set to 0 only for testing purposes 
COMP_BY_FITNESS = 1; % Set to 1 if fitness is a vector,
                     % if 0, compare_function receives the phenotypes of
                     % the two individuals being compared

n = length(pop.individual);

if RANDOM
   ind = randperm(n);
else
   ind = 1:n;
end
pop.individual = [pop.individual pop.individual(ind(1))];
ind(end+1) = n+1;
% Copy first individual to the end
ind = [ind ind(1)];
for i=1:n
   if COMP_BY_FITNESS
      condition = compare_function(pop.individual(ind(i)).fitness,pop.individual(ind(i+1)).fitness);
   else
      condition = compare_function(pop.individual(ind(i)).r,pop.individual(ind(i+1)).r);
   end
   if ~condition
      pop.individual(ind(i)) = pop.individual(ind(i+1));
   end
end
pop.individual = pop.individual(1:n);

end