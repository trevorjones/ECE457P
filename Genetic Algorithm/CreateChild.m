function [ CHILD, savedValues, numIts ] = CreateChild( CHILD, P1, P2, savedValues, x_point, x_point2, nTrains, numIts )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
           celldisp(P1);    
           index = 1;
           for n=x_point:x_point2,
                train = P1{1}{1}{n}{1};
                node = P1{1}{1}{n}{2};
                CHILD{n} = {train, node};
                savedValues(index,1) = train;
                savedValues(index,2)= node;
                index = index + 1;
           end
           
           celldisp(P2);
           n = x_point2 + 1;
           [trainCount c] = size(savedValues);
           while trainCount < 8,
               if n > nTrains
                   n = 1;
               end
               p21 = P2{1}{1}{n}{1};
               p22 = P2{1}{1}{n}{2};
               [r c] = size(savedValues);
               w = 1;
               n_loop = n;
               update_n = 0;
               while w<=r,
                  if savedValues(w,1) == p21
                        %n_loop = n;
                        n_loop = n_loop + 1;
                        if n_loop > nTrains
                            n_loop = 1;
                        end
                        p21 = P2{1}{1}{n_loop}{1}
                        p22 = P2{1}{1}{n_loop}{2}
                        w = 1
                        update_n = 1;
                  else
                      w = w + 1
                  end
                  numIts = numIts + 1;
               end
               CHILD{n} = {p21 p22};
               new_val = [p21 p22];
               savedValues = [savedValues; new_val];
               [r c] = size(savedValues);
               trainCount = r
               if n == x_point2 || r > 8
                    break
               elseif update_n == 1
                   n = n_loop;
               else    
                   n = n + 1;
               end
           end
end

