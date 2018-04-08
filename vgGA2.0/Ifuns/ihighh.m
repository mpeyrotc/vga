function res = ihighh(p,m,varargin)
% Ifuns/ihighh(p,m,B=2) = \hat{H}_m(p)
%
% Digits of the high part of integer p above digit m of base B.
%
% Example:
% >> dec2base( ihighh(base2dec('45123',6),[1 2 3 4 5],6), 6)
% ans = 
% 4512
% 0451
% 0045
% 0004
% 0000
%
% See also: ihigh, idigit

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

res = ihigh(p,m,B)./(B.^m);

end