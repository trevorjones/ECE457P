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

T = 100;
while(T > 0)
    disp('-------------------------- Start Iteration --------------------------')
    T %print
    newDelay = curDelay;
    
    cons = find(curConflicts);
    if(length(cons > 0))
        curConflicts %print
        rCon = cons(randi([1,length(cons)]));
        newDelay(rCon) = newDelay(rCon) + 1 %print

        [newSolution, newConflicts, newLateness] = rs.genSolutionWithDelay(newDelay);
        newSolution %print
        newConflicts %print

        if (newLateness < bestLateness)
            accProb = 1;
        else
            accProb = exp((curLateness - newLateness)/T);
        end
        accRand = randi([0,10000])/10000;

        if (accProb > accRand)
           disp('Accepted!') %print
           accProb % print
           accRand % print
           curLateness = newLateness;
           curConflicts = newConflicts;
           curSolution = newSolution;
           curDelay = newDelay;
        else
            disp('Declined! What now bitch? S my d') % print
        end
        if (curLateness < bestLateness)
           disp('BESTIES!!!!') % print
           bestLateness = curLateness;
           bestConflicts = curConflicts;
           bestSolution = curSolution;
           bestDelay = curDelay;
        end
    else
        disp('Money!') % print
    end
    
    rs.reset();
    T = T - 1;
    disp('-------------------------- Finish Iteration -------------------------')
end

disp(' ')
disp('------------------------ Results ------------------------')
bestSolution
bestDelay
bestLateness
disp('-------------------------- End --------------------------')

clear JUNCTION LEFT RIGHT STATION junction1 junction2 junction3 junction4 station1 station2 station3 train1 train2 train3