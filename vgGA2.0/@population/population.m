function pop = population(type,varargin)
% @population/population (Class constructor)
%
% pop = population('i(nteger)',N,ms,pc,B,delta,dist,digits)
% pop = population('r(eal)',R,N,ms,pc,B,delta,dist,digits)
%
% Constructs a population of a given type ('integer' or 'real'). 
% Parameters:
%
% R:      mx2 matrix of min and max values of segments
% N:      mx1 vector of the number of digits per segment
%         for type 'real' [default = Inf]
% ms:     vector of mutations per segment [default = 0.0]
% pc:     crossover probability [default = 1.0]
% B:      base [default = 2]
% delta:  mutation delta [default = B]
% dist:   distribution of crossover and mutation points,
%         'e(xponential)' [default] or 'u(niform)'
% digits: 't(raditional)'[default], 'c(ontinuous)', or 'g(eneralized)'

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

MAXIMIZATION = 0; % Default of params.max
NO_FUNCTIONS = 1; % Initial value of params.noFunctions
pop.params.max = MAXIMIZATION;
pop.params.noFunctions = NO_FUNCTIONS;

% Defaults of display parameters
pop.params.dTitle  = 1;
pop.params.dIndiv  = 1;
pop.params.dBest   = 1;
pop.params.dMut    = 0;    % Display mutation clock?
pop.params.dTrace  = 0;    % Display tracing info?
pop.params.dStats  = 1;    % Display generation statistics?
pop.params.dChroms = 1;
pop.params.dPhenos = 1;
pop.params.dParams = 1; 

if isequal(type,'r') || isequal(type,'R')
   type = 'real';
elseif isequal(type,'i') || isequal(type,'I')
   type = 'integer';
end


if isequal(type,'real') || isequal(type,'integer') 
   pop.params.type = type;
else
   error('%s is not a valid type of population',type)
end

% Defaults
pop.params.ms = 0;
pop.params.pc = 1;
pop.params.B = 2;
pop.params.delta = pop.params.B;
pop.params.dist = 'exponential';
pop.params.digits = 'traditional';

if isequal(type,'real')
   R = varargin{1};
   m = size(R,1);
   pop.params.m = m(1);
   pop.params.rMin = R(:,1)';
   pop.params.rMax = R(:,2)';
   pop.params.N = ones(1,length(R))*Inf;
   if length(varargin)>=2
      pop.params.N = varargin{2};
   end
   if length(pop.params.N)~=pop.params.m
      pop.params.N = ones(1,pop.params.m)*pop.params.N(1);
   end
   pop.best.r = R(:,1)';
   varargin = varargin(2:end);
elseif isequal(type,'integer')
   N = varargin{1};
   m = length(N);
   pop.params.m = m;
   pop.params.N = N;
   pop.best.r = zeros(1,pop.params.m);
   pop.params.rMin = zeros(1,pop.params.m);
   pop.params.DeltaR = ones(1,pop.params.m);
end

if length(varargin)>=2
   pop.params.ms = varargin{2};
end
if length(varargin)>=3
   pop.params.pc = varargin{3};
end
if length(varargin)>=4
   pop.params.B = varargin{4};
   pop.params.delta = pop.params.B;
end
if isequal(type,'integer')
   pop.params.rMax = pop.params.B.^pop.params.N;
end
if isequal(type,'real')
   pop.params.DeltaR = (pop.params.rMax - pop.params.rMin)./pop.params.B.^pop.params.N;
else
   pop.params.DeltaR = ones(1,pop.params.m);
end
if length(varargin)>=5
   pop.params.delta = varargin{5};
end
if length(varargin)>=6
   dist = varargin{6};
   if isequal(dist,'e') || isequal(dist,'E')
      dist = 'exponential';
   elseif isequal(dist,'u') || isequal(dist,'U')
      dist = 'uniform';
   end
   pop.params.dist = dist;
