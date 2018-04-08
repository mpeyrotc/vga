function res = Sh(d,sigma,varargin)
% Sh(d,sigma,alpha=1)
%
% Implements Deb's sharing function

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

if length(varargin)>=1
   alpha = varargin{1};
else
   alpha = 1;
end
res = (d<=0) + (d>0).*(d<sigma).*(1-(d/sigma).^alpha);

end