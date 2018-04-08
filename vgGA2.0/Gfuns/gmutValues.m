function res = gmutValues(p,n,delta)
% Gfuns/gmutValues(p,n,delta)
%
% Returns a vector of all the possible results of the
% mutation of p starting at value n and with width delta.
%
% Example:
%
% dec2base(gmutValues(base2dec('333333',4),4^3,4^2),4) 
%
% ans =
% 300333
% 301333
% 302333
% 303333
% 310333
% 311333
% 312333
% 313333
% 320333
% 321333
% 322333
% 323333
% 330333
% 331333
% 332333
% 333333
%
% See also: gMutate

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

ran = 0:1:delta-1;
res = ones(size(ran))*(glow(p,n)+ghigh(p,n*delta)) + n*ran;

end