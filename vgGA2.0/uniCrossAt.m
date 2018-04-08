function [h1,h2,template] = uniCrossAt(p1,p2,template,varargin)
% Performs uniform crossover of p1 and p2 using a binary (vector) template
% 
% [h1 h2] = uniCrossAt(p1,p2,template,B=2)
%
% Example:
%
% [h1 h2] = uniCrossAt(15,0,[1 0 1 1]);
% dec2bin([h1 h2])
%    1011
%    0100
%
% Works on integers and traditional digits only.
%
% See also: uniCrossover, crossAt, crossAtc

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
   B = varargin{1};
else
   B = 2;
end

N = length(template);

values = B.^(N:-1:0);
v1 = mod(p1,values(1:N)) - mod(p1,values(2:N+1));
v2 = mod(p2,values(1:N)) - mod(p2,values(2:N+1));
h1 = v1* template' + v2*~template';
h2 = v1*~template' + v2* template';

end
