%% Railway System
%  Simulates the entire track from beginning to end and returns the average
%  delay seen by all trains
classdef RailwaySystem < handle    
   properties
       nodes = []; % Nodes should be given in order going from left to right
       trains = [];
       LEFT = 0;
       RIGHT = 1;
   end
   
   methods
       function railwaySystem = RailwaySystem()
           
       end
       
       function nodeId = createNode(railwaySystem, type)
          node = Node(type);
          railwaySystem.nodes = [railwaySystem.nodes, node];
          [m, nodeId] = size(railwaySystem.nodes);           
       end
       
       function addTrackSegment(railwaySystem, leftNodeId, rightNodeId, trackSegmentLength)
           leftNode = railwaySystem.nodes(leftNodeId);
           rightNode = railwaySystem.nodes(rightNodeId);
           trackSegment = TrackSegment(trackSegmentLength, leftNode, rightNode);
           rightNode.addLeftTrackSegment(trackSegment);
           leftNode.addRightTrackSegment(trackSegment);
       end
       
       function trainId = createTrain(railwaySystem, desiredDepartureTime, departureStationId, arrivalStationId, direction)
           train = Train(direction, arrivalStationId);
           railwaySystem.trains = [railwaySystem.trains, train];
           [m, trainId] = size(railwaySystem.trains);
           
           % Add to starting station
           addTrainToNode(railwaySystem, train, departureStationId, desiredDepartureTime);
       end
       
       function addTrainToNode(railwaySystem, train, stationId, arrivalTime)
           railwaySystem.nodes(stationId).addWaitingTrain(train, arrivalTime);
       end
       
       function averageTrainDelay = simulate(railwaySystem)
          %% System and how it will work
          % - A train will start at a station with a desired departure time
          % - Each train will be removed from the ordered list and sent to the next
          %   node while updating their delay if they left later than their arrival
          %   times
          % - This is done for every train in the current node until the node is
          %   empty and then we progress to the next node and do the same 
          averageTrainDelay = 0;
          [m, length] = size(railwaySystem.nodes);
          
          for i = 0:length
              
          end
          
       end
   end
end