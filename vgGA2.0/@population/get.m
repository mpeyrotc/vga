function value = get(pop,fieldname,varargin)
% @population/get
%
% get(pop,fieldname)
%
% Returns the value of a given field. Currently implemented fields:
%     'type', 'N', 'pc', 'pm', 'max', 'delta', 'dist', 'digits',
%     'B', 'individual', 'best', 'evals', 'r', 'fitness', 'rMax'
%
% See also: set

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

switch(fieldname)
   case 'type'
      value = pop.params.type;
   case 'n'
      value = length(pop.individual);
   case 'N'
      value = pop.params.N;
   case 'pc'
      value = pop.params.pc;
   case 'pm'
      value = pop.params.pm;
   case 'max'
      value = pop.params.max;
   case 'delta'
      value = pop.params.delta;
   case 'dist'
      value = pop.params.dist;
   case 'digits'
      value = pop.params.digits;
   case 'B'
      value = pop.params.B;
   case 'individual'
      value = pop.individual(varargin{1});
   case 'best'
      value = pop.best;
   case 'evals'
      value = pop.evals;
   case 'r'
      value = [pop.individual.r];
      value = reshape(value,pop.params.m,length(pop.individual));
   case 'rr'
      value = [];
      for i=1:length(pop.individual)
         value = [value; pop.individual(i).r pop.individual(i).fitness];
      end
      sort(value);
   case 'fitness'
      value = [];
      for i=1:length(pop.individual)
         value = [value; pop.individual(i).fitness];
      end
   case 'rMax'
      value = pop.params.rMax;     

   otherwise
      error(strcat(fieldname,' is not a valid field name for a population'))
end
