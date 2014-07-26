%% Node
%  Will either be a junction or a station

classdef Node < handle    
    properties
        type; % junction or station
        id;
        leftTrackSegments = [];
        rightTrackSegments = [];
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
        
        function reset(node)
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
        
        function time = moveTrainToNextNodeOnNextAvailableTrackSegment(node, train, ideal)
            % Get track segment to take
            ts = TrackSegment.empty;
            time = train.getNodeArrivalTime();
            direction = train.getDirection();
            
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
            end
            
            time = ts.assignTrain(time);
            node2 = ts.getNode(direction);
            
            % Move to next node
            train.setCurrentNode(node2, time);
        end
    end
    
end % classdef