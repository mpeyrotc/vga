function pop = scale(pop, varargin)
% @population/scale
%
% pop = scale(pop, Cmult=2)
%
% Implements linear scaling.
%
% See also: roulette, sus

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

global fMin fMax fAvg Cmult

if length(varargin)>=1
   Cmult = varargin{1};
else
   Cmult = 2;
end

n = length(pop.individual);
k = length(pop.individual(1).fitness);

fitness = reshape([pop.individual.fitness],k,n)';
f = fitness(:,k);
fMin = min(f);
fMax = max(f);
fAvg = mean(f);

if pop.params.max==1
   if f1(fMin) >= 0
      fp = f1(f);
   else
      fp = f2(f);
   end
else
   if f1(fMax) >= 0
      fp = f1Min(f);
   else
      fp = f2Min(f);
   end
end   

for i=1:n
   pop.individual(i).fitness(k+1) = fp(i);
end

end

function fp = f1(f)
global fMax fAvg Cmult
fp = (f-fAvg) * (Cmult-1) / (fMax-fAvg) + 1;
end

function fp = f2(f)
global fMin fMax Cmult
fp = (f-fMin) * Cmult / (fMax-fMin);
end

function fp = f1Min(f)
global fMin fAvg Cmult
fp = (Cmult-1)/(fAvg-fMin)*(fAvg-f) + 1;
end

function fp = f2Min(f)
global fMin fMax Cmult
fp = Cmult/(fMax-fMin)*(fMax-f);
end




  
  

