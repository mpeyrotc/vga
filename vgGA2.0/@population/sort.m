function pop = sort(pop,varargin)
% @population/sort
%
% pop = sort(pop,type='fitness',order='ascend')
%
% Sorts the population by phenotype or by fitness.
%  type: 'p(henotype)'[default], 'f(itness)'
% order: 'a(scend)'[default] worst to best, 
%        'd(escend)' best to worst

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

if length(varargin)>=1
   type = varargin{1};
else
   type = 'f';
end

if length(varargin)>=2
    order = varargin{2};
else
    order = 'a';
end

if isequal(type,'phenotypic') || isequal(type,'phenotype') || ...
      isequal(type,'pheno') || isequal(type,'p') || ...
      isequal(type,'P') || isempty(type)
   type = 'p';
elseif isequal(type,'fitness') || isequal(type,'fit') || ...
      isequal(type,'f') || isequal(type,'F')
   type = 'f';
else
   error(['Sort population by ''',type,''' not implemented'])
end

if isequal(order,'ascend') || isequal(order,'a')
    order = 'a';
elseif isequal(order,'descend') || isequal(order,'d')
    order = 'd';
else
    error(['Sort population in ',order,' ''order'' not implemented'])
end

n = length(pop.individual);
if isequal(type,'f')
   k = length(pop.individual(1).fitness);
   fitness = reshape([pop.individual.fitness],k,n)';
   [~,I] = sortrows(fitness);

elseif isequal(type,'p')
   r = reshape([pop.individual.r],pop.params.m,n)';
   [~,I] = sortrows(r);
end

if pop.params.max==1 && isequal(order,'d') || ...
        pop.params.max==0 && isequal(order,'a')
    I = I(n:-1:1);
end

pop.individual = pop.individual(I);

end
