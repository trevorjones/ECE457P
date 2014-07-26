%% Train
classdef Train < handle
   properties
       destinationStation;
       direction;
       initialDepartureTime = 0;
       initialDepartureNode;
       finalArrivalTime = 0;
       nodeArrivalTime = 0;
       idealTime;
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
             train.initialDepartureNode = departureStation;
             train.initialDepartureTime = desiredDepartureTime;
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
       
       function initialNode = getInitialNode(train)
           initialNode = train.initialDepartureNode;
       end
       
       function initialDepartureTime = getInitialDepartureTime(train)
           initialDepartureTime = train.initialDepartureTime;
       end
       
       function setIdealTime(train, time)
           train.idealTime = time;
       end
       
       function time = getIdealTime(train)
           time = train.idealTime;
       end
   end
end