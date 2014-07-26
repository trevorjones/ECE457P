%% TrackSegment
%  Represents the track segments in between the nodes

classdef TrackSegment < handle    
    properties
        length = 0;
        busyUntil = 0; % Represents the next time when the track segment will be free
        leftNode = Node.empty;
        rightNode = Node.empty;
        LEFT = 0;
        RIGHT = 1;
    end
    
    methods
        % Constructor
        function trackSegment = TrackSegment(length, leftNode, rightNode)
            if nargin > 0
               trackSegment.length = length;
               trackSegment.leftNode = leftNode;
               trackSegment.rightNode = rightNode;
            end
        end
        
        function assignTrain(trackSegment, currentTime)
           trackSegment.busyUntil = currentTime + trackSegment.length;
        end
        
        function busyUntil = getBusyUntil(trackSegment)
           busyUntil = trackSegment.busyUntil; 
        end
        
        function rightNode = getRightNode(trackSegment)
            rightNode = trackSegment.rightNode;
        end
        
        function leftNode = getLeftNode(trackSegment)
            leftNode = trackSegment.leftNode;
        end
        
        function length = getLength(trackSegment)
            length = trackSegment.length;
        end
        
        function node = getNode(trackSegment, direction)
            if (direction == trackSegment.LEFT)
                node = trackSegment.leftNode;
            else
                node = trackSegment.rightNode;
            end
        end
    end
    
end % classdef