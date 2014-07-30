disp(' ')
disp(' ')
disp(' ')
disp('------------- Running all solutions -------------')
clearvars
%% Configure
numTrains = 20
latestDep = 12
numStations = 4
%%

sc = RandomTrains(numTrains,latestDep,numStations);
rs = sc.getRS();
IdealSolution = rs.genIdealSolution();
rs.reset();
[initSolution, initConflicts, initLateness] = rs.getSolution();
initLateness
disp(' ')

disp('------------ Ant Colony Optimization -------------')

rs.reset();
ants1 = 3;
aco = ACO(ants1, 5, 0.5, 0.7, 1, 1);
t = cputime; [ACOIts1, BestACOSoln1, BestACOCost1] = aco.run(sc); ACOt1 = cputime - t;
ACOt1
ants1
BestACOCost1
ACOIts1

rs.reset();
ants2 = 5;
aco = ACO(ants2, 5, 0.5, 0.7, 1, 1);
t = cputime; [ACOIts2, BestACOSoln2, BestACOCost2] = aco.run(sc); ACOt2 = cputime - t;
ACOt2
ants2
BestACOCost2
ACOIts2

rs.reset();
ants3 = 7;
aco = ACO(ants3, 5, 0.5, 0.7, 1, 1);
t = cputime; [ACOIts3, BestACOSoln3, BestACOCost3] = aco.run(sc); ACOt3 = cputime - t;
ACOt3
ants3
BestACOCost3
ACOIts3

disp('--------------- Genetic Algorithm ----------------')

rs.reset();
GApopulation1 = 10;
t = cputime; [GAIts1, bestGADelay1, bestGACost1] = GA_Main(sc, GApopulation1, initLateness); GAt1 = cputime - t;
GAt1
GApopulation1
bestGACost1
GAIts1

rs.reset();
GApopulation2 = 30;
t = cputime; [GAIts2, bestGADelay2, bestGACost2] = GA_Main(sc, GApopulation2, initLateness); GAt2 = cputime - t;
GAt2
GApopulation2
bestGACost2
GAIts2

rs.reset();
GApopulation3 = 50;
t = cputime; [GAIts3, bestGADelay3, bestGACost3] = GA_Main(sc, GApopulation3, initLateness); GAt3 = cputime - t;
GAt3
GApopulation3
bestGACost3
GAIts3

disp('-------------- Simulated Annealing --------------')

rs.reset();
SAtemp1 = 0.5;
t = cputime; [SAIts1, bestSADelay1, bestSACost1] = SA(sc, SAtemp1); SAt1 = cputime - t;
SAt1
SAtemp1
bestSACost1
SAIts1

rs.reset();
SAtemp2 = 1;
t = cputime; [SAIts2, bestSADelay2, bestSACost2] = SA(sc, SAtemp2); SAt2 = cputime - t;
SAt2
SAtemp2
bestSACost2
SAIts2

rs.reset();
SAtemp3 = 1.5;
t = cputime; [SAIts3, bestSADelay3, bestSACost3] = SA(sc, SAtemp3); SAt3 = cputime - t;
SAt3
SAtemp3
bestSACost3
SAIts3

disp('---------- Particle Swarm Optimization ----------')

rs.reset();
PSOparticles1 = 5;
t = cputime; [PSOIts1, bestPSODelay1, bestPSOCost1] = PSO(PSOparticles1,15,sc); PSOt1 = cputime - t;
PSOt1
PSOparticles1
bestPSOCost1
PSOIts1

rs.reset();
PSOparticles2 = 10;
t = cputime; [PSOIts2, bestPSODelay2, bestPSOCost2] = PSO(PSOparticles2,15,sc);PSOt2 = cputime - t;
PSOt2
PSOparticles2
bestPSOCost2
PSOIts2

rs.reset();
PSOparticles3 = 20;
t = cputime; [PSOIts3, bestPSODelay3, bestPSOCost3] = PSO(PSOparticles3,15,sc);PSOt3 = cputime - t;
PSOt3
PSOparticles3
bestPSOCost3
PSOIts3

disp('------------------ Tabu Search ------------------')

rs.reset();
TSlength1 = 3;
% t = cputime; [TSIts1, BestTSSoln1, bestTSCost1] = TabuSearch(sc, TSlength1, 10);TSt1 = cputime - t;
TSt1 = 0;
TSlength1 = 0;
bestTSCost1 = 0;
TSIts1 = 0;

rs.reset();
TSlength2 = 5;
% t = cputime; [TSIts2, BestTSSoln2, bestTSCost2] = TabuSearch(sc, TSlength2, 10);TSt2 = cputime - t;
TSt2 = 0;
TSlength2 = 0;
bestTSCost2 = 0;
TSIts2 = 0;

rs.reset();
TSlength3 = 8;
% t = cputime; [TSIts3, BestTSSoln3, bestTSCost3] = TabuSearch(sc, TSlength3, 10);TSt3 = cputime - t;
TSt3 = 0;
TSlength3 = 0;
bestTSCost3 = 0;
TSIts3 = 0;

disp(' ')
disp('------------- Finished Running All --------------')

initLateness

disp('Genetic Algorithm')
GApopulation1
bestGACost1
GAt1
GApopulation2
bestGACost2
GAt2
GApopulation3
bestGACost3
GAt3

disp('Simulated Annealling')
SAtemp1
bestSACost1
SAt1
SAtemp2
bestSACost2
SAt2
SAtemp3
bestSACost3
SAt3

disp('Particle Swarm Opimization')
PSOparticles1
bestPSOCost1
PSOt1
PSOparticles2
bestPSOCost2
PSOt2
PSOparticles3
bestPSOCost3
PSOt3

disp('Tabu Search')
TSlength1
bestTSCost1
TSt1
TSlength2
bestTSCost2
TSt2
TSlength3
bestTSCost3
TSt3

disp('CSV Matrix')
m = [GApopulation1 GApopulation2 GApopulation3 SAtemp1 SAtemp2 SAtemp3 PSOparticles1 PSOparticles2 PSOparticles3 TSlength1 TSlength2 TSlength3 ants1 ants2 ants3; ...
    bestGACost1 bestGACost2 bestGACost3 bestSACost1 bestSACost2 bestSACost3 bestPSOCost1 bestPSOCost2 bestPSOCost3 bestTSCost1 bestTSCost2 bestTSCost3 BestACOCost1 BestACOCost2 BestACOCost3; ...
    GAt1 GAt2 GAt3 SAt1 SAt2 SAt3 PSOt1 PSOt2 PSOt3 TSt1 TSt2 TSt3 ACOt1 ACOt2 ACOt3]
csvwrite('tentrains.csv',m)
type tentrains.csv