end
if length(varargin)>=7
   digits = varargin{7};
   if isequal(digits,'t') || isequal(digits,'T')
      digits = 'traditional';
   elseif isequal(digits,'g') || isequal(digits,'G')
      digits = 'generalized';
   elseif isequal(digits,'c') || isequal(digits,'C')
      digits = 'continuous';
      pop.params.N = inf(1,m);
   end
   pop.params.digits = digits;
end

if isequal(pop.params.digits,'continuous') && ~isequal(pop.params.dist,'uniform')
   error('continuous digits can only be used with uniform distribution')
end
if sum(pop.params.N)==Inf && ~isequal(pop.params.digits,'continuous')
   fprintf('Infinite number of digits can only be used with continuous\n')
   fprintf('digits and uniform distribution.  Will be set as required.\n')
   pop.params.dist = 'uniform';
   pop.params.digits = 'continuous';
end
if isequal(pop.params.digits,'continuous') && ~isequal(pop.params.type,'real') 
   error('Continuous digits can only be used with reals')
end
if isequal(pop.params.digits,'continuous') && ~isequal(pop.params.dist,'uniform') 
   fprintf('Continuous digits can only be used with uniform distribution.\n')
   fprintf('Will be set as required.\n')
   pop.params.dist = 'uniform';
end


if length(pop.params.B)~=pop.params.m
   pop.params.B = ones(1,pop.params.m)*pop.params.B(1);
end
if length(pop.params.ms)~=pop.params.m
   pop.params.ms = ones(1,pop.params.m)*pop.params.ms(1);
end
if length(pop.params.delta)~=pop.params.m
   pop.params.delta = ones(1,pop.params.m)*pop.params.delta(1);
end
if sum(pop.params.B.^pop.params.N > 2^52) && sum(pop.params.N==Inf)==0
   warning('***** WARNING: POSSIBLE ROUNDING ERRORS *****')
   for i=1:m
      if pop.params.B(i)^pop.params.N(i) > 2^52
         fprintf('***** Segment %i:  %3d is too long for base %d;',i,pop.params.N(i),pop.params.B(i))
         fprintf(' max digits for this base is %d\n',floor(logB(2^52,pop.params.B(i))))
      end
   end   
   cont = input('***** Do you want to continue? (Y/N) ','s');
   if not(strcmp(cont,'Y')|strcmp(cont,'y'))
      clear pop
      return
   end
end

if isequal(pop.params.digits,'continuous') && isequal(pop.params.dist,'uniform')
   pop.params.pm = pop.params.ms./(pop.params.rMax-pop.params.rMin);
elseif isequal(pop.params.dist,'uniform')
   pop.params.pm = pop.params.ms./(pop.params.B.^pop.params.N./pop.params.delta-1);
   if sum(pop.params.ms>pop.params.N)>0
      error('ms cannot be greater than N for any segment')
   end
elseif isequal(pop.params.dist,'exponential')
   pop.params.pm = pop.params.ms./(pop.params.N-logB(pop.params.delta,pop.params.B));
   if sum(pop.params.ms>pop.params.N)>0
      error('ms=%d cannot be greater than N=%d',pop.params.ms,pop.params.N)
   end
else
   error('Do not know how to set pm for digits=%s/dist=%s',...
      pop.params.digits,pop.params.dist)
end


% Start best found
if pop.params.max == 1
   pop.best.fitness = -Inf(1,pop.params.noFunctions);
else
   pop.best.fitness = Inf(1,pop.params.noFunctions);
end
pop.best.evals = 0;
pop.evals = 0;

% Start empty population
pop.individual = [];

% Start empty mutation clock
pop.mutclock = [];

% Start empty tracing structure
pop.trace.nMuts = 0;
pop.trace.nCross = 0;
pop.trace.nISC = 0;

pop = class(pop, 'population');

% Start mutation clock
pop = startMut(pop);
if pop.params.ms > 0
   for i=1:pop.params.m
      pop = nextMut(pop,i);
   end
end

end

