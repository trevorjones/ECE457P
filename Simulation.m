%% Simulation
%  Following the Figure 9.1 from http://www.eecs.harvard.edu/~parkes/pubs/ch9.pdf
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

% Simulate
IdealSolution = rs.genIdealSolution()

rs.reset();
[InitialSolution, conflicts, lateness] = rs.getSolution();
InitialSolution
conflicts
lateness

rs.reset();
%% Swap
%  Done with delays. Ex: if train 1, 2, and 3 need to use the track between
%  nodes 3 and 4, and you want train 3 to go, then 2, then 1, you must send
%  the following array to delay train 1 by 2 at station 3, and 1 for train
%  2 to be delayed by 1 at station 4
delay = [0, 0, 0, 0, 0, 0, 0;
         0, 0, 0, 1, 0, 0, 0;
         0, 0, 0, 2, 0, 0, 0];
[solution, conflicts, lateness] = rs.genSolutionWithDelay(delay);
solution
conflicts
lateness