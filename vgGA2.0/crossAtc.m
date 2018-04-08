function [h1,h2,chi] = crossAtc(r1,r2,k,rMin,rMax,B,Dr,varargin)
% [h1,h2,chi] = crossAtc(r1,r2,k,rMin,rMax,B,Dr,correction=4)
%
% Performs crossover of r1 and r2 at value k with correction. The 
% numbers r1 and r2 take a minimal value or rMin. Notice that 
% h1 + h2 = r1 + r2. Works for integers and reals. Indicated crossover 
% correction is applied.
%
% See also: crossAt, crossAtnorm, crossAtUniform

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
   correction = varargin{1};
else
   correction = 4;
end

% Crossover without correction
if Dr>eps
   % If possible, perform normalized crossover without correction
   [h1,h2] = crossAtnorm(r1,r2,k,Dr,rMin);
else
   % If not, perform crossover without correction (for N=Inf)
   [h1,h2] = crossAt(r1,r2,k,rMin);
end

% Perform chosen correction
if correction==1
   if h1>=rMax || h2>=rMax  % correction 1: no crossover
      h1 = r1;
      h2 = r2;
   end
elseif correction==2        % correction 2: crossover at traditional digit
   if h1>=rMax || h2>=rMax
      kc = B^(floor(logB((k-rMin)/Dr,B)))+rMin; 
      [h1,h2] = crossAt(r1,r2,kc,rMin);
   end
elseif correction==3        % correction 3: maximum possible value
   if h2>=rMax
      h2 = rMax - Dr;
   end
   if h1>=rMax
      h1 = rMax - Dr;
   end
elseif correction==4        % correction 4: h1+h2=maximum posible value
   if h2>=rMax
      h2 = rMax + rMin - Dr - h1;
   end
   if h1>=rMax
      h1 = rMax + rMin - Dr - h2 ;
   end
else
  % If correction not in {1,2,3,4}, perform no correction 
end

end



