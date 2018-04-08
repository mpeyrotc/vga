addpath('vgGA2.0/');
addpath('vgGA2.0/Functions');
addpath('vgGA2.0/Gfuns');
addpath('vgGA2.0/Ifuns');
%% Inicialización de constantes y variables
% Decidimos usar la representación del profesor y crear nuestra población
% como individuos de un solo segmento donde el índice de cada elemento 
% ientifica al nodo y su valor representa el nodo al que se conecta.

% Encabezado
str = 'CASO 1';

% hijo del nodo i-1
% nodo: 0 1 2 3 4 5 6
%hijo = [0 5 4 6 1 5 6];
hijo = [0 2 1 2 5 1 4];

% Producción del nodo i-1
% nodo: 0  1 2 3 4 5 6
prod = [0 10 5 3 4 9 8];

% Coordenadas del nodo i-1
% nodo:  0    1    2    3    4     5     6
C   =  [0 0; 3 2; 6 2; 6 0; 3 -2; 6 -2; 9 -2];

N = length(hijo);

p = population('integer', N, 0.6, 0.9, 8);

eval = @(x) 2 + x;

obj_function(C, prod, eval);

%% Creación de población inicial
p = random(p,10)

%% Run GA Algorithm
% It runs the previous population for 50 generations with the evaluation
% function especified as argument 3.

methods = {@tournament,@crossover,@mutation};
[p,B] = runGA(p,methods,@obj_function,50);
plot(B(:,1),B(:,2))
%obj_function(hijo)

%% test
