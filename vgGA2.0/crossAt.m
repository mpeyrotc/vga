function [h1,h2,chi] = crossAt(r1,r2,k,varargin)
% [h1,h2,chi] = crossAt(r1,r2,k,rMin=0)
%
% Performs crossover of r1 and r2 at value k. The numbers r1 and 
% r2 take a minimum value or rMin. Notice that h1 + h2 = r1 + r2. 
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
   rMin = varargin{1};
else
   rMin = 0;
end

chi = mod(r1-rMin,k-rMin) - mod(r2-rMin,k-rMin);
h1 = r2 + chi;
h2 = r1 - chi;

end


