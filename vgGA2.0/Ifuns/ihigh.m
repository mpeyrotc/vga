function res = ihigh(p,m,varargin)
% Ifuns/ihigh(p,m,B=2) = H_m(p)
%
% High part of integer p above digit m of base B.
%
% Example:
% >> dec2base( ihigh(base2dec('45123',6),[1 2 3 4 5],6), 6)
% ans = 
% 45120
% 45100
% 45000
% 40000
% 00000
%
% See also: ilow, ihighh
 
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

res = p - mod(p,B.^m);

end
