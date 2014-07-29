disp(' ')
disp(' ')
disp(' ')
disp('------------- Running all solutions -------------')
%% Configure
numTrains = 10
latestDep = 7
numStations = 3
%%

sc = RandomTrains(numTrains,latestDep,numStations);
rs = sc.getRS();
IdealSolution = rs.genIdealSolution();
rs.reset();
[initSolution, initConflicts, initLateness] = rs.getSolution();
initLateness
disp(' ')

disp('-------------- Simulated Annealing --------------')
rs.reset();
[bestSADelay, bestSACost] = SA(sc);
bestSACost

disp('---------- Particle Swarm Optimization ----------')
rs.reset();
% [bestPSODelay, bestPSOCost] = PSO(10,5,sc);
% bestPOSCost

disp('------------------ Tabu Search ------------------')
rs.reset();

disp('--------------- Genetic Algorithm ----------------')
rs.reset();

disp('------------ Ant Colony Optimization -------------')
rs.reset();

disp('------------- Finished Running All --------------')