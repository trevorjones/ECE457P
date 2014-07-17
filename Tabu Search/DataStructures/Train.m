%% Train
classdef Train < handle
   properties
       desiredDepartureTime = 0;
       departureStation;
       arrivalStation;
       delay = 0;
       nodeArrivalTime = 0; % Updated for every node that a train hits
   end
    
   methods
       % Constructor
       function train = Train(desiredDepartureTime, departureStation, arrivalStation)
          if nargin > 0
             train.desiredDepartureTime = desiredDepartureTime;
             train.departureStation = departureStation;
             train.arrivalStation = arrivalStation;
          end
       end
       
       function addDelay(train, delay)
          train.delay = train.delay + delay; 
       end

       function [delay] = getDelay(train)
           delay = train.delay;
       end
       
       function [desiredDepartureTime] = getDesiredDepartureTime(train)
           desiredDepartureTime = train.desiredDepartureTime;
       end
       
       function [departureStation] = getDepartureStation(train)
           departureStation = train.departureStation;
       end
       
       function [arrivalStation] = getArrivalStation(train)
           arrivalStation = train.arrivalStation;
       end
       
       function setNodeArrivalTime(train, time)
          train.nodeArrivalTime = time; 
       end
       
       function [nodeArrivalTime] = getNodeArrivalTime(train)
           nodeArrivalTime = train.nodeArrivalTime;
       end
   end
end