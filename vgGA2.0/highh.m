function res = highh(r,k,varargin)
% highh(r,k,rMin=0)
% 
% Hard to explain but the analoguos of the digits of the
% high part of number r up to value k. The number r
% takes a minimal value of rMin.
% Notice that highh(r,k,rMin)*(k-rMin) = high(r,k,rMin).
% Works for integers and reals with rMin=0. 
%
% Example:
%
%   a = [2 1 2 0 0]*(3.^[0 1 2 3 4]')
%
%   a =
%
%      23   
%
%   highh(23,3.^[0 1 2 3 4]) =
%
%      23  7  2   0   0
%
% See also: low, high.

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
res = high(r-rMin,k-rMin)./(k-rMin);

end