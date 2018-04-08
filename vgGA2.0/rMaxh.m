function res = rMaxh(rMin,rMax,N,B)
% rMaxh(rMin,rMax,N,B)
%
% This is the inverse of rMax.
%
% See also: rMax

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

res = rMax - (rMax-rMin)/B^N;

end



