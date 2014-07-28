%% Tabu List Node
classdef TabuListNode < handle
    properties
        delay = 0;
        tabuLength = 0;
        next = TabuListNode.empty;
    end
    
    methods
        function tln = TabuListNode(delay, tabuLength)
           if nargin > 0
              tlln.train = train;
           end
        end
        
        function delay = getDelay(tln)
          delay = tln.delay;
        end
        
        function toDelete = decrementTabuLength(tln)
          toDelete = 0;
          tln.tabuLength = tln.tabuLength - 1;
          
          if (tln.tabuLength == 0)
            toDelete = 1;
          end
        end
        
        function updateNext(tln, next)
          tln.next = next;
        end
        
        function next = getNext(tln)
          next = tln.next;
        end
    end
end
