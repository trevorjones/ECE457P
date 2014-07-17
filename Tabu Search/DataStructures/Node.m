%% Node
%  Will either be a junction or a station

%% System and how it will work
% - A train will start at a station with a desired departure time
% - Each train will be removed from the ordered list and sent to the next
%   node while updating their delay if they left later than their arrival
%   times
% - This is done for every train in the current node until the node is
%   empty and then we progress to the next node and do the same

classdef Node < handle
    enumeration
       STATION, JUNCTION 
    end
    
    properties
        type; % junction or station
        leftTrackSegments = [];
        rightTrackSegments = [];
        waitingTrains = [];
    end
    
    methods
        % Constructor
        function node = Node(type)
            if nargin > 0
               node.type = type; 
            end
        end
        
        function addLeftTrackSegment(node, trackSegment)
            node.leftTrackSegments = [node.leftTrackSegments, trackSegment];
        end
        
        function addRightTrackSegment(node, trackSegment)
            node.rightTrackSegments = [node.rightTrackSegments, trackSegment];
        end
        
        function addWaitingTrain(node, train)
            %% TODO: Change this to an ordered linked list
           node.waitingTrains = [node.waitingTrains, train]; 
        end
        
        function [train] = getNextTrain(node) %% This is what tabu search will modify
            %% TODO = Make this an ordered list of trains in order of most
            %% delay seen to least delay seen
        end
    end
    
end % classdef