function pop = nextMutNew(pop,i)

% population/nextMut <=== ***************
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


if isequal(dist,'exponential') && isequal(digits,'traditional')
   % Integer/real + exponential + traditional
   %pm = mmpi/(N-logB(delta,B));
   phi = log(1-rand)/log(1-pm);  % geometrical approx.
   mPlus = m  + phi;
   DeltaI = floor(mPlus/(N-logB(delta,B)+1));
   m = floor(mod(mPlus,(N-logB(delta,B)+1)))+1; % digit where mutation will occur
   n = B^(m-1);                                 % integer value where mutation will occur
   k = n*DeltaR + rMin;                        % real value where mutation will occur
   
elseif isequal(dist,'exponential') && isequal(digits,'generalized')
   % Integer/real + exponential + generalized
   phi = (1/pm)*log(1/(1-rand)); % exponential approx.
   mPlus = m + phi;
   DeltaI = floor(mPlus/(N-logB(delta,B)+1));
   m = mod(mPlus,N-logB(delta,B)+1)+1;         % nearest digit where mutation occurs
   n = floor(B^(m-1));                         % integer value where mutation occurs
   k = n*DeltaR + rMin;                       % real value where mutation occurs

elseif isequal('type','real') && isequal(dist,'continuous') 
   % Real + uniform + N=infinity
   phi = (1/pm)*log(1/(1-rand)); % exponential approx.
   kPlus = k - rMin + phi;
   DeltaI = floor(kPlus/(rMax-rMin));
   k = mod(kPlus,(rMax-rMin)) + rMin;

elseif isequal(dist,'uniform') 
   % Integer/real + uniform + generalized/traditional
   phi = (1/pm)*log(1/(1-rand)); % exponential approx.
   nPlus = n-1+ phi;
   DeltaI = floor(nPlus/(B^N/delta-1));
   n = mod(nPlus,B^N/delta-1)+1;
   nUso = floor(n);
   m = floor(logB(nUso,B))+1;         % nearest digit where mutation occurs
   k = nUso*DeltaR+rMin;             % real value where mutation occurs

end


% Save data
% if m>=B^N
%    fprintf('m=%d B^N=%d\n',m,B^N)
%    error('En nextMutNew')
% end
pop.mutclock.m(i) = m;
pop.mutclock.n(i) = n;
pop.mutclock.DeltaI(i) = DeltaI;
pop.mutclock.k(i) = k;

end
