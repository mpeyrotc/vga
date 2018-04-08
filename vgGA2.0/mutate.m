function value = mutate(r,k,delta,varargin)
% mutate(r, k, delta, rMin=0)
%
% Returns the mutation of r at value k. The number r 
% takes a minimal value of rMin (default = 0). Works for 
% integers and reals.
% 
% See also: mutateGen

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
   rMin = varargin{1};
else
   rMin = 0;
end

sum1 = low(r,k,rMin) + high(r,(k-rMin)*delta+rMin,rMin);
sum2 = (k - rMin)*floor(rand*delta);
value = sum1 + sum2;

% Parche por problemas de redondeo con segmentos reales
if value<rMin
    value = rMin;
end

end

