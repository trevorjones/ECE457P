function  [numIts, BestSoln BestSolnCost] = TabuSearch(sc, TabuLength, NumIterations)

% disp('------------------------ Set Up ------------------------')
% clearvars

% Vars
% TabuLength = 100;
% NumIterations = 100;
% sc = Scenario();
rs = sc.getRS();
TL = TabuList();

% Generate ideal solution for each train which is to be used for the optimization function
IdealSolution = rs.genIdealSolution();

% Generate the initial solution given the problem data
rs.reset();
[InitialSolution, conflicts, lateness] = rs.getSolution();
InitialSolution;
conflicts;
lateness;

% Set the best solution to the initial solution
BestSoln = InitialSolution;
soln = BestSoln;
BestSolnCost = lateness;
BestSolnConflicts = conflicts;

numIts = 0;
% disp('------------------------ Starting Tabu Search ------------------------')
for nIt = 1 : NumIterations
    [soln, conflicts, lateness, TL, itrs] = GetBestNeighbour(rs, soln, conflicts, TabuLength, TL);
    numIts = numIts + itrs;  
    % Update the best solution
    if lateness < BestSolnCost
        BestSoln = soln;
        BestSolnCost = lateness;
        BestSolnConflicts = conflicts;
    end
end

BestSoln;
BestSolnConflicts;
BestSolnCost;
