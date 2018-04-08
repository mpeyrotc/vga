function pop = random(pop,n,varargin)
% @population/random
%
% pop = random(pop,n,add='N')
%
% Generates a random population of size n. If add='Y' it appends the
% random individuals to the existing population.

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
   ad = varargin{1};
else
   ad = 'N';
end
if isequal(ad,'Y') || isequal(ad,'y') || isequal(ad,'YES') || ...
      isequal(ad,'Yes') || isequal(ad,'yes')
elseif isequal(ad,'N') || isequal(ad,'n') || isequal(ad,'NO') || ...
      isequal(ad,'No') || isequal(ad,'no')
   pop.individual = [];
else
   error('add=%s not valid',add)
end

% These fields are the same for all new individuals
p.fitness = NaN;

if isequal(pop.params.type,'integer')
   for i=1:n
      for j=1:pop.params.m
         p.r(j) = floor(pop.params.B(j)^pop.params.N(j)*rand);
      end
      % pop.individual(i) = p;
      pop.individual = [pop.individual p];
   end
elseif isequal(pop.params.type,'real')
   if ~isequal(pop.params.digits,'continuous')
      for i=1:n
         for j=1:pop.params.m
            temp = floor(pop.params.B(j)^pop.params.N(j)*rand);
            p.r(j) = pop.params.DeltaR(j)*temp + pop.params.rMin(j);
         end
         pop.individual = [pop.individual p];
      end
   else
      for i=1:n,
         for j=1:pop.params.m,
            p.r(j) = (pop.params.rMax(j)-pop.params.rMin(j))*rand + pop.params.rMin(j);
         end
         % pop.individual(i) = p;
         pop.individual = [pop.individual p];
      end
   end
else
   error('%s is not a valid type of population',type)
end

end
