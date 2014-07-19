%% Node
%  Will either be a junction or a station

classdef Node < handle    
    properties
        type; % junction or station
        leftTrackSegments = [];
        rightTrackSegments = [];
        waitingTrains = TrainLinkedList.empty;
        STATION = 0;
        JUNCTION = 1;
    end
    
    methods
        % Constructor
        function node = Node(type)
            if nargin > 0
               node.type = type;
               node.waitingTrains = TrainLinkedList();
            end
        end
        
        function addLeftTrackSegment(node, trackSegment)
            node.leftTrackSegments = [node.leftTrackSegments, trackSegment];
        end
        
        function addRightTrackSegment(node, trackSegment)
            node.rightTrackSegments = [node.rightTrackSegments, trackSegment];
        end
        
        function addWaitingTrain(node, train, arrivalTime)
            train.setNodeArrivalTime(arrivalTime);
            node.waitingTrains.insert(train);
        end
        
        function trackSegment = getNextTrackSegment(node) %% TS will also modify this
            
        end
        
        function train = getNextTrain(node) %% This is what tabu search will modify
            train = node.waitingTrains.pop();
        end
    end
    
end % classdef