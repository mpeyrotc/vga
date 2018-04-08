function res = deceptive(x,n)

% deceptive(x,n)
%
% Implements an n-bit completely deceptive function.

%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rend�n                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnol�gico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

unos = sum(dec2bin(x,n)=='1',2);
res = (unos<n).*(2*(n-1-unos)) + (unos>=n).*(2*n-1);
