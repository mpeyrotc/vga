function display(pop)
% @population/display
%
% display(pop)
%
% Displays a population.
%
% See also: setDisplay

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

TITLE     = pop.params.dTitle;   % Display title?
INDIV     = pop.params.dIndiv;   % Display individuals?
CHROMS    = pop.params.dChroms;  % Display chromosomes?
PHENOS    = pop.params.dPhenos;  % Display phenotypes?
MUT_CLOCK = pop.params.dMut;     % Display mutation clock?
TRACE     = pop.params.dTrace;   % Display tracing info?
STATS     = pop.params.dStats;   % Display generation statistics?
BEST      = pop.params.dBest;    % Display best?
PARAMS    = pop.params.dParams;  % Display parameters?

% Format used to print integer phenotypes
FMT_PHENOI = sprintf(' %%%dd',ceil(logB(pop.params.B.^pop.params.N,10)));

if TITLE
   fprintf('\n%s is a vgGA population', inputname(1));
   if pop.params.max
      fprintf(' for maximization:\n')
   else
      fprintf(' for minimization:\n')
   end
end

% Parameters
if PARAMS
   fprintf('\n parameters:\n')
   fprintf('     type: %s\n', pop.params.type)
   fprintf('        N: ')
   fprintf('%g ',pop.params.N)
   fprintf('\n')
   if isequal(pop.params.type,'real')
      fprintf('     rMin: ')
      fprintf('%g ',pop.params.rMin)
      fprintf('\n')
      fprintf('     rMax: ')
      fprintf('%g ',pop.params.rMax)
      fprintf('\n')
   end
   fprintf('       ms:')
   fprintf(' %g', pop.params.ms)
   fprintf('       pm:')
   fprintf(' %g', pop.params.pm)
   fprintf('\n')
   fprintf('       pc: %g\n', pop.params.pc)
   fprintf('        m: %g\n', pop.params.m)
   fprintf('        B:')
   fprintf(' %g', pop.params.B)
   fprintf('\n')
   fprintf('    delta:')
   fprintf(' %g', pop.params.delta)
   fprintf('\n')
   fprintf(' dig/dist: %s/%s\n', pop.params.digits,pop.params.dist)
   fprintf('   DeltaR:')
   fprintf(' %g',pop.params.DeltaR)
   fprintf('\n')
end

% Mutation clock
if MUT_CLOCK==1
   fprintf('\n mutation clock:\n')
   fprintf('     mMax:')
   fprintf(' %10d',pop.mutclock.mMax)
   fprintf('\n')
   fprintf('        m:')
   fprintf(' %10.4g',pop.mutclock.m)
   fprintf('\n')
   fprintf('        n:')
   fprintf(' %10.4g',pop.mutclock.n)
   fprintf('\n')
   fprintf('        k:')
   if isequal(pop.params.type,'integer')
      fprintf(' %10d',pop.mutclock.k)
   else
      fprintf(' %10.4g',pop.mutclock.k)
   end
   fprintf('\n')
   fprintf('   DeltaI:')
   fprintf(' %10d',pop.mutclock.DeltaI)
   fprintf('\n')
end

% Trace information
if TRACE==1
   fprintf('\n trace information:\n')
   fprintf('   crossovers: %d  ISCs: %d  mutations: %d\n',...
      pop.trace.nCross, pop.trace.nISC, pop.trace.nMuts)
end

% Individuals
if INDIV
   if length(pop.individual)>=1
      fprintf('\n')
      fprintf(' individual:\n')
      for i=1:length(pop.individual)
         fprintf('  %4d: ',i)
         if isequal(pop.params.type,'real')
            if (CHROMS==1) && sum(pop.params.N==Inf)==0 && isequal(pop.params.digits,'continuous')==0
               % Chromosomes can only be displayed if N<Inf
               for j=1:pop.params.m
                  fprintf('%s ',...
                     dec2base(...
                     round((pop.individual(i).r(j)-pop.params.rMin(j))/...
                     pop.params.DeltaR(j)),...
                     pop.params.B(j),pop.params.N(j)))
               end
            end
            if PHENOS
               fprintf('%10.4g ', pop.individual(i).r)
            end
         elseif isequal(pop.params.type,'integer')
            if CHROMS==1
               for j=1:pop.params.m
                  fprintf('%s ',...
                     dec2base(pop.individual(i).r(j),...
                     pop.params.B(j), pop.params.N(j)))
               end
            end
            if PHENOS
               fprintf(FMT_PHENOI, pop.individual(i).r)
            end
         end
         fprintf(' -> ')
         fprintf(' %10.4g', pop.individual(i).fitness)
         fprintf('\n')
      end
   end
end

% Generation statistics
if STATS
   % Display average and std dev. of fitness
   n = length(pop.individual);
   if n>0
      k = length(pop.individual(1).fitness);
      fitness = reshape([pop.individual.fitness],k,n)';
      f = fitness(:,1);
      fMin = min(f);
      fMax = max(f);
      fMed = median(f);
      fSke = skewness(f);
      %[fMod,freq] = mode(f); % mode and freq. of the mode
      average = mean(f);
      stddev = std(f);
      fprintf('\n  average:%10.4g median:%10.4g',average,fMed)
      fprintf(' std dev:%10.4g\n', stddev)
      fprintf('      min:%10.4g    max:%10.4g',fMin,fMax)
      fprintf('    skew:%10.4g\n', fSke)      
   end
end

% Best found-so-far
if BEST
   if pop.params.max
      str = 'max';
   else
      str = 'min';
   end
   fprintf('\n Best (%s) first found at evaluation %d, after %d evaluations:\n',...
      str, pop.best.evals, pop.evals);
   fprintf('  BEST: ');
   if isequal(pop.params.type,'real')
      if (CHROMS==1) && sum(pop.params.N==Inf)==0 && ~isequal(pop.params.digits,'continuous')
         % Chromosomes can only be displayed if N<Inf
         for j=1:pop.params.m
            fprintf('%s ',...
               dec2base(...
               round((pop.best.r(j)-pop.params.rMin(j))/pop.params.DeltaR(j)),...
               pop.params.B(j), pop.params.N(j)));
         end
      end
      if PHENOS
         fprintf('%8.4g ', pop.best.r);
      end
   elseif isequal(pop.params.type,'integer')
      if CHROMS==1
         for j=1:pop.params.m
            fprintf('%s ',...
               dec2base(pop.best.r(j),pop.params.B(j),pop.params.N(j)));
         end
      end
      if PHENOS
         fprintf(FMT_PHENOI, pop.best.r);
      end
   end
   fprintf(' -> ');
   fprintf(' %10.4g', pop.best.fitness);
   fprintf('\n');
end 

end


function res = skewness(x)
res = (sum((x-mean(x)).^3)./length(x)) ./ (var(x,1).^1.5);
end

function res = kurtosis(x) 
res = (sum((x-mean(x)).^4)./length(x)) ./ (var(x,1).^2);
end