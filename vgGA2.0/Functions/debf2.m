function res = debf2(x)
% Functions/debf2(x)
%
% Implements Deb's function F2
%
% See also: debf1
  
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

res = exp(-2*log(2)*((x-0.1)/0.8).^2) .* (sin(5*pi*x)).^6;

end