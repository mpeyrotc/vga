function pop = min(pop)
% @population/min
%
% pop = min(pop)
%
% Sets the population to minimization.
%
% See also: max
 
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

pop.params.max = 0;
pop.best.fitness = Inf(1,pop.params.noFunctions);
