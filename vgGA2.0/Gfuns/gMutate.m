function value = gMutate(p,n,delta)
% Gfuns/gMutate(p,n,delta)
%
% Returns the mutation of p with width delta from value m. 
%
% Example:
% dec2base(gMutate(base2dec('55555',6),6^2,6^2),6)
% mutates digits 3 and 4 in the number 55555 base 6.
%
% See also: gmutValues

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

value = glow(p,n) + ghigh(p,n*delta) + n*floor(delta*rand());

end