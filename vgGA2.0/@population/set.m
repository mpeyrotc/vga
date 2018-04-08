function pop = set(pop,fieldname,value,varargin)
% @population/set
%
% pop = set(pop,fieldname,value)
%
% Sets the value of a given field. Currently implemented fields:
%     'type', 'N', 'pc', 'pm', 'delta', 'digits', 'B', 
%     'r' (give individual index), 'max', 'best'
%
% See also: get
     
%************************************************************
%*                                                          *
%*   vgGA2.0: The Virtual Gene Genetic Algorithm            *
%*                                                          *
%*   Copyright (c) All Rights Reserved 2003-2017            *
%*   Manuel Valenzuela-Rend�n                               *
%*   manuel.valenzuela.r@gmail.com                          *
%*   http://sites.google.com/site/manuelvalenzuelar/        *
%*                                                          *
%************************************************************

switch(fieldname)
   case 'type'
      pop.params.type = value;
   case 'N'
      pop.params.N = value;
   case 'pc'
      pop.params.pc = value;
   case 'pm'
      pop.params.pm = value;
   case 'delta'
      pop.params.delta = value;
   case 'dist'
      pop.params.dist = value;
   case 'digits'
      pop.params.digits = value;
   case 'B'
      pop.params.B = value;
   case 'r'
      pop.individual(varargin{1}).r = value;
   case 'max'
      pop.params.max = value;
   case 'dChroms'
      pop.params.dChroms = value;
   case 'dPhenos'
      pop.params.dPhenos = value;
   case 'fitness'
       for i=1:length(value)
          pop.individual(i).fitness = value(i);
       end
   case 'best'
      pop.best = value;
   otherwise
  error('%s is not a valid field name to set',fieldname)
end

end

