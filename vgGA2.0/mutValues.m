function values = mutValues(r,k,delta,varargin)
% mutValues(r,k,delta,rMin=0)
%
% Returns a vector of all the possible results of the 
% mutation of r at value k. The number r takes a minimal 
% value of rMin (default = 0). Works for integers and 
% reals. Does not include gamma correction.
% (This function is used only for testing.)
%
% See also: mutValuesGamma, mutate
  
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
sum2 = (k - rMin)*(0:delta-1);
values = sum1 + sum2;

end









