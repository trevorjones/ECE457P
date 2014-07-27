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
curDelay = zeros(nTrains, nNodes)
curSolution
curConflicts
curLateness
bestSolution = curSolution;
bestConflicts = curConflicts;
bestLateness = curLateness;
bestDelay = curDelay;
rs.reset();

T = 100;
while(T > 0)
    newDelay = curDelay;

    rTrain = randi([1,nTrains]);
    rNode = randi([1,nNodes]);
    newDelay(rTrain,rNode) = curDelay(rTrain,rNode) + 1;
    
    [newSolution, newConflicts, newLateness] = rs.genSolutionWithDelay(newDelay);
    newLateness;
    curLateness;
    bestLateness;
    
    if (newLateness < bestLateness)
        accProb = 1;
    else
        accProb = exp((curLateness - newLateness)/T);
    end
    if (accProb > randi([0,10000])/10000)
       T;
       curLateness = newLateness;
       curConflicts = newConflicts;
       curSolution = newSolution;
       curDelay = newDelay;
    end
    if (curLateness < bestLateness)
       bestLateness = curLateness;
       bestConflicts = curConflicts;
       bestSolution = curSolution;
       bestDelay = curDelay;
    end
    
    rs.reset();
    T = T - 1;
end

bestDelay
bestLateness

clear JUNCTION LEFT RIGHT STATION junction1 junction2 junction3 junction4 station1 station2 station3 train1 train2 train3