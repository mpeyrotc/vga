function pop = nextMut(pop,i)
% @population/nextMut
%
% pop = nextMut(pop,i)
%
% Generates value to next mutation, over segment i.
%
% See also: startMut, mutation

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

global type digits dist

if pop.params.pm(i) <= eps
  % Do nothing if pm is almost zero to avoid division by zero
  return
end

% load work variables
type   = pop.params.type;
digits = pop.params.digits;
dist   = pop.params.dist;
N      = pop.params.N(i);
B      = pop.params.B(i);
delta  = pop.params.delta(i);
rMin   = pop.params.rMin(i);
rMax   = pop.params.rMax(i);
DeltaR = pop.params.DeltaR(i);
pm     = pop.params.pm(i);
m      = pop.mutclock.m(i);
n      = pop.mutclock.n(i);
k      = pop.mutclock.k(i);
mMax   = pop.mutclock.mMax(i);

if isequal(digits,'traditional') && isequal(dist,'exponential')
   % A1: Integer/real + exponential + traditional
   phi = log(1-rand)/log(1-pm);                 % geometrical approx.
   mPlus = m  + phi;
   DeltaI = floor(mPlus/(N-logB(delta,B)+1));
   m = floor(mod(mPlus,(N-logB(delta,B)+1)))+1; % digit where mutation will occur
   n = B^(m-1);                                 % integer value where mutation will occur
   k = n*DeltaR + rMin;                         % real value where mutation will occur
   
elseif isequal(digits,'generalized') && isequal(dist,'exponential')
   % A2: Integer/real + exponential + generalized
   %phi = (1/pm)*log(1/(1-rand));                % exponential approx.
   phi = -log(1-rand)/pm;                       % exponential approx.
   mPlus = m - 1 + phi;
   DeltaI = floor(mPlus/(N-logB(delta,B)+1));
   m = mod(mPlus,N-logB(delta,B)+1)+1;          % nearest digit where mutation occurs
   n = floor(B^(m-1));                          % integer value where mutation occurs
   k = n*DeltaR + rMin;                         % real value where mutation occurs
 
elseif isequal(digits,'traditional') && isequal(dist,'uniform')
   % A3: Integer/real + uniform + traditional
   %phi = (1/pm)*log(1/(1-rand));                % exponential approx.
   phi = -log(1-rand)/pm;                       % exponential approx.
   nPlus = n - 1 + phi;
   DeltaI = floor(nPlus/(B^N/delta-1));
   n = floor( mod(nPlus,B^N/delta-1)+1 );
   m = floor(logB(n,B))+1;                      % nearest digit where mutation occurs
   n = B^(m-1);  
   k = n*DeltaR+rMin;                           % real value where mutation occurs

elseif isequal(digits,'generalized') && isequal(dist,'uniform')
   % A4: Integer/real + uniform + generalized
   %phi = (1/pm)*log(1/(1-rand));                % exponential approx.
   phi = -log(1-rand)/pm;                       % exponential approx.
   nPlus = n - 1 + phi;
   DeltaI = floor(nPlus/(B^N/delta-1));
   n = floor( mod(nPlus,B^N/delta-1)+1 );
   m = floor(logB(n,B))+1;                      % nearest digit where mutation occurs
   k = n*DeltaR+rMin;                           % real value where mutation occurs
   
elseif isequal(digits,'continuous')  && isequal(type,'real')
   % A5: Real + uniform + N=infinity
   %phi = (1/pm)*log(1/(1-rand));                % exponential approx.
   phi = -log(1-rand)/pm;                       % exponential approx.
   kPlus = k - rMin + phi;
   DeltaI = floor(kPlus/(rMax-rMin));
   k = mod(kPlus,(rMax-rMin)) + rMin;
   
else
   error('Cannot generate nextMutation for the combination:\n digits=%s distribution=%s type=%s',...
      digits,dist,type)
   
end

pop.mutclock.m(i) = m;
pop.mutclock.n(i) = n;
pop.mutclock.DeltaI(i) = DeltaI;
pop.mutclock.k(i) = k;

%fprintf('Exiting nextMut. pop.mutclock.k(%d)=%f\n',i,pop.mutclock.k(i))

end
