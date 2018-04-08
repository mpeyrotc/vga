function res = isegment(p,m1,m2,varargin)
% Ifuns/isegment(p,m1,m2,B=2) = segment_{m1,m2}(p)
%
% Segment of bits m1+1 through m2 of integer p
%
% % Example:
% >> dec2base( isegment(base2dec('45123',6),1,4,6), 6)
% ans = 
% 512
%
% See also: ihighh, idigit

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
  
if length(varargin) >= 1
   B = varargin{1};
else
   B = 2;
end

delta = m2 - m1;
res = ilow(ihighh(p,m1,B),delta,B);

end