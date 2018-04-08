function value = basemax(x,varargin)
% basemax(x,B=2)
%
% Implements the function basemax(x(1),B) + basemax(x(2),B) + ...
% where basemax returns the number of digits base B of x equal to B-1.
%
% See also: onemax, zeromax

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

value = 0;
for i=1:length(x)
  value = value + basemaxScalar(x(i),B);
end

end

function res = basemaxScalar(x,B)
y = dec2base(x,B,B);
res = sum(y == num2str(B-1));
end