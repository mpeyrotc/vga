function res = ghigh(p,n)
% Gfuns/ghigh(p,n)
%
% High part of integer p above value n.
%
% Example:
% >> dec2base( ghigh(base2dec('45123',6),6.^[1 2 3 4 5]), 6)
% 
% ans =
% 45120
% 45100
% 45000
% 40000
% 00000
%
% See also: glow, ghighh

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

res = p - mod(p,n);

end
