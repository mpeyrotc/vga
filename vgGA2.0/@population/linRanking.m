function pop = linRanking(pop,varargin)
% @population/linRanking
%
% pop = linRanking(pop,cMult=2)
%
% Implements linear ranking. 
%
% See also: tournament, btournament

%************************************************************
%*                                                          *
%*   vgGA2.0: The Virtual Gene Genetic Algorithm            *
%*                                                          *
%*   Copyright (c) All Rights Reserved 2003-2017            *
%*   Manuel Valenzuela-Rend�n                               *
%*   manuel.valenzuela.r@gmail.com                          *
%*   http://sites.google.com/site/manuelvalenzuelar/        *
%*                                                          *
%************************************************************

if length(varargin)>=1
   cMult = varargin{1};
else
   cMult = 2;
end

if cMult<=1 || cMult>2  
   error('Invalid value of cMult')
end

n = length(pop.individual);
k = length(pop.individual(1).fitness);
fitness = reshape([pop.individual.fitness],k,n)';
[~,I] = sortrows(fitness);

if pop.params.max
   rank(I) = 1:n-1;
else
   rank(I(n:-1:1)) = 1:n-1;
end

fp = 2-cMult+2*(cMult-1)*rank'/(n-1);

for i=1:n
   pop.individual(i).fitness(k+1) = fp(i);
end
