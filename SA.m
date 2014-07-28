%% SA
%  Following the Figure 9.1 from http://www.eecs.harvard.edu/~parkes/pubs/ch9.pdf

disp(' ')
disp('------------------------------------------------------------')
disp('   ------------------------------------------------------   ')
disp('------------------------------------------------------------')
disp('   ------------------------------------------------------   ')
disp('------------------------------------------------------------')
disp('   ------------------------------------------------------   ')
disp('------------------------------------------------------------')
disp('   ------------------------------------------------------   ')
disp('------------------------------------------------------------')
disp('   ------------------------------------------------------   ')
disp('------------------------------------------------------------')
disp('   ------------------------------------------------------   ')
disp('------------------------------------------------------------')
disp('   ------------------------------------------------------   ')
disp('------------------------------------------------------------')
disp('   ------------------------------------------------------   ')
disp('------------------------ Running SA ------------------------')

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
curDelay = zeros(nTrains, nNodes)
curSolution
curConflicts
curLateness
bestSolution = curSolution;
bestConflicts = curConflicts;
bestLateness = curLateness;
bestDelay = curDelay;
rs.reset();

disp('------------------------ Set Up Completed ------------------------')

T = 10;
while(T > 0)
    disp('------------------------ ------------ ------------------------')
    T
    newDelay = curDelay;

    curConflicts
    
    cons = find(curConflicts);
    rCon = cons(randi([1,length(cons)]));
    newDelay(rCon) = newDelay(rCon) + 1
    
    [newSolution, newConflicts, newLateness] = rs.genSolutionWithDelay(newDelay);
    newConflicts
    
    if (newLateness < bestLateness)
        accProb = 1;
    else
        accProb = exp((curLateness - newLateness)/T);
    end
    accRand = randi([0,10000])/10000;
    
    if (accProb > accRand)
       disp('Accepted!')
       accProb
       accRand
       curLateness = newLateness;
       curConflicts = newConflicts;
       curSolution = newSolution;
       curDelay = newDelay;
    end
    if (curLateness < bestLateness)
       disp('BESTIES!!!!')
       bestLateness = curLateness;
       bestConflicts = curConflicts;
       bestSolution = curSolution;
       bestDelay = curDelay;
    end
    
    rs.reset();
    T = T - 1;
end

disp('------------------------ Results ------------------------')
bestDelay
bestLateness
disp('-------------------------- End --------------------------')

clear JUNCTION LEFT RIGHT STATION junction1 junction2 junction3 junction4 station1 station2 station3 train1 train2 train3