%% Random Trains
classdef RandomTrains < handle
  properties
    rs = RailwaySystem.empty;
  end
  
  methods
    function scenario = RandomTrains(numTrains, latestDep, numStations)
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
      
      if(numStations == 4)
          junction5 = scenario.rs.createNode(JUNCTION);
          junction6 = scenario.rs.createNode(JUNCTION);
          station4 = scenario.rs.createNode(STATION);
          scenario.rs.addTrackSegment(station3, junction5, 1);
          scenario.rs.addTrackSegment(junction5, junction6, 1);
          scenario.rs.addTrackSegment(junction5, junction6, 1);
          scenario.rs.addTrackSegment(junction6, station4, 1);
      end
      
      i = numTrains;
      while(i > 0)
          direction = chooseDirection(scenario);
          if(numStations == 3)
              [startStat, endStat] = chooseStations3(scenario, direction, station1, station2, station3);
          else
              [startStat, endStat] = chooseStations4(scenario, direction, station1, station2, station3, station4);
          end
          scenario.rs.createTrain(randi([0,latestDep]),startStat,endStat,direction);
          i = i - 1;
      end
    end
    
    function [start, endS] = chooseStations3(scenario, direction, station1, station2, station3)
        LEFT = 0;
        RIGHT = 1;
        if(direction == LEFT)
            startNum = randi([2,3]);
            if(startNum == 2)
                start = station2;
                endS = station1;
            else
                start = station3;
                if(randi([1,2]) == 1)
                    endS = station1;
                else
                    endS = station2;
                end
            end
        else
            startNum = randi([1,2]);
            if(startNum == 2)
                start = station2;
                endS = station3;
            else
                start = station1;
                if(randi([2,3]) == 3)
                    endS = station3;
                else
                    endS = station2;
                end
            end
        end
    end
    
    function [start, endS] = chooseStations4(scenario, direction, station1, station2, station3, station4)
        LEFT = 0;
        RIGHT = 1;
        if(direction == LEFT)
            startNum = randi([2,4]);
            if(startNum == 2)
                start = station2;
                endS = station1;
            elseif(startNum == 3)
                start = station3;
                if(randi([1,2]) == 1)
                    endS = station1;
                else
                    endS = station2;
                end
            else
                start = station4;
                rando = randi([1,3]);
                if(rando == 1)
                    endS = station1;
                elseif(rando == 2)
                    endS = station2;
                else
                    endS = station3;
                end
            end
        else
            startNum = randi([1,3]);
            if(startNum == 3)
                start = station3;
                endS = station4;
            elseif(startNum == 2)
                start = station2;
                if(randi([3,4]) == 3)
                    endS = station3;
                else
                    endS = station4;
                end
            else
                start = station1;
                rando = randi([2,4]);
                if(rando == 2)
                    endS = station2;
                elseif(rando == 3)
                    endS = station3;
                else
                    endS = station4;
                end
            end
        end
    end
    
    function direction = chooseDirection(scenario)
        LEFT = 0;
        RIGHT = 1;
        if(randi([0,1]) == 0)
           direction = LEFT;
       else
           direction = RIGHT;
       end
    end
    
    function rs = getRS(scenario)
      rs = scenario.rs;
    end
  end
end
