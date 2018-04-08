% Data structures in a population
% 
% evals        : number of function evaluations so far
%
% params
%           max: 0, 1 maximization flag
%          type: 'integer', 'real'
%             m: number of segments
%          N[m]: digits per segment
%       rMin[m]: min value of segments
%       rMax[m]: max value of segments
%     DeltaR[m]: (rMax-rMin)./B.^N
%         ms[m]: expected number of mutations per segment
%         pm[m]: mutation probability
%            pc: crossover mutation
%          B[m]: base of segments
%      delta[m]: mutation delta (width)
%          dist: 'exponential', 'uniform'  
%        digits: 'traditional', 'generalized', 'continuous'
%        dTitle: Display title?
%        dIndiv: Display individuals?
%        dTrace: Display tracing information?
%          dMut: Display mutation clock?
%        dStats: Display population statistics?
%         dBest: Display best individual found so far?
%       dChroms: Display chromosomes?
%       dPhenos: Display phenotypes?
%       dParams: Display population parameters?
%
% best
%          r[m]: phenotype
%       fitness: evaluation
%         evals: number of evaluation when found
%    
% individual[<population size>]
%          r[m]: phenotype
%       fitness: evaluation
%      
% mutclock    
%      nPlus[m]: value where next mutation will occur (integers)
%      kPlus[m]: value where next mutation will occur (reals)
%      mPlus[m]: digit where next mutation will occur
%     DeltaI[m]: individuals to next mutation
%       mMax[m]: maximum digit for mutation
%     
% trace
%         nMuts: number of mutations
%        nCross: number of crossovers
%          nISC: number of Inter-Segment Crossovers  

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
