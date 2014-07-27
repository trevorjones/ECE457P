%% Simplified Scenario
%  FOnly 4 nodes
classdef SimplifiedScenario < handle
  properties
    rs = RailwaySystem.empty;
  end
  
  methods
    function scenario = SimplifiedScenario()
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

      % Add track segments
      scenario.rs.addTrackSegment(station1, junction1, 1);

      scenario.rs.addTrackSegment(junction1, junction2, 1);
      scenario.rs.addTrackSegment(junction1, junction2, 1);

      scenario.rs.addTrackSegment(junction2, station2, 1);

      % Add trains
      scenario.rs.createTrain(1, station1, station2, RIGHT);
      scenario.rs.createTrain(3, station2, station1, LEFT);
      scenario.rs.createTrain(4, station2, station1, LEFT);
    end
    
    function rs = getRS(scenario)
      rs = scenario.rs;
    end
  end
end