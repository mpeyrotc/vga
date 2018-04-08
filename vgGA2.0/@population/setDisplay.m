function pop = setDisplay(pop,displayList)
% @population/setDisplay
%
% pop = setDisplay(pop,displayList)
%
% Sets display parameters:
%    title: display title
%    indiv; display individuals
%    trace: trace information
%   mclock: mutation clock
%    stats: statistics
%     best: display best individual found so far
%   chroms: display chromosomes
%   phenos: display phenotypes
%   params: display population parameters
% 
% For example pop=setDisplay(pop,{'best',1,'chroms',0,'params',0}) sets the
% population to display the best individual, and not display chromosomes
% and population parameters.
%
% See also: display

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
for i=1:2:length(displayList)
   if     isequal(displayList{i},'title')
      pop.params.dTitle = displayList{i+1};
   elseif isequal(displayList{i},'indiv')
      pop.params.dIndiv = displayList{i+1};
   elseif isequal(displayList{i},'trace')
      pop.params.dTrace = displayList{i+1};
   elseif isequal(displayList{i},'mclock')
      pop.params.dMut = displayList{i+1};
   elseif isequal(displayList{i},'stats')
      pop.params.dStats = displayList{i+1};
   elseif isequal(displayList{i},'best')
      pop.params.dBest = displayList{i+1};
   elseif isequal(displayList{i},'chroms')
      pop.params.dChroms = displayList{i+1};
   elseif isequal(displayList{i},'phenos')
      pop.params.dPhenos = displayList{i+1};
   elseif isequal(displayList{i},'params')
      pop.params.dParams = displayList{i+1};
   else
      error('%s is not a valid display parameter',displayList{i});
   end
end

end
