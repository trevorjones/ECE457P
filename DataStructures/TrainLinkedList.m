%% Train Linked List
% - Keep the trains in order from first arrival to last
% - Pop the one at the start = one that arrived first

classdef TrainLinkedList < handle
   properties
       head = TrainLinkedListNode.empty;
       size = 0;
   end
   
   methods
       function tll = TrainLinkedList()
           tll.size = 0;
       end
       
       function insert(tll, train)
           tlln = TrainLinkedListNode(train);
           tll.size = tll.size + 1;
           
           if (isempty(tll.head))
              tll.head = tlln;
           elseif (tll.head.getTrain().getNodeArrivalTime() > train.getNodeArrivalTime())
              tlln.updateNext(tll.head);
              tll.head = tlln;
           else
               curNode = tll.head;
               prevNode = TrainLinkedListNode.empty;
               
               while ~isempty(curNode)
                   if (curNode.getTrain().getNodeArrivalTime() > train.getNodeArrivalTime())
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
       
       function size = getSize(tll)
           size = tll.size;
       end
       
       function tlln = getHead(tll)
           tlln = tll.head;
       end
       
       function tlln = pop(tll)
           tlln = TrainLinkedListNode.empty;
           if ~isempty(tll.head)
               tlln = tll.head;
               tll.head = tll.head.getNext();
               tll.size = tll.size - 1;
           end
       end
   end
end