function [x,prom,desv] = plotGA(n,popsize,obj,methods,generations,seed,type,varargin)
% [x,prom,desv] = plotGA(n,popsize,objective_function,methods,generations,
%                        seed,'integer',N,ms,pc,B,delta,dist,digits)
% [x,prom,desv] = plotGA(n,popsize,objective_function,methods,generations,
%                        seed,'real',R,N,ms,pc,B,delta,dist,digits)
%
% This function runs n times a generational GA using runGA to generate a
% best-found curve (average of best found plus/minus a standard deviation)
% vs. the number of function evaluations. Each run is done for the 
% indicated number of generations. The population size is popsize. Each 
% cycle, the methods indicated (plus evaluate) are applied to the population.
% Seed is passed to function rng, and can be 'shuffle' (randomized seed), 
% 'default' (as if you restarted Octave/MATLAB), a positive integer, or 
% empty. See population for the rest of the parameters.
%
% Example:
%    plotGA(10,20,@sum,[],30,'random','integer',[4 4],1,0.9);
%
% See also: runGA, evaluate, population, rng
  
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

DISPLAY_POP = 0; % Display final population after each run?
MIN_MAX = 0;     % Display min and max instead of plus/minus std. dev.

if isempty(methods)
   methods = {@tournament,@crossover,@mutation};
end
if ~isempty(seed)
   if isequal(seed,'random')
      seed = 'shuffle';
   end
   rng(seed);
end

fprintf('\n*** Starting run #1 ***\n')
p = createPop(type,varargin);
p = random(p,popsize);
[p,data] = runGA(p,methods,obj,generations);
if DISPLAY_POP
  display(p);
end
X = data(:,1)';
x = X;
Y = data(:,2)';
for i=2:n
   fprintf('\n*** Starting run #%d ***\n', i)
   p = createPop(type,varargin);
   p = random(p,popsize);
   [p,data] = runGA(p,methods,obj,generations);
   if DISPLAY_POP
     display(p);
   end
   %x = B(:,1);
   y = data(:,2)';
   Y = [Y; y];
end
prom = mean(Y);
desv = std(Y);
maxi = max(Y);
mini = min(Y);
if prom(1) <= prom(length(prom))
  best = max(maxi);
else
  best = min(mini);
end

fprintf('\n *** best fitness found = %f ***\n', best)
if MIN_MAX
   plot(X,mini,X,prom,X,maxi)
   legend('minimal','average','maximal')
   limits = ylim;
   ylim([limits(1) limits(2)*1.1])
else
   plot(X,prom+desv,X,prom,X,prom-desv)
   legend('location','best','average + std dev','average','average - std dev',0)
end

if isa(obj,'function_handle')
   obj = func2str(obj);
end
title(['Best-found curve for obj function "',obj,'"'])
ylabel('best found')
xlabel('number of function evaluations')

end

function p = createPop(type,v)
switch length(v)
case 0
   p = population(type);
case 1
   p = population(type,v{1});
case 2
   p = population(type,v{1},v{2});
case 3
   p = population(type,v{1},v{2},v{3});
case 4
   p = population(type,v{1},v{2},v{3},v{4});
case 5
   p = population(type,v{1},v{2},v{3},v{4},v{5});
case 6
   p = population(type,v{1},v{2},v{3},v{4},v{5},v{6});
case 7
   p = population(type,v{1},v{2},v{3},v{4},v{5},v{6},v{7});
otherwise
   p = population(type,v{1},v{2},v{3},v{4},v{5},v{6},v{7},v{8});
end

end
