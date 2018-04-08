function pop = nextMut(pop,i)

% population/nextMut
%
% pop = nextMut(pop,i)
%
% Generates value to next mutation, over segment i.

%************************************************************
%*                                                          *
%*   vgGA: The Virtual Gene Genetic Algorithm               *
%*                                                          *
%*   Copyright (c) All Rights Reserved                      *
%*   Manuel Valenzuela-Rendón                               *
%*   valenzuela@itesm.mx                                    *
%*   http://homepages.mty.itesm.mx/valenzuela               *
%*                                                          *
%*   Tecnológico de Monterrey, Campus Monterrey             *
%*   Monterrey, N.L., Mexico                                *
%*                                                          *
%************************************************************

global type digits dist

if pop.params.pm(i) <= eps
  % Do nothing if pm is almost zero to avoid division by zero
  return
end

% load work variables
type    = pop.params.type;
digits  = pop.params.digits;
dist    = pop.params.dist;
N       = pop.params.N(i);
B       = pop.params.B(i);
delta   = pop.params.delta(i);
rMin    = pop.params.rMin(i);
rMax    = pop.params.rMax(i);
DeltaRB = (rMax-rMin)/B^N;
pm      = pop.params.pm(i);
m       = pop.mutclock.m(i);
mMax    = pop.mutclock.mMax(i);

% Find raw m
if isequal(dist,'exponential')
   % phi = -(1/pm) * log(1-rand); % exponential mutation clock
   phi = log(1-rand)/log(1-pm); % geometric mutation clock
   m = m + logB(delta,B) + phi;
elseif isequal(dist,'uniform')
   pm = pm * N/B^N;
   % phi = -(1/pm) * log(1-rand); % exponential mutation clock
   phi = log(1-rand)/log(1-pm); % geometric mutation clock
   m = m + logB(delta*(phi+1));
else
   error([dist,' is not a valid distribution']);
end

% Find deltaI and advanced m
deltaI = floor((m+logB(delta,B)-1)/mMax);
m = m - deltaI*mMax;

% Round according to type of digits
if isequal(digits,'traditional')
   m = traditional(m);
elseif isequal(digits,'generalized')
   m = generalized(m,B);
elseif isequal(digits,'continuous')
    % There is nothing to do
    % m = m;
else
   error([digits,' is not a valid digits']);
end

% Find value where mutation is going to occur
if isequal(type,'integer')
   k = floor(B^m);
elseif isequal(type,'real')
   k = (B^m)*DeltaRB + rMin;
else
   error([type,' is not a valid type']);
end

% Save data
pop.mutclock.m(i) = m;
pop.mutclock.DeltaI(i) = deltaI;
pop.mutclock.k(i) = k;

end
