function pop = max(pop)
% @population/max
%
% pop = max(pop)
%
% Sets the population to maximization.
% 
% See also: min
 
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

pop.params.max = 1;
pop.best.fitness = -Inf(1,pop.params.noFunctions);
