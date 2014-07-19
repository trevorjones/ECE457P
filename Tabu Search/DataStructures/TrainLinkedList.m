%% Train Linked List
% - Keep the trains in order from first arrival to last
% - Pop the one at the start = one that arrived first

classdef TrainLinkedList < handle
   properties
       head = TrainLinkedListNode.empty;
   end
   
   methods
       function tll = TrainLinkedList()
           
       end
       
       function insert(tll, train)
           tlln = TrainLinkedListNode(train);
           
           if isempty(tll.head)
              tll.head = tlln;
           else
               curNode = tll.head;
               prevNode = TrainLinkedListNode.empty;
               
               while ~isempty(curNode)
                   if (curNode.getTrain().getArrivalTime() > train.getArrivalTime())
                       prevNode.updateNext(tlln);
                       tlln.updateNext(curNode);
                       return;
                   end
                   
                   prevNode = curNode;
                   curNode = curNode.getNext();
               end
               
               prevNode.updateNext(tlln);
           end
       end
       
       function tlln = pop(tll)
           if ~isempty(tll.head)
               tlln = tll.head;
               tll.head = tll.head.getNext();
           end
       end
   end
end