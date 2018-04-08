function res = imutValues(p,m1,m2,varargin)
% Ifuns/imutValues(p,m1,m2,B=2)
%
% Returns a vector of all the possible results of the
% mutation of digits m1+1 through m2.
%
% Example:
% >> dec2base(imutValues(base2dec('333333',4),1,3,4),4) 
% Returns all possible results of mutating digits 2 and 3 of number 33333
% in base 4.
%
% ans =
% 333003
% 333013
% 333023
% 333033
% 333103
% 333113
% 333123
% 333133
% 333203
% 333213
% 333223
% 333233
% 333303
% 333313
% 333323
% 333333
%
% See also: iMutate

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

ran = 0:1:B^(m2-m1)-1;
res = ilow(p,m1,B) + ihigh(p,m2,B) + B^(m1)*ran;
  
end



