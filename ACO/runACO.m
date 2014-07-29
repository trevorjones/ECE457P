clear
sc = Scenario();
aco = ACO(5, 5, 0.5, 0.7, 1, 1);
[numIts, BestSoln BestSolnCost] = aco.run(sc);
numIts
BestSoln
BestSolnCost