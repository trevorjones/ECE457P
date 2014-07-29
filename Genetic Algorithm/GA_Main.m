%% SA
%  Following the Figure 9.1 from http://www.eecs.harvard.edu/~parkes/pubs/ch9.pdf
clearvars
sc = Scenario();
rs = sc.getRS();

% Calculate ideal
IdealSolution = rs.genIdealSolution()
rs.reset();

% Create initial solution
[m, nTrains] = size(rs.trains);
[n, nNodes] = size(rs.nodes);
[curSolution, curConflicts, curLateness] = rs.getSolution();
rs.reset

curSolution
curConflicts
curLateness

P_SIZE = 20;
FITNESS = zeros(P_SIZE, 1);
POP = cell(P_SIZE, 1);
i = 1;
while i <= P_SIZE,
    excludes = [];
    L_CHROM = cell(1, nNodes * nTrains);
    j = 1;
    curDelay = zeros(nTrains, nNodes);
    while j <= nNodes*nTrains,
        v = setdiff(1:nTrains, excludes);
        train = v(ceil(numel(v) * rand));
        d = IdealSolution(train, 1);
        if d == 0 || (d > IdealSolution(train, nNodes) && IdealSolution(train,nNodes) ~= 0)
            x = nNodes;
            while x > 0,
                %get departure time
                d = IdealSolution(train, x);
                if x == nNodes
                   curDelay;
                   curDelay(train, x) = max(curDelay(:,x)) + 1; 
                   
                end
                L_CHROM{j} = {train,x};
                x = x - 1;
                j = j + 1;
            end
        else
            x = 1;
            while x <= nNodes,
                %get departure time
                d = IdealSolution(train, x);
                if x == 1
                   curDelay;
                   curDelay(train, x) = max(curDelay(:,x)) + 1; 
                   
                end
                 L_CHROM{j} = {train,x};
                x = x +1;
                j = j + 1;
            end
        end
        excludes = [excludes train];
    end
    curDelay = curDelay - 1;
    [newSolution, newConflicts, newLateness] = rs.genSolutionWithDelay(curDelay);
    FITNESS(i) = newLateness;
    POP{i} = {L_CHROM};
    i = i + 1;
    rs.reset();
end

F1 = FITNESS;
newSolution
newLateness
F1
i = 1;
while range(FITNESS) ~= 0,
    
    %Selection
    j = 1;
    NEW_GEN = cell(P_SIZE, 1);
    while j <= P_SIZE,
        challenger1 = randi([1,P_SIZE]);
        challenger2 = randi([1,P_SIZE]);
        if FITNESS(challenger1) < FITNESS(challenger2)
            NEW_GEN{j} = POP{challenger1};
        else
            NEW_GEN{j} = POP{challenger2};
        end
        j = j + 1;
    end
    
    
    
%     j = 1;
%     while j <= P_SIZE,
%         celldisp(NEW_GEN(j))
%         P1 = NEW_GEN(j);
%         P2 = NEW_GEN(j+1);
%         
      %{  p_x = rand(1);
%         if (p_x < 0.8)
%            x_point = randi([1, nNodes * nTrains]);
%            x_point2 = randi([x_point, nNodes * nTrains]);
%            
%            CHILD1 = cell(1, nNodes * nTrains);
%            CHILD2 = cell(1, nNodes * nTrains);
%            
%            celldisp(P1)
%            savedValues = zeros(x_point2 - x_point, 2);
%            index = 1;
%            for n=x_point:x_point2,
%                 CHILD1{n} = {P1{1}{n}{1}, P1{1}{n}{2}};
%                 savedValues(index) = [P1{1}{n}{1} P1{1}{n}{2}];
%                 index = index + 1;
%            end
%            
%            celldisp(P2)
%            n = x_point2 + 1;
%            while n ~= x_point2,
%                if n > nNodes * nTrains
%                    n = 1;
%                end
%                p11 = P1{1}{n}{1};
%                p12 = P1{1}{n}{2};
%                p21 = P2{1}{n}{1};
%                p22 = P2{1}{n}{2};
%                found = 0;
%                for w=1:x_point2 - x_point,
%                   if savedValues(w,1) == p21 || savedValues(w,2) == p22
%                       found = 1;
%                       break
%                   end
%                end
%                if found == 0
%                   CHILD1{n} = {p21 p22}; 
%                end
%                n = n + 1;
%            end
%         end
%         
%         j = j + 2;
%     end
%     
    
%     Crossover 1 Point at Random k
    j = 1;
    while j <= P_SIZE,
      celldisp(NEW_GEN(j))
      P1 = NEW_GEN{j};
      celldisp(NEW_GEN(j + 1));
      P2 = NEW_GEN{j + 1};
      
      p_x = rand(1);
      if (p_x < 0.8)
           x_point = randi([1, nNodes * nTrains]);
           CHILD1 = cell(1, nNodes * nTrains);
           CHILD2 = cell(1, nNodes * nTrains);
           celldisp(P1)
           for n=1:x_point,
              CHILD1{n} = {P1{1}{n}{1}, P1{1}{n}{2}};
           end
           celldisp(P2)
           for n=x_point+1:nNodes * nTrains,
             CHILD1{n} = {P2{1}{n}{1}, P2{1}{n}{2}};
           end
           celldisp(P1)
           for n=1:x_point,
              CHILD2{n} = {P2{1}{n}{1}, P2{1}{n}{2}};
           end
           celldisp(P1)
           for n=x_point+1:nNodes * nTrains,
              CHILD2{n} = {P1{1}{n}{1}, P1{1}{n}{2}};
           end
           NEW_GEN{j} = {CHILD1};
          NEW_GEN{j + 1} = {CHILD2};
     end
      j = j + 2;
    end
    
    %Mutation
    
   
    %Evaluate Population
    y = 1;
    while y <= P_SIZE,
       celldisp(NEW_GEN(y));
       L = NEW_GEN{y};
       b = 1;
       curDelay = zeros(nTrains, nNodes);
       celldisp(L);
       while b <= nTrains * nNodes,
           chromosome = [0 0];
           chromosome(1) = L{1}{b}{1};
           chromosome(2) = L{1}{b}{2};
           d = IdealSolution(chromosome(1), chromosome(2));
           if chromosome(2) == 1 && IdealSolution(chromosome(1), 1) ~= 0
              if d < IdealSolution(chromosome(1), nNodes) || IdealSolution(chromosome(1), nNodes) == 0
                  curDelay(chromosome(1), chromosome(2)) = max(curDelay(:,chromosome(2))) + 1; 
              end
           elseif chromosome(2) == nNodes && IdealSolution(chromosome(1), nNodes) ~= 0
              curDelay(chromosome(1), chromosome(2)) = max(curDelay(:,chromosome(2))) + 1;
           end
           b = b + 1;
       end
       curDelay = curDelay - 1;
       [newSolution, newConflicts, newLateness] = rs.genSolutionWithDelay(curDelay);
       FITNESS(y) = newLateness;
       y = y + 1;
       rs.reset();
    end
   FITNESS
   POP = NEW_GEN;
   i = i + 1; 
end

F2 = FITNESS;




