function [x,f] = plot(pop,varargin)
% @population/plot
%
% plot(pop,plotStyle='or')
%
% Plots all the individuals of a population. Individuals must have a 
% single segment.
%
% Example:
%   p = population('real',[0 3*pi],10);
%   p = random(p,20);
%   p = evaluate(p,@cos);
%   t = 0:0.1:3*pi; plot(t,cos(t))
%   hold on; plot(p); hold off

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
   plotStyle = varargin{1};
else
   plotStyle = 'or';
end
if pop.params.m ~= 1
  error('Cannot plot for m>1')
end
pop = sort(pop,'phenotype');
x = [];
f = [];
for i=1:length(pop.individual)
  x = [x; pop.individual(i).r];
  f = [f; pop.individual(i).fitness(1)];
end
plot(x(:,1),f,plotStyle)
  
end