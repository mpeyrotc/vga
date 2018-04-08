function res = ilow(p,m,varargin)
% Ifuns/ilow(p,m,B=2) = L_m(p)
%
% Low part of integer p up to digit m of base B.
%
% Example:
% >> dec2base( ilow(base2dec('45123',6),[1 2 3 4 5],6), 6)
% ans = 
% 00003
% 00023
% 00123
% 05123
% 45123
%
% See also: ihigh, ihighh
 
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

res = mod(p,B.^m);

end
