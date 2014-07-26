%% Train
classdef Train < handle
   properties
       destinationStation;
       direction;
       initialDepartureTime = 0;
       finalArrivalTime = 0;
       nodeArrivalTime = 0; % Updated for every node that a train hits
       curNode;
       id;
   end
    
   methods
       % Constructor
       function train = Train(id, direction, desiredDepartureTime, departureStation, destinationStation)
          if nargin > 0
             train.direction = direction;
             train.destinationStation = destinationStation;
             train.id = id;
             train.curNode = departureStation;
             train.nodeArrivalTime = desiredDepartureTime;
          end
       end
       
       function id = getId(train)
          id = train.id; 
       end
       
       function currentNode = getCurrentNode(train)
          currentNode = train.curNode; 
       end
       
       function setCurrentNode(train, node, time)
          train.curNode = node;
          train.nodeArrivalTime = time;
       end
       
       function direction = getDirection(train)
          direction = train.direction; 
       end
       
       function destinationStation = getDestinationStation(train)
           destinationStation = train.destinationStation;
       end
       
       function nodeArrivalTime = getNodeArrivalTime(train)
           nodeArrivalTime = train.nodeArrivalTime;
       end
   end
end