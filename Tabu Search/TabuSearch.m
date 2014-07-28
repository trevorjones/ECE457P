clearvars

% Vars
TabuLength = 10;
NumIterations = 100;
sc = SimplifiedScenario();
rs = sc.getRS();
TabuList = TabuList();

% Generate ideal solution for each train which is to be used for the optimization function
IdealSolution = rs.genIdealSolution();

% Generate the initial solution given the problem data
rs.reset();
[InitialSolution, conflicts, lateness] = rs.getSolution();

% Set the best solution to the initial solution
BestSoln = InitialSolution;
soln = BestSoln;
BestSolnCost = lateness;
BestSolnConflicts = conflicts;

for nIt = 1 : NumIterations
    [soln, conflicts, lateness, TabuList] = GetBestNeighbour(rs, soln, lateness, conflicts, TabuLength, TabuList);
            
    % Update the best solution
    if lateness < BestSolnCost
        BestSoln = soln;
        BestSolnCost = lateness;
        BestSolnConflicts = conflicts;
    end
end
