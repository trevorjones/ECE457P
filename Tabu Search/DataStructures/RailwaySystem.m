%% Railway System
%  Simulates the entire track from beginning to end and returns the average
%  delay seen by all trains
classdef RailwaySystem < handle    
   properties
       nodes = []; % Nodes should be given in order going from left to right
       trains = [];
       LEFT = 0;
       RIGHT = 1;
       timeOrderedTrains = TrainLinkedList.empty;
   end
   
   methods
       function railwaySystem = RailwaySystem()
          if (nargin > 0)
            railwaySystem.timeOrderedTrains = TrainLinkedList();
          end
       end
       
       function nodeId = createNode(railwaySystem, type)
          [m, nodeId] = size(railwaySystem.nodes);
          nodeId = nodeId+1;
          
          node = Node(nodeId, type);
          railwaySystem.nodes = [railwaySystem.nodes, node];
       end
       
       function addTrackSegment(railwaySystem, leftNodeId, rightNodeId, trackSegmentLength)
           leftNode = railwaySystem.nodes(leftNodeId);
           rightNode = railwaySystem.nodes(rightNodeId);
           trackSegment = TrackSegment(trackSegmentLength, leftNode, rightNode);
           rightNode.addLeftTrackSegment(trackSegment);
           leftNode.addRightTrackSegment(trackSegment);
       end
       
       function trainId = createTrain(railwaySystem, desiredDepartureTime, departureStationId, arrivalStationId, direction)
           [m, trainId] = size(railwaySystem.trains);
           trainId = trainId+1;
           
           arrivalStation = railwaySystem.nodes(arrivalStationId);
           departureStation = railwaySystem.nodes(departureStationId);
           train = Train(trainId, direction, desiredDepartureTime, departureStation, arrivalStation);
           railwaySystem.trains = [railwaySystem.trains, train];
       end
       
       %% Solution generation
       %  Returns a matrix of nodes(columns) x trains(rows) and each spot is the time at
       %  which the train arrives at that node.
       %  !! When doing tabu search, only swap trains that arrive at a node
       %  at the same time
       function [idealSolution] = genIdealSolution(railwaySystem)
          [m, nTrains] = size(railwaySystem.trains);
          [n, nNodes] = size(railwaySystem.nodes);
          idealSolution = zeros(nTrains, nNodes);
          
          for i = 1:nTrains
              train = railwaySystem.trains(i);
              node = train.getCurrentNode();
              direction = train.getDirection();
              
              % Update initial departure time
              time = train.getNodeArrivalTime();
              nodeId = node.getId();
              idealSolution(i + nTrains*(nodeId-1)) = time;
              
              while (node ~= train.getDestinationStation())
                % Get track segment to take
                ts = node.getShortestTrackSegment(direction);
                node = ts.getNode(direction);
                
                % Calculate time it will take to travel it and update
                % matrix
                time = time + ts.getLength();
                nodeId = node.getId();
                idealSolution(i + nTrains*(nodeId-1)) = time;
                
                % Move to next node
                train.setCurrentNode(node, time);
              end
          end
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
          
          for i = 1:length
              
          end
          
       end
   end
end