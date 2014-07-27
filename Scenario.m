%% Scenario
%  Following the Figure 9.1 from http://www.eecs.harvard.edu/~parkes/pubs/ch9.pdf
classdef Scenario < handle
  properties
    rs = RailwaySystem.empty;
  end
  
  methods
    function scenario = Scenario()
      scenario.rs = RailwaySystem();
      LEFT = 0;
      RIGHT = 1;
      STATION = 0;
      JUNCTION = 1;

      % Add junctions and stations
      station1 = scenario.rs.createNode(STATION);
      junction1 = scenario.rs.createNode(JUNCTION);
      junction2 = scenario.rs.createNode(JUNCTION);
      station2 = scenario.rs.createNode(STATION);
      junction3 = scenario.rs.createNode(JUNCTION);
      junction4 = scenario.rs.createNode(JUNCTION);
      station3 = scenario.rs.createNode(STATION);

      % Add track segments
      scenario.rs.addTrackSegment(station1, junction1, 1);

      scenario.rs.addTrackSegment(junction1, junction2, 1);
      scenario.rs.addTrackSegment(junction1, junction2, 1);

      scenario.rs.addTrackSegment(junction2, station2, 1);

      scenario.rs.addTrackSegment(station2, junction3, 1);

      scenario.rs.addTrackSegment(junction3, junction4, 1);
      scenario.rs.addTrackSegment(junction3, junction4, 1);

      scenario.rs.addTrackSegment(junction4, station3, 1);

      % Add trains
      scenario.rs.createTrain(1, station1, station3, RIGHT);
      scenario.rs.createTrain(3, station2, station1, LEFT);
      scenario.rs.createTrain(3, station2, station1, LEFT);
    end
    
    function rs = getRS(scenario)
      rs = scenario.rs;
    end
  end
end
