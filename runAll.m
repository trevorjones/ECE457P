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
[SAIts, bestSADelay, bestSACost] = SA(sc);
bestSACost
SAIts

disp('---------- Particle Swarm Optimization ----------')
rs.reset();
[PSOIts, bestPSODelay, bestPSOCost] = PSO(10,15,sc);
bestPSOCost
PSOIts

disp('------------------ Tabu Search ------------------')
rs.reset();
[TSIts, BestTSSoln, bestTSCost] = TabuSearch(sc, 5, 10);
bestTSCost
TSIts

disp('--------------- Genetic Algorithm ----------------')
rs.reset();

disp('------------ Ant Colony Optimization -------------')
rs.reset();

disp(' ')
disp('------------- Finished Running All --------------')