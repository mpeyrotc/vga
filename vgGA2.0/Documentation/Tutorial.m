%% vgGA tutorial
%
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
%
% *vgGA* is object oriented programmed. The vgGA is based on the 
% |population| class defined in the |@population/| directory. In 
% Octave/MATLAB all the methods of a class must be placed in a directory
% that starts with a @ character, and that has the same name as the class.
%
% The class constructor must be a function with the same name, and must 
% return an class instance build with |class| function. The way in which an
% instance of a class is displayed is determined by a |display| method that
% the user must define.
%
% Octave/MATLAB allow access only to the fields of an object inside its
% methods. It is usual to write specific methods to read and modify fields
% of an object. I have created the |get| and |set| methods for this
% purpose; nevertheless, thet are not very general, and are limited to the
% specific fields that I have needed to access.
%
% In Octave/MATLAB, unless declared global, all variables are local to the
% functions in which they are used. The methods of a class are simply
% functions that must receive an object, and must return the modified
% object for its assignment outside of the method.
%

rng('default') % just to produce the same result always

%% Empty population 
% We use the class constructor to create an object |p| of the class 
% |population|. For example, to create an integer population where
% individuals have two segments (a 6-bit binary segment, and a 3-digit base
% 5 segment) expected mutations per segement of 0.6 and 0.4, and crossover
% probability of 0.9, we execute the following instruction:

p = population('integer',[6 3],[0.6 0.4],0.9,[2 5])

%% Random individuals
% We can create 10 random individuals applying the |random| method.
%
% The genotype, phenotype, and fitness of each individual is displayed.
% Individuals have a fitness of |NaN| (_Not a Number_) because they have 
% not yet been evaluated.

p = random(p,10)

%% Evaluation
% A population is evaluated with the |evaluate| method that is called with 
% an objective function as a parameter. The |display| method lists general 
% population statistics and other information; it also gives the number of 
% function evaluations, the best found so far, and when the best was found.
% In this example, the population is evaluated using function |x2y2|; this
% function can be found at the root directory |vgGA/|, and returns the sum
% of the squares of each segment. Methods |evaluate| takes a function that
% receives a vector |r| of the phenotype of each individual, and returns
% its evaluation.

p = evaluate(p,@x2y2)

%% Selection
% Roulette wheel selection is performed by the |roulette| method. Other
% available selection methods are |tournament|, |sus| (stochastic
% universal sampling), and |linRanking| (linear ranking).
%
% Notice that most individual will have a fitness of |NaN| beacause they
% haye not been evaluated yet.

p = roulette(p)

%% Crossover and mutation
% We now perform |crossover| y |mutation|.

p = crossover(p)
p = mutation(p)

%% Genetic algorithm
% Using the |population|, |random|, |evaluate|, |roulette| (or
% |tournament|, |sus|, etc.), |crossover| and |mutation| is is posible to
% create a genetic algorithm that runs for a number of generations and that
% retuns the _best-found-so-far_ vs. function evaluations for each
% generation. Method |runGA| does this. The following commands runs a
% population |p| for 50 generations and a plot of the best-found-so-far is
% done. 

methods = {@tournament,@crossover,@mutation};
[p,B] = runGA(p,methods,@x2y2,50);
plot(B(:,1),B(:,2))

%% Best found plot
% Function |plotGA| produces a plot of the average of the best found,
% plus/minus a standard deviation, for a given number of runs. This
% function repeatedly calls method |runGA|. The following command runs 20
% times a population of 10 individuals for 50 generations for the example
% of this tutorial.

plotGA(20,10,@x2y2,methods,50,'shuffle','integer',[6 3],[0.6 0.4],0.9,[2 5]);





