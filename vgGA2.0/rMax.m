function res = rMax(rMin,rMaxh,N,B)

% rMax(rMin,rMaxh,N,B)
%
% Returns the adjusted value of rMax so that defined in the range 
% [rMin, rMax(rMin,rMaxh,N,B)] will have a maximum value of rMaxh.
% It converts the range  rMin<=r<rMaxh into the range rMin<=r<=rMax.
%
% See also: rMaxh

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

res = (B.^N.*rMaxh - rMin)./(B.^N-1);

end