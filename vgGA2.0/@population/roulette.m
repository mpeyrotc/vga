function pop = roulette(pop,varargin)
% @population/roulette
%
% pop = roulette(pop,normalized=0,add=0)
%
% Implements roulette wheel selection. The option add=1 is used to 
% implement steady state selection; two copies are added to the 
% population. the flag normalized=1 indicates that fitnesses are already
% normalized, i.e., that their mean is 1.0.
%
% See also: sus
  
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
   normalized = varargin{1};
   if isempty(normalized)
      normalized = 0;
   end
else
   normalized = 0;
end
if length(varargin)>=2
   add = varargin{2};
else
   add = 0;
end

n = length(pop.individual);
k = length(pop.individual(1).fitness);

if ~normalized
   fitness = reshape([pop.individual.fitness],k,n)';
   f = fitness(:,k);
   averageFitness = mean(f);
   for i=1:n,
      pop.individual(i).fitness(k+1) = ...
         pop.individual(i).fitness(k)/averageFitness;
   end
   k = k + 1;
end

if add
   newPopSize = n+2;
else
   newPopSize = 2*n;
end

% Increase the population size with selected individuals
for j=n+1:newPopSize
  pointer = rand*n; % random number in [0,n)
  i = 0;
  sumFitness = 0;
  while sumFitness<=pointer,
    i = i + 1;
    sumFitness = sumFitness + pop.individual(i).fitness(k);
  end
  pop.individual(j) = pop.individual(i);
end
if ~add
   % Keep only the last n individuals
   pop.individual = pop.individual(n+1:2*n);
end
if add && ~normalized
   % Erase normalized fitnesses
   for i=1:newPopSize
      pop.individual(i).fitness = pop.individual(i).fitness(1:k-1);
   end
end

% % Another way to do the above is using the function cumsum
% % and normalized fitness needs not be calculated
% cumFitness = cumsum(f);
% totalFitness = cumFitness(n);
% pointers = sort(rand(n,1)*totalFitness,1,'descent');
% for i=1:n
%    j = find(pointers(i)<cumFitness,1);
%    pop.individual(i+n) = pop.individual(j);
% end
% % Keep only the last n individuals
% pop.individual = pop.individual(n+1:2*n);

end
