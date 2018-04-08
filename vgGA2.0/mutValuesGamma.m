function [values,gamma] = mutValuesGamma(r,k,N,varargin)
% mutValuesGamma(r,k,N,B=2,delta=B,rMax=B^N,rMin=0)
%
% Returns a vector of all the possible results of the 
% mutation of p at value n considering the gamma correction. 
%
% The number r takes a minimal value of rMin (default = 0). 
% Works for integers and reals. 
% (This function is used only for testing.)
%
% See also: mutate, mutValues, mutateGamma
  
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

B = 2;
if length(varargin)>=1
   B = varargin{1};
end
delta = B;
if length(varargin)>=2
   delta = varargin{2};
end
rMax = B^N;
if length(varargin)>=3
   rMax = varargin{3};
end
rMin = 0;
if length(varargin)>=4
   rMin = varargin{4};
end
Dr = (rMax-rMin)/B^N;
gamma = (rMax-Dr-low(r,k,rMin)-high(r,(k-rMin)*delta+rMin,rMin))/(k-rMin);
values = low(r,k,rMin)+high(r,(k-rMin)*delta+rMin,rMin)+(k-rMin)*(0:min(delta-1,gamma));

end

