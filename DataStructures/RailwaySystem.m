%% Railway System
%  Simulates the entire track from beginning to end and returns the average
%  delay seen by all trains
classdef RailwaySystem < handle    
   properties
       nodes = []; % Nodes should be given in order going from left to right
       trains = [];
       LEFT = 0;
       RIGHT = 1;
       conflicts = [];
       timeOrderedTrains = TrainLinkedList.empty;
   end
   
   methods
       function railwaySystem = RailwaySystem()
          railwaySystem.timeOrderedTrains = TrainLinkedList();
       end
       
       function nodeId = createNode(railwaySystem, type)
          [m, nodeId] = size(railwaySystem.nodes);
          nodeId = nodeId+1;
          
          node = Node(nodeId, type);
          railwaySystem.nodes = [railwaySystem.nodes, node];
       end
       
       function nTrains = getNumTrains(rs)
           [n, nTrains] = size(rs.trains);
       end
       
       function addTrackSegment(railwaySystem, leftNodeId, rightNodeId, trackSegmentLength)
           leftNode = railwaySystem.nodes(leftNodeId);
           rightNode = railwaySystem.nodes(rightNodeId);
           trackSegment = TrackSegment(trackSegmentLength, leftNode, rightNode);
           rightNode.addLeftTrackSegment(trackSegment);
           leftNode.addRightTrackSegment(trackSegment);
       end
       
       function trainId = createTrain(railwaySystem, desiredDepartureTime, departureStationId, arrivalStationId, direction)
           trainId = railwaySystem.timeOrderedTrains.getSize()+1;
           
           arrivalStation = railwaySystem.nodes(arrivalStationId);
           departureStation = railwaySystem.nodes(departureStationId);
           train = Train(trainId, direction, desiredDepartureTime, departureStation, arrivalStation);
           railwaySystem.timeOrderedTrains.insert(train);
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
          railwaySystem.conflicts = zeros(nTrains, nNodes);
           
          idealSolution = railwaySystem.genSolutionWithDepartureTimes();
          trainNode = railwaySystem.timeOrderedTrains.getHead();
          
          while ~isempty(trainNode)
              train = trainNode.getTrain();
              i = train.getId();
              node = train.getCurrentNode();
              
              while (node ~= train.getDestinationStation())                
                % Calculate time it will take to travel it and update
                % matrix
                time = train.getCurrentNode().moveTrainToNextNodeOnNextAvailableTrackSegment(train, 1);
                node = train.getCurrentNode();
                nodeId = node.getId();
                train.setIdealTime(time);
                idealSolution(i + nTrains*(nodeId-1)) = time;
              end
              
              trainNode = trainNode.getNext();
          end
       end
       
       function [solution] = genSolutionWithDepartureTimes(railwaySystem)
           nTrains = railwaySystem.timeOrderedTrains.getSize();
           [n, nNodes] = size(railwaySystem.nodes);
           solution = zeros(nTrains, nNodes);
           trainNode = railwaySystem.timeOrderedTrains.getHead();
           
           while ~isempty(trainNode)
              train = trainNode.getTrain();
              i = train.getId();
              node = train.getCurrentNode();
              
              % Update initial departure time
              time = train.getNodeArrivalTime();
              nodeId = node.getId();
              solution(i + nTrains*(nodeId-1)) = time;
              
              train.setCurrentNode(node, time);
              trainNode = trainNode.getNext();
           end
       end
       
       function reset(railwaySystem)
           % Reset all trains to initial station and time
           [m, nTrains] = size(railwaySystem.trains);
           railwaySystem.timeOrderedTrains = TrainLinkedList();
           [n, nNodes] = size(railwaySystem.nodes);
           railwaySystem.conflicts = zeros(nTrains, nNodes);
           
           for i = 1:nTrains
               train = railwaySystem.trains(i);
               train.setCurrentNode(train.getInitialNode(), train.getInitialDepartureTime());
               railwaySystem.timeOrderedTrains.insert(train);
           end
           
           % Reset all track segment busy times
           [m, nNodes] = size(railwaySystem.nodes);
           for i = 1:nNodes
               railwaySystem.nodes(i).reset();
           end
       end
       
       function [initialSolution, conflicts, lateness] = getSolution(railwaySystem)
           nTrains = railwaySystem.timeOrderedTrains.getSize();
           initialSolution = railwaySystem.genSolutionWithDepartureTimes();
           list = railwaySystem.timeOrderedTrains;
           trainNode = list.pop();
           
           while ~isempty(trainNode)
               train = trainNode.getTrain(); % Shouldn't change the initial list               
               node = train.getCurrentNode();
               
               % Check for delay and re-add to list if there is any
               delay = node.getTrainDelay(train);
               if (delay > 0)
                   time = train.getNodeArrivalTime() + delay;
                   train.setCurrentNode(node, time);
                   list.insert(train);
               elseif (node ~= train.getDestinationStation())
                   [time, conflict, lastTrainId, prevNodeId] = node.moveTrainToNextNodeOnNextAvailableTrackSegment(train, 0);
                   if (conflict == 1)
                       railwaySystem.conflicts(train.getId(), node.getId()) = 1;
                       railwaySystem.conflicts(lastTrainId, prevNodeId) = 1;
                   end
                   
                   i = train.getId();
                   node = train.getCurrentNode();
                   nodeId = node.getId();
                   initialSolution(i + nTrains*(nodeId-1)) = time;
                   list.insert(train);
               end
               
               trainNode = list.pop();
           end
           
           conflicts = railwaySystem.conflicts;
           lateness = calcLateness(railwaySystem);
       end
       
       function lateness = calcLateness(railwaySystem)
           lateness = 0;
           [m, nTrains] = size(railwaySystem.trains);
           
           for i = 1:nTrains
               train = railwaySystem.trains(i);
               lateness = lateness + train.getNodeArrivalTime() - train.getIdealTime();
           end
       end
       
       function [solution, conflicts, lateness] = genSolutionWithDelay(railwaySystem, delay)
           [m, nNodes] = size(railwaySystem.nodes);
           for i = 1:nNodes
               railwaySystem.nodes(i).setDelay(delay(:,i));
           end
           
           [solution, conflicts, lateness] = railwaySystem.getSolution();
       end
   end
end