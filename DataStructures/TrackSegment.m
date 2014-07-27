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
        lastTrainToGo = Train.empty;
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
        
        function time = assignTrain(trackSegment, train, currentTime)
           time = currentTime + trackSegment.length;
           trackSegment.busyUntil = time;
           trackSegment.lastTrainToGo = train;
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
        
        function reset(trackSegment)
            trackSegment.busyUntil = 0;
        end
        
        function train = getLastTrainToGo(ts)
            train = ts.lastTrainToGo;
        end
    end
    
end % classdef