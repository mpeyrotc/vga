function value = zeromax(x,varargin)
% zeromax(x,B=2)
%
% Implements the function zeromax(x(1),B) + zeromax(x(2),B) + ...
% 
% See also: onemax, basemax

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
  value = value + zeromaxScalar(x(i),B);
end

function res = zeromaxScalar(x,B)
y = dec2base(x,B)
res = sum(y == '0');

end