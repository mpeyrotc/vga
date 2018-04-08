function res = idigit(p,m,varargin)
% Ifuns/idigit(p,m,B=2) 
% 
% Digit m of base B of integer p. Digits are numbered
% from least significant to most significant starting
% at 1.
%
% Example:
% >> dec2base( idigit(base2dec('45123',6),[1 2 3 4 5],6), 6)
% ans = 
% 3
% 2
% 1
% 5
% 4
%
% See also: ihighh, isegment


%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved 2003-2016            *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************
  
if length(varargin)>=1
   B = varargin{1};
else
   B = 2;
end

res = ilow(ihighh(p, m-1, B), 1, B);

end