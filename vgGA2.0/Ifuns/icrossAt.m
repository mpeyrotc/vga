function [h1,h2] = icrossAt(p1,p2,m,varargin)
% [h1,h2] = icrossAt(p1,p2,m,B=2)
%
% Performs crossover of p1 and p2 at digit m. 
%
% Example:
%  >> p1 = base2dec('54321',6);
%  >> p2 = base2dec('00000',6);
%  >> [h1,h2] = icrossAt(p1,p2,3,6);
%  >> dec2base([h1 h2],6)
% ans =
% 00321
% 54000

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

chi = ilow(p1,m,B) - ilow(p2,m,B);
h1 = p2 + chi;
h2 = p1 - chi;

end