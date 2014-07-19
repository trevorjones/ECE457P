%% Simulation
%  Following the Figure 9.1 from http://www.eecs.harvard.edu/~parkes/pubs/ch9.pdf

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
train1 = rs.createTrain(0, station1, station3, RIGHT);

% Simulate
rs.simulate()