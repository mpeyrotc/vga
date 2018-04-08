function res = gdigit(p,n,varargin)
% Gfuns/gdigit(p,n,B=2)
% 
% Generalized digit of base B and value n integer p.
% 
% Example:
% >> dec2base( gdigit(base2dec('45123',6),6.^[1 2 3 4 5],6),6)
%
% ans = 
% 3
% 2
% 1
% 5
% 4
%
%  See also: ghighh, gsegment

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

res = glow(ghighh(p, n./B),B);

end