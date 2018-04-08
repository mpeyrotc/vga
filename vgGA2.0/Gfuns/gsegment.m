function res = gsegment(p,n,delta)
% Gfuns/gsegment(p,n,delta)
%
% Segment of width delta starting at value n.
% 
% Example:
% >> dec2base( gsegment(base2dec('45123',6),6,6^3), 6)
%
% ans =
% 512
%
% See also: ghighh, gdigit

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

res = glow(ghighh(p,n),delta);

end