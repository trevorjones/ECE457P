disp(' ')
disp(' ')
disp(' ')
disp('------------- Running all solutions -------------')
clearvars
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

disp('--------------- Genetic Algorithm ----------------')

rs.reset();
GApopulation1 = 10;
[GAIts1, bestGADelay1, bestGACost1] = GA_Main(sc, GApopulation1, initLateness);
GApopulation1
bestGACost1
GAIts1

rs.reset();
GApopulation2 = 30;
[GAIts2, bestGADelay2, bestGACost2] = GA_Main(sc, GApopulation2, initLateness);
GApopulation2
bestGACost2
GAIts2

rs.reset();
GApopulation3 = 50;
[GAIts3, bestGADelay3, bestGACost3] = GA_Main(sc, GApopulation3, initLateness);
GApopulation3
bestGACost3
GAIts3

disp('-------------- Simulated Annealing --------------')

rs.reset();
SAtemp1 = 0.5;
[SAIts1, bestSADelay1, bestSACost1] = SA(sc, SAtemp1);
SAtemp1
bestSACost1
SAIts1

rs.reset();
SAtemp2 = 1;
[SAIts2, bestSADelay2, bestSACost2] = SA(sc, SAtemp2);
SAtemp2
bestSACost2
SAIts2

rs.reset();
SAtemp3 = 1.5;
[SAIts3, bestSADelay3, bestSACost3] = SA(sc, SAtemp3);
SAtemp3
bestSACost3
SAIts3

disp('---------- Particle Swarm Optimization ----------')

rs.reset();
PSOparticles1 = 5;
[PSOIts1, bestPSODelay1, bestPSOCost1] = PSO(PSOparticles1,15,sc);
PSOparticles1
bestPSOCost1
PSOIts1

rs.reset();
PSOparticles2 = 10;
[PSOIts2, bestPSODelay2, bestPSOCost2] = PSO(PSOparticles2,15,sc);
PSOparticles2
bestPSOCost2
PSOIts2

rs.reset();
PSOparticles3 = 20;
[PSOIts3, bestPSODelay3, bestPSOCost3] = PSO(PSOparticles3,15,sc);
PSOparticles3
bestPSOCost3
PSOIts3

disp('------------------ Tabu Search ------------------')

rs.reset();
TSlength1 = 3;
[TSIts1, BestTSSoln1, bestTSCost1] = TabuSearch(sc, TSlength1, 10);
TSlength1
bestTSCost1
TSIts1

rs.reset();
TSlength2 = 5;
[TSIts2, BestTSSoln2, bestTSCost2] = TabuSearch(sc, TSlength2, 10);
TSlength2
bestTSCost2
TSIts2

rs.reset();
TSlength3 = 8;
[TSIts3, BestTSSoln3, bestTSCost3] = TabuSearch(sc, TSlength3, 10);
TSlength3
bestTSCost3
TSIts3

disp('------------ Ant Colony Optimization -------------')
rs.reset();

disp(' ')
disp('------------- Finished Running All --------------')

initLateness

disp('Genetic Algorithm')
GApopulation1
bestGACost1
GAIts1
GApopulation2
bestGACost2
GAIts2
GApopulation3
bestGACost3
GAIts3

disp('Simulated Annealling')
SAtemp1
bestSACost1
SAIts1
SAtemp2
bestSACost2
SAIts2
SAtemp3
bestSACost3
SAIts3

disp('Particle Swarm Opimization')
PSOparticles1
bestPSOCost1
PSOIts1
PSOparticles2
bestPSOCost2
PSOIts2
PSOparticles3
bestPSOCost3
PSOIts3

disp('Tabu Search')
TSlength1
bestTSCost1
TSIts1
TSlength2
bestTSCost2
TSIts2
TSlength3
bestTSCost3
TSIts3

disp('CSV Matrix')
m = [GApopulation1 GApopulation2 GApopulation3 SAtemp1 SAtemp2 SAtemp3 PSOparticles1 PSOparticles2 PSOparticles3 TSlength1 TSlength2 TSlength3; ...
    bestGACost1 bestGACost2 bestGACost3 bestSACost1 bestSACost2 bestSACost3 bestPSOCost1 bestPSOCost2 bestPSOCost3 bestTSCost1 bestTSCost2 bestTSCost3; ...
    GAIts1 GAIts2 GAIts3 SAIts1 SAIts2 SAIts3 PSOIts1 PSOIts2 PSOIts3 TSIts1 TSIts2 TSIts3]
csvwrite('tentrains.csv',m)
type tentrains.csv