%% Tabu List

classdef TabuList < handle
   properties
       head = TabuListNode.empty;
       tail = TabuListNode.empty;
   end
   
   methods
       function tl = TrainLinkedList()
           tl.size = 0;
       end
       
       function insert(tl, delay, tabuLength)
           tln = TabuListNode(delay, tabuLength+1);
           
           if (isempty(tl.head))
              tl.head = tln;
              tl.tail = tln;
           else
              tl.tail.updateNext(tln);
              tl.tail = tln;
           end
           
           % Update the rest of the list
           tl.updateList();
       end
       
       function updateList(tl)
          curNode = tl.head;
          
          while (~isempty(curNode))
              toDelete = curNode.decrementTabuLength();
              if toDelete == 1
                  tl.deleteHead(); % will always be head first
              end
              
              curNode = curNode.getNext();
          end
       end
       
       function deleteHead(tl)
          prevNode = tl.head;
          tl.head = tl.head.getNext();
          
          if tl.tail == prevNode
            tl.tail = tl.head;
          end
       end
       
       function doesExist = checkIfExist(tl, delay)
          doesExist = 0;
          curNode = tl.head;
          
          while (~isempty(curNode))
            if (curNode.getDelay() == delay)
              doesExist = 1;
              return;
            end
            
            curNode = curNode.getNext();
          end
       end
   end
end
