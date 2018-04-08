function value = iMutate(p,m1,m2,varargin)
% Ifuns/iMutate(p,m1,m2,B=2)
%
% Returns the imutation of p from digit m1 to digit m2. 
%
% Example:
% dec2base(iMutate(base2dec('55555',6),2,4,6),6)
% mutates digits 3 and 4 in the number 55555 base 6.
%
% See also: imutValues

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

value = ilow(p,m1,B) + ihigh(p,m2,B) + (B^m1)*randi([0 B^(m2-m1)-1]);

end