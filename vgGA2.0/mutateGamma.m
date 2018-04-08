function [value,gamma] = mutateGamma(r,k,N,varargin)
% [rMutate,gamma] = mutateGamma(r,k,N,B=2,delta=B,rMax=B^N,rMin=0)
% [rMutate,gamma] = mutateGamma(r,k,Inf,delta,rMax,rMin=0)
%
% Returns the mutation of r at value k. The number r 
% takes a minimal value of rMin (default = 0). Make the gamma correction, 
% Works for integers and reals.
% 
% See also: mutate, mutValuesGamma

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

if isinf(N)
   delta = varargin{1};
   rMax = varargin{2};
   if length(varargin)>=3
      rMin = varargin{3};
   end
   Dr = eps;
else
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
end
gamma = (rMax-Dr-low(r,k,rMin)-high(r,(k-rMin)*delta+rMin,rMin))/(k-rMin);
gamma = max(1,gamma);

if isinf(N)
   value = low(r,k,rMin) + high(r,(k-rMin)*delta+rMin,rMin) + (k-rMin)*gamma*rand;
else
   value = low(r,k,rMin) + high(r,(k-rMin)*delta+rMin,rMin) + (k-rMin)*(B^randi([0 floor(logB(gamma,B))])-1);
end

%fprintf('r=%f k=%f gamma=%f value=%f\n',r,k,gamma,value)
%pause

end

