%% Train Linked List Node
classdef TrainLinkedListNode < handle
    properties
        train = Train.empty;
        next = TrainLinkedListNode.empty;
    end
    
    methods
        function tlln = TrainLinkedListNode(train)
           if nargin > 0
              tlln.train = train;
           end
        end
        
        function updateNext(tlln, next)
           tlln.next = next; 
        end
        
        function next = getNext(tlln)
           next = tlln.next; 
        end
        
        function train = getTrain(tlln)
            train = tlln.train;
        end
    end
end