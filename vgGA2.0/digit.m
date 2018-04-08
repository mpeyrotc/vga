function res = digit(p,n,B)
% digit(p,n,B)
%
% Digit of weight n/B, base B, of number p. Works only
% for integers.
%
% Examples:
%
%    digit(7,[2 4 8 16],2) =
% 
%        1  1  1  0
%
%    digit(2*3^0+1*3^1+2*3^3,3.^[1 2 3 4],3) =
% 
%        2  1  2  0
%
% See also: segment

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

res = low(highh(p,n./B),B);

end