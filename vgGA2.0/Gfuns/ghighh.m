function res = ghighh(p,n)
% Gfuns/ghighh(p,n)
%
% Value of the high part of integer p above value n.
%
% Example:
% >> dec2base( ihighh(base2dec('45123',6),6.^[1 2 3 4 5]), 6)
%
% ans = 
% 4512
% 0451
% 0045
% 0004
% 0000
%
%   See also: ghigh, gdigit

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

res = ghigh(p,n)./n;

end