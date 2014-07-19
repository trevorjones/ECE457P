%% Train
classdef Train < handle
   properties
       departureStation;
       arrivalStation;
       direction;
       initialDepartureTime = 0;
       finalArrivalTime = 0;
       optimalTravelTime = 0;
       nodeArrivalTime = 0; % Updated for every node that a train hits
   end
    
   methods
       % Constructor
       function train = Train(direction, arrivalStation)
          if nargin > 0
             train.direction = direction;
             train.arrivalStation = arrivalStation;
          end
       end
       
       function addDelay(train, delay)
          train.delay = train.delay + delay; 
       end

       function delay = getDelay(train)
           delay = train.delay;
       end
       
       function direction = getDirection(train)
          direction = train.direction; 
       end
       
       function arrivalStation = getArrivalStation(train)
           arrivalStation = train.arrivalStation;
       end
       
       function setNodeArrivalTime(train, time)
          train.nodeArrivalTime = time; 
       end
       
       function nodeArrivalTime = getNodeArrivalTime(train)
           nodeArrivalTime = train.nodeArrivalTime;
       end
   end
end