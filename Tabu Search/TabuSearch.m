disp('------------------------ Set Up ------------------------')
clearvars

% Vars
TabuLength = 100;
NumIterations = 100;
sc = Scenario();
rs = sc.getRS();
TabuList = TabuList();

% Generate ideal solution for each train which is to be used for the optimization function
IdealSolution = rs.genIdealSolution()

% Generate the initial solution given the problem data
rs.reset();
[InitialSolution, conflicts, lateness] = rs.getSolution();
InitialSolution
conflicts
lateness

% Set the best solution to the initial solution
BestSoln = InitialSolution;
soln = BestSoln;
BestSolnCost = lateness;
BestSolnConflicts = conflicts;

disp('------------------------ Starting Tabu Search ------------------------')
for nIt = 1 : NumIterations
    [soln, conflicts, lateness, TabuList] = GetBestNeighbour(rs, soln, conflicts, TabuLength, TabuList);
            
    % Update the best solution
    if lateness < BestSolnCost
        BestSoln = soln;
        BestSolnCost = lateness;
        BestSolnConflicts = conflicts;
    end
end

BestSoln
BestSolnConflicts
BestSolnCost
