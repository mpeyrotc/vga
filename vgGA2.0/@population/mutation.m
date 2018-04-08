function [pop,G] = mutation(pop,varargin)
% @population/mutation
%
% pop = mutation(pop,last=0)
%
% Applies mutation to all the members of a population. The flag last
% is used to implement a steady state algorithm; mutation is applied to the
% last individual in the population.

%************************************************************
%*                                                          *
%*   vgGA2.0: The Virtual Gene Genetic Algorithm            *
%*                                                          *
%*   Copyright (c) All Rights Reserved 2003-2016            *
%*   Manuel Valenzuela-Rendón                               *
%*   manuel.valenzuela.r@gmail.com                          *
%*   http://sites.google.com/site/manuelvalenzuelar/        *
%*                                                          *
%************************************************************

if pop.params.pm <= eps
   return
end

if length(varargin)>=1
   last = varargin{1};
else
   last = 0;
end

if last
   start = length(pop.individual);
else
   start = 1;
end

fLen = length(pop.individual(1).fitness);
G = [];

for i=start:length(pop.individual)
   r = pop.individual(i).r;
   for j=1:pop.params.m
      % Mutate parameter j of individual i
      while pop.mutclock.DeltaI(j) == 0
         pop.trace.nMuts = pop.trace.nMuts + 1;
         
         if isequal(pop.params.digits,'traditional')
            % apply traditional mutation (without gamma correction)
            % mutate(r,k,delta,rMin)
            if isequal(pop.params.type,'integer')
               pop.individual(i).r(j) = ...
                  mutate( pop.individual(i).r(j),...  % r
                  pop.mutclock.n(j),...               % k <== n
                  pop.params.delta(j),...             % delta
                  0 );                                % rMin <== 0
            elseif isequal(pop.params.type,'real')
               pop.individual(i).r(j) = ...
                  mutate( pop.individual(i).r(j),...  % r
                  pop.mutclock.k(j),...               % k
                  pop.params.delta(j),...             % delta
                  pop.params.rMin(j) );               % rMin
            end
         elseif isequal(pop.params.digits,'generalized')
            %*** fprintf('Mutation generalized digits\n')
            % apply mutation with gamma correction
            if isequal(pop.params.type,'integer')    
               %*** fprintf('Mutating integer with generalized digits\n')
               % mutateGamma(r,k,N,B,delta,rMax=B^N,rMin=0)
               pop.individual(i).r(j) = ...                           
                  mutateGamma( pop.individual(i).r(j),...  % r
                               pop.mutclock.n(j),...       % k <== n
                               pop.params.N(j),...         % N
                               pop.params.B(j),...         % B
                               pop.params.delta(j) );      % delta
            elseif isequal(pop.params.type,'real') && ~isinf(pop.params.N(j))
               % mutateGamma(r,k,N,B,delta,rMax=B^N,rMin=0)
               pop.individual(i).r(j) = ...
                  mutateGamma( pop.individual(i).r(j),...  % r
                               pop.mutclock.k(j),...       % k
                               pop.params.N(j),...         % N
                               pop.params.B(j),...         % B
                               pop.params.delta(j),...     % delta
                               pop.params.rMax(j),...      % rMax
                               pop.params.rMin(j) );       % rMin
            end
         elseif isequal(pop.params.digits,'continuous') && ...
               isequal(pop.params.type,'real') && isinf(pop.params.N(j))
               % mutateGamma(r,k,Inf,delta,rMax,rMin)
               pop.individual(i).r(j) = ...
                  mutateGamma( pop.individual(i).r(j),...  % r
                               pop.mutclock.k(j),...       % k
                               pop.params.N(j),...         % Inf
                               pop.params.delta(j),...     % delta
                               pop.params.rMax(j),...      % rMax
                               pop.params.rMin(j) );       % rMin
         else
            % you shouldn't be here
            error('digits=%s dist=%s type=%s is not a valid combination',...
               pop.params.digits,pop.params.dist,pop.params.type)
         end
         pop = nextMut(pop,j);
         % pop.individual(i).fitness = ones(1,fLen)*NaN;
      end
      pop.mutclock.DeltaI(j) = pop.mutclock.DeltaI(j) - 1;
   end
   % set fitness to NaN, if individual is changed
   if ~isequal(r,pop.individual(i).r)
      pop.individual(i).fitness = ones(1,fLen)*NaN;
   end
end



 
