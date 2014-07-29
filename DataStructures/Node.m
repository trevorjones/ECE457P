%% Node
%  Will either be a junction or a station

classdef Node < handle    
    properties
        type; % junction or station
        id;
        leftTrackSegments = [];
        rightTrackSegments = [];
        delay = [];
        LEFT = 0;
        RIGHT = 1;
        STATION = 0;
        JUNCTION = 1;
    end
    
    methods
        % Constructor
        function node = Node(id, type)
            if nargin > 0
               node.type = type;
               node.id = id;
            end
        end
        
        function id = getId(node)
           id = node.id; 
        end
        
        function numSegs = getNumRightTrackSegs(node)
            [n, numSegs] = size(node.rightTrackSegments);
        end
        
        function numSegs = getNumLeftTrackSegs(node)
            [n, numSegs] = size(node.leftTrackSegments);
        end
        
        function reset(node)
            node.delay = [];
            [n, mTS] = size(node.rightTrackSegments);
            for i = 1:mTS
                ts = node.rightTrackSegments(i);
                ts.reset();
            end
        end
        
        function addLeftTrackSegment(node, trackSegment)
            node.leftTrackSegments = [node.leftTrackSegments, trackSegment];
        end
        
        function addRightTrackSegment(node, trackSegment)
            node.rightTrackSegments = [node.rightTrackSegments, trackSegment];
        end
        
        function [time, conflict, prevTrainIdWithConflict, prevNodeId] = moveTrainToNextNodeOnNextAvailableTrackSegment(node, train, ideal)
            % Get track segment to take
            ts = TrackSegment.empty;
            time = train.getNodeArrivalTime();
            direction = train.getDirection();
            conflict = 0;
            prevTrainIdWithConflict = 0;
            prevNodeId = 0;
            
            if (direction == node.LEFT)
               list = node.leftTrackSegments;
            else
               list = node.rightTrackSegments;
            end
            
            [m, length] = size(list);
            for i = 1:length
                if (isempty(ts) || ts.getBusyUntil() > list(i).getBusyUntil())                    
                    ts = list(i);
                end
            end
            
            % Assign train to track segment
            if (ideal == 0 && time < ts.getBusyUntil())
                time = ts.getBusyUntil();
                % conflict arose if here
                conflict = 1;
                prevTrain = ts.getLastTrainToGo();
                prevTrainIdWithConflict = prevTrain.getId();
                prevNodeId = prevTrain.getPrevNode().getId();
            end
                       
            time = ts.assignTrain(train, time);
            node2 = ts.getNode(direction);
                       
            % Move to next node
            train.setCurrentNode(node2, time);
        end
        
        function setDelay(node, delay)
            node.delay = delay;
        end
        
        function time = getTrainDelay(node, train)
           time = 0;
           trainId = train.getId();
           [m,n] = size(node.delay);
           
           if (m > 0)
               d = node.delay(trainId);

               % Check for a delay
               if (d > 0)
                   time = d;
                   node.delay(trainId) = 0;
               end
           end
        end
    end
    
end % classdef