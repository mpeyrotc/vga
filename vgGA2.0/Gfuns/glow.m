function res = glow(p,n)
% Gfuns/glow(p,n)
%
% Low part of integer p up to value n.
%
% Example:
% >> dec2base( glow(base2dec('45123',6),6.^[1 2 3 4 5]), 6)
%
% ans =
% 00003
% 00023
% 00123
% 05123
% 45123
%
% See also: ghigh, ghighh

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

res = mod(p,n);

end

