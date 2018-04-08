function pop = startMut(pop)

% population/startMut
%
% pop = startMut(pop)
%
% Starts or restarts the mutation clock.

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

% global type digits dist

rMin = pop.params.rMin;
N = pop.params.N;


pop.mutclock.DeltaI = zeros(1,pop.params.m);     % individuals to next mutation 
pop.mutclock.mMax = N;                           % max digit for mutation

% Set digit and value of first mutation
pop.mutclock.m = ones(1,pop.params.m);     
if isequal(pop.params.type,'integer')
   pop.mutclock.k = zeros(1,pop.params.m);
else
   pop.mutclock.k = rMin;
end
