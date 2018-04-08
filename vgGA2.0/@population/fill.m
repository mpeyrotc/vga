function pop = fill(pop, varargin)

% population/fill
%
% pop = nextMut(pop, value=0)
%
% Fills the population with value.
%
% See also: set

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

if length(varargin) >= 1
   value = varargin{1};
else 
   value = 0;
end

k = length(pop.individual(1).r);
pat = ones(1,k)*value;
for i=1:length(pop.individual)
   pop.individual(i).r = pat;
end
