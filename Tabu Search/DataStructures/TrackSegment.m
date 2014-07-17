%% TrackSegment
%  Represents the track segments in between the nodes

classdef TrackSegment < handle    
    properties
        length = 0;
        busyUntil = 0; % Represents the next time when the track segment will be free
    end
    
    methods
        % Constructor
        function trackSegment = TrackSegment(length)
            if nargin > 0
               trackSegment.length = length;
            end
        end
        
        function assignTrain(trackSegment, currentTime)
           trackSegment.busyUntil = currentTime + trackSegment.length;
        end
        
        function [busyUntil] = getBusyUntil(trackSegment)
           busyUntil = trackSegment.busyUntil; 
        end
    end
    
end % classdef