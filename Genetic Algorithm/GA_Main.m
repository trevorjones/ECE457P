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
    L_CHROM = cell(1, nTrains);
    j = 1;
    curDelay = zeros(nTrains, nNodes);
    while j <= nTrains,
        v = setdiff(1:nTrains, excludes);
        train = v(ceil(numel(v) * rand));
        d = IdealSolution(train, 1); %Get Node 1 Value
        copySol = IdealSolution;
        copySol(copySol == 0) = Inf;
        minValue = min(copySol(train,:));
        startNode = find(IdealSolution(train,:) == minValue);
        curDelay(train, startNode) = max(curDelay(:,startNode)) + 1;
        L_CHROM{j} = {train, startNode};
        j = j + 1;
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
%newSolution
%newLateness
F1
%curDelay
i = 1;
F2 = FITNESS;
while range(F2) ~= 0,
%while i < 2,   
    %Selection 2 Man Tournament
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
    
    
    
    j = 1;
    while j <= P_SIZE,
        
        celldisp(NEW_GEN(j))
        P1 = NEW_GEN(j);
        celldisp(NEW_GEN(j+1));
        P2 = NEW_GEN(j+1);
  
        p_x = rand(1);
        if (p_x < 0.8)
           x_point = randi([1, nTrains]);
           x_point2 = randi([x_point, nTrains]);
           
           CHILD1 = cell(1, nTrains);
           CHILD2 = cell(1, nTrains);
           savedValues = zeros(x_point2 - x_point + 1, 2);
           [CHILD1, savedValues] = CreateChild(CHILD1, P1, P2, savedValues, x_point, x_point2, nTrains);
           [CHILD2, savedValues] = CreateChild(CHILD2, P2, P1, savedValues, x_point, x_point2, nTrains);
          
           celldisp(CHILD1)
           celldisp(CHILD2)
        end
        
        j = j + 2;
    end
    
    
%     Crossover 1 Point at Random k
%     j = 1;
%     while j <= P_SIZE,
%       celldisp(NEW_GEN(j))
%       P1 = NEW_GEN{j};
%       celldisp(NEW_GEN(j + 1));
%       P2 = NEW_GEN{j + 1};
%       
%       p_x = rand(1);
%       if (p_x < 0.8)
%            x_point = randi([1, nTrains]);
%            CHILD1 = cell(1, nTrains);
%            CHILD2 = cell(1, nTrains);
%            celldisp(P1)
%            for n=1:x_point,
%               CHILD1{n} = {P1{1}{n}{1}, P1{1}{n}{2}};
%            end
%            celldisp(P2)
%            for n=x_point+1:nTrains,
%              CHILD1{n} = {P2{1}{n}{1}, P2{1}{n}{2}};
%            end
%            celldisp(P1)
%            for n=1:x_point,
%               CHILD2{n} = {P2{1}{n}{1}, P2{1}{n}{2}};
%            end
%            celldisp(P1)
%            for n=x_point+1: nTrains,
%               CHILD2{n} = {P1{1}{n}{1}, P1{1}{n}{2}};
%            end
%            NEW_GEN{j} = {CHILD1};
%            NEW_GEN{j + 1} = {CHILD2};
%      end
%       j = j + 2;
%     end
    
    %Mutation
    j = 1;
    while j < P_SIZE
        p_mut = rand(1);
        if p_mut < 0.1
            celldisp(NEW_GEN(j));
            L = NEW_GEN{j};
            celldisp(L)
            k1 = randi([1,nTrains]);
            k2 = randi([1,nTrains]);
            while k2 == k1,
                k2 = randi([1,nTrains]);
            end
            temp = L{1}{k1};
            L{1}{k1} = L{1}{k2};
            L{1}{k2} = temp;
        end
        j = j + 1;
    end
    
    %Evaluate Population
    y = 1;
    while y <= P_SIZE,
       celldisp(NEW_GEN(y));
       L = NEW_GEN{y};
       b = 1;
       curDelay = zeros(nTrains, nNodes);
       celldisp(L);
       while b <= nTrains,
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
   F2 = FITNESS;
   POP = NEW_GEN;
   i = i + 1; 
end
F1
F2
i




