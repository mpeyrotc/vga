function [h1,h2,chiDr] = crossAtnorm(r1,r2,k,varargin)

% [h1,h2,chiDr] = crossAtnorm(r1,r2,k,Dr=1,rMin=0)
%
% Performs normalized crossover of r1 and r2 at value k. Normalized
% crossover reduces rounding errors. The numbers r1 and r2 take a minimum 
% value or rMin. Notice that h1 + h2 = r1 + r2. 
%
% See also: crossAt, crossAtc, crossAtUniform

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
   Dr = varargin{1};
else
   Dr = 1;
end
if length(varargin)>=2
   rMin = varargin{2};
else
   rMin = 0;
end

% Normalize r1, r2, k, and rMin
r1n   =   r1/Dr;
r2n   =   r2/Dr;
kn    =    k/Dr;
rMinn = rMin/Dr;

% obtain chi*Dr
chiDr = (mod(r1n-rMinn,kn-rMinn) - mod(r2n-rMinn,kn-rMinn))*Dr;
h1 = r2 + chiDr;
h2 = r1 - chiDr;

end


