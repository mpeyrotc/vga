function k = crossPoint(varargin)
% k = crossPoint(type='integer',digits='traditional',...
%                dist='exponential',N=Inf,B=2,rMin=0,rMax=B^N,D=0)
%
% Returns the crossover point for a vgGA. 
% Parameters:
% type:   'integer'[default] or 'real'  
% digits: 'traditional'[default], 'generalized', or 'continuous'
% dist:   distribution of crossover point,
%         'exponential'[default] or 'uniform'
% N:      number of digits [default Inf]
% B:      base [default 2]
% rMin:   minimum value [default 0]
% rMin:   maximum value [default B^N]
% D:      flag that indicates that we crossing last segment
%
% See also: crossAt

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

global type digits dist
  
% Defaults
type = 'integer';
digits = 'traditional';
dist = 'exponential';
N = Inf;
B = 2;
rMin = 0;
D = 0;

if nargin >= 1
  type = varargin{1};
end
if nargin >= 2
  digits = varargin{2};
end
if nargin >= 3
  dist = varargin{3};
end
if nargin >= 4
  N = varargin{4};
end
if nargin >= 5
 B = varargin{5};
end
if nargin >= 6
  rMin = varargin{6};
end
if nargin >= 7
  rMax = varargin{7};
else
  rMax = B^N;
end
if nargin >= 8
   D = varargin{8};
end

   
if     equal('traditional','exponential')
   k = B^floor((N-D)*rand+D)*(rMax-rMin)/B^N + rMin;
elseif equal('generalized','exponential')
   k = floor(B^((N-D)*rand+D)) * (rMax-rMin)/B^N + rMin;
elseif equal('traditional','uniform')
   k = B.^(floor(logB(ceil((B^N-1-D)*rand+D),B))) * (rMax-rMin)/B^N + rMin;
elseif equal('generalized','uniform')
   k = ceil((B^N-1-D)*rand+D) * (rMax-rMin)/B^N;
elseif equal('continuous','uniform') && (N~=Inf)
   k = ((rMax-rMin)/B^N)*(rand*(B^N-1-D)+1+D) + rMin;
elseif equal('continuous','uniform') && (N==Inf)
   k = rand*(rMax-rMin) + rMin;
else
   error('Crossover for type=''%s'' dist=''%s'' digits=''%s'' and N=%d not implemented',...
      type,dist,digits,N);
end

end

function v = equal(dig, dis)
  global digits dist
  v = isequal(dis,dist) && isequal(dig,digits);
end




