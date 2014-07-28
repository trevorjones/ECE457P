%% Simulation
%  Following the Figure 9.1 from http://www.eecs.harvard.edu/~parkes/pubs/ch9.pdf
clearvars
sc = Scenario();
rs = sc.getRS();

% Simulate
IdealSolution = rs.genIdealSolution()

rs.reset();
[InitialSolution, conflicts, lateness] = rs.getSolution();
InitialSolution
conflicts
lateness

rs.reset();
%% Swap
%  Done with delays. Ex: if train 1, 2, and 3 need to use the track between
%  nodes 3 and 4, and you want train 3 to go, then 2, then 1, you must send
%  the following array to delay train 1 by 2 at station 3, and 1 for train
%  2 to be delayed by 1 at station 4
delay = [0, 0, 1, 0;
         0, 0, 0, 0;
         0, 0, 0, 2];
[solution, conflicts, lateness] = rs.genSolutionWithDelay(delay);
solution
conflicts
lateness

clear JUNCTION LEFT RIGHT STATION junction1 junction2 junction3 junction4 station1 station2 station3 train1 train2 train3