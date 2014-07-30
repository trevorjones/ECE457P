*****************************************
******** Train Scheduling Problem *******
*****************************************
Setup:
To gain all of the necessary includes to execute our code, please run the startup.m file in Matlab.

We have a Matlab script which runs all 5 of our algorithms with varying parameters:
runAll.m

You can see how to execute each algorithm from the runAll.m script and there is the code required to execute each below.

************************************************************
** Include the following before any of the algorithm code **
************************************************************
numTrains = 10
latestDep = 7
numStations = 3

sc = RandomTrains(numTrains,latestDep,numStations);
rs = sc.getRS();
IdealSolution = rs.genIdealSolution();
rs.reset();
[initSolution, initConflicts, initLateness] = rs.getSolution();

***********************
** Genetic Algorithm **
***********************
rs.reset();
GApopulation1 = 10;
[GAIts1, bestGADelay1, bestGACost1] = GA_Main(sc, GApopulation1, initLateness);

*************************
** Simulated Annealing **
*************************
rs.reset();
SAtemp1 = 0.5;
[SAIts1, bestSADelay1, bestSACost1] = SA(sc, SAtemp1);

*********************************
** Particle Swarm Optimization **
*********************************
rs.reset();
PSOparticles1 = 5;
[PSOIts1, bestPSODelay1, bestPSOCost1] = PSO(PSOparticles1,15,sc);

*****************
** Tabu Search **
*****************
rs.reset();
TSlength1 = 3;
[TSIts1, BestTSSoln1, bestTSCost1] = TabuSearch(sc, TSlength1, 10);

*****************************
** Ant Colony Optimization **
*****************************
rs.reset();
aco = ACO(5, 5, 0.5, 0.7, 1, 1); % Parameters as follow: number of ants, number of iterations, evaporation coefficient, alpha value, beta value
[numIts, BestSoln BestSolnCost] = aco.run(sc);
