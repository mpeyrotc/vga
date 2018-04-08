function value = onemax(x,varargin)
% onemax(x,B=2)
%
% Implements the function onemax(x(1),B) + onemax(x(2),B) + ...
%
% See also: basemax

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
  value = value + onemaxScalar(x(i),B);
end

end


function res = onemaxScalar(x,B)
y = dec2base(x,B);
res = sum(y == '1');
end

