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
        
        function addLeftTrackSegment(node, trackSegment)
            node.leftTrackSegments = [node.leftTrackSegments, trackSegment];
        end
        
        function addRightTrackSegment(node, trackSegment)
            node.rightTrackSegments = [node.rightTrackSegments, trackSegment];
        end
        
        function ts = getShortestTrackSegment(node, direction)
            ts = TrackSegment.empty;
            
            if (direction == node.LEFT)
               list = node.leftTrackSegments;
            else
               list = node.rightTrackSegments;
            end
            
            [m, length] = size(list);
            for i = 1:length
                if (isempty(ts) || ts.getLength() > list(i).getLength())
                    ts = list(i);
                end
            end
        end
    end
    
end % classdef