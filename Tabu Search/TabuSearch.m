function  [BestSoln BestSolnCost] = TabuSearch(TabuLength, NumIterations)
clearvars

rs = RailwaySystem();
LEFT = 0;
RIGHT = 1;
STATION = 0;
JUNCTION = 1;

% Add junctions and stations
station1 = rs.createNode(STATION);
junction1 = rs.createNode(JUNCTION);
junction2 = rs.createNode(JUNCTION);
station2 = rs.createNode(STATION);
junction3 = rs.createNode(JUNCTION);
junction4 = rs.createNode(JUNCTION);
station3 = rs.createNode(STATION);

% Add track segments
rs.addTrackSegment(station1, junction1, 1);

rs.addTrackSegment(junction1, junction2, 1);
rs.addTrackSegment(junction1, junction2, 1);

rs.addTrackSegment(junction2, station2, 1);

rs.addTrackSegment(station2, junction3, 1);

rs.addTrackSegment(junction3, junction4, 1);
rs.addTrackSegment(junction3, junction4, 1);

rs.addTrackSegment(junction4, station3, 1);

% Add trains
train1 = rs.createTrain(1, station1, station3, RIGHT);
train2 = rs.createTrain(3, station2, station1, LEFT);
train3 = rs.createTrain(3, station2, station1, LEFT);

% Generate ideal solution for each train which is to be used for the optimization function
IdealSolution = rs.genIdealSolution();

% Generate the initial solution given the problem data
rs.reset();
[InitialSolution, lateness] = rs.getSolution();

% Set the best solution to the initial solution
BestSoln = InitialSolution;
BestSolnCost = lateness;

for nIt = 1 : NumIterations
    
            
    % Update the best solution
    if SolnCost < BestSolnCost
        BestSoln = Soln;
        BestSolnCost = SolnCost;
    end
end